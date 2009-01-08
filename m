From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] Add initial support of Mitac
	mioa701	device SoC.
Date: Thu, 8 Jan 2009 20:33:25 +0000
Message-ID: <20090108203324.GB29183@sirena.org.uk>
References: <1231440146-6669-1-git-send-email-robert.jarzmik@free.fr>
	<1231440146-6669-2-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5EF1224365
	for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2009 21:33:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1231440146-6669-2-git-send-email-robert.jarzmik@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 08, 2009 at 07:42:25PM +0100, Robert Jarzmik wrote:

> This machine driver enables sound functions on Mitac mio
> a701 smartphone. Build upon ASoC v1, it handles :

It'd probably be easier to split this up still further, with one patch
providing a standard ASoC machine and another adding the scenario stuff
after that.

As well as easing review I have to say that I'm a bit unenthusiastic
about having the scenario stuff in here.  The general plan was to do
this in user space, partly because experience with things like OpenMoko
suggests that some users are going to come up with new and exciting
scenarios and that having to rebuild the kernel is too high a barrier.
I know Graeme has said he regrets doing the in-kernel scenarios there.

Liam's ALSA scenario API was intended to do what's needed in user space:

	http://opensource.wolfsonmicro.com/node/14

though it's still a work in progress.  I'm not 100% against doing this
like you have since we don't have a clear solution right now but I'd
like to stop and think about it.

If we are going to do it in kernel space then it'd be better to lift at
least some of it out of your driver since the mechanics of what you've
got aren't very specific to this machine, just the lists of endpoints.
I'd also suggest masking off the controls you're controlling via the
scenario stuff from user space - Takashi has commit
03ad1d710ea51a51dfbe62caa2bc9a9437ae3fed in his sound-unstable-2.6.git
which adds snd_ctl_activate_id(), allowing drivers to do this.

More comments below, mostly very nitpicky:

> It doesn't cope with :
>  - headset jack (will be integrade after jack support has
>    hit ASoC v2)

I just pushed an implementation of that just now, enjoy :)

> +#define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)

This is also defined somewhere or other in the PXA or ARM architecture
code - there's a danger of multiple definitions of the macro appearing.
checkpatch wants extra () too, I kind of agree with it.

> +void setup_muxers(struct snd_soc_codec *codec, const struct mio_mixes_t mixes[])
> +{
> +	int pos = 0;
> +	struct snd_kcontrol *kctl;
> +	struct snd_ctl_elem_value ucontrol;
> +	char mname[44];
> +
> +	while (mixes[pos].mixname) {

A for loop over the ARRAY_SIZE() might be more idiomatic here...

> +		memset(mname, 0, 44);
> +		strncpy(mname, mixes[pos].mixname, 43);

It's bikesheding but strcpy plus termination would do the job, wouldn't
it?

> +               if (kctl) {

Shouldn't we at least warn if this is false, it's an error in the static
data for the maps.

> +                       kctl->get(kctl, &ucontrol);
> +                       ucontrol.value.enumerated.item[0] = mixes[pos].val;
> +                       kctl->put(kctl, &ucontrol);
> +               }

Does an open application (eg, alsamixer) notice these changes without
the driver telling it?  snd_ctl_notify() is the API call, IIRC though
there's a reasonable chance I am misremembering.  Though if you do mask
them from user space it shoudn't matter anyway, I expect.

> +		{ 0, 0, 1, 1, 1, 0, 1 }, /* MIO_GSM_AUDIO_HEADSET	*/
> +		{ 0, 1, 1, 1, 0, 1, 0 }, /* MIO_GSM_AUDIO_HANDSFREE*/
> +		{ 0, 0, 1, 1, 0, 0, 0 }, /* MIO_GSM_AUDIO_BLUETOOTH*/

Interesting indentation?

> +static int isPhoneMode(int scenario)
> +{
> +	int onPhone = 0;

The kernel doesn't generally go in for mixedCaseNames except when
following standards that use them.

> +	switch (scenario) {
> +	case MIO_GSM_AUDIO_HANDSET:
> +	case MIO_GSM_AUDIO_HEADSET:
> +	case MIO_GSM_AUDIO_BLUETOOTH:
> +	case MIO_GSM_AUDIO_HANDSFREE:
> +		onPhone = 1;

Setting 0 in a default would be slightly easier to read (or you could
just use return statements and not bother with the assignments).

> +	}
> +
> +	return onPhone;
> +}

> +static int phone_stream_start(struct snd_soc_codec *codec)
> +{
> +       snd_soc_dapm_stream_event(codec, "AC97 HiFi",
> +                                 SND_SOC_DAPM_STREAM_START);
> +       return 0;
> +}

Hrm.  What are these needed for?  I'd have expected that DAPM would
power active bypass paths up without this (I test that case frequently)
and this isn't coordinated with what the core is doing at all.

> +/* Use GPIO8 for rear speaker amplificator */

Amplifier.

> +static int rear_amp_event(struct snd_soc_dapm_widget *widget,
> +			  struct snd_kcontrol *kctl, int event)
> +{
> +	struct snd_soc_codec *codec = widget->codec;
> +	int rc;
> +
> +	if (SND_SOC_DAPM_EVENT_ON(event))
> +		rc = rear_amp_power(codec, 1);
> +	else
> +		rc = rear_amp_power(codec, 0);
> +
> +	return rc;
> +}

May as well just collapse rear_amp_power() in here, it's got the same if
statement in it anyway.

> +#define mioa701_wm9713_suspend NULL
> +#define mioa701_wm9713_resume  NULL

These can just be dropped until they're implemented (they may never need
to be).

> +static int mioa701_wm9713_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	if (!machine_is_mioa701())
> +		return -ENODEV;

Seems redundant to check this when you're using a platform device to
probe - a system should only be defining that device if it can
supported.  It's needed for most drivers which register the ASoC driver
directly on probe.
