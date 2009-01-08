From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 1/2] Add initial support of Mitac mioa701
	device SoC.
Date: Thu, 08 Jan 2009 22:07:04 +0100
Message-ID: <87iqopbj7r.fsf@free.fr>
References: <1231440146-6669-1-git-send-email-robert.jarzmik@free.fr>
	<1231440146-6669-2-git-send-email-robert.jarzmik@free.fr>
	<20090108203324.GB29183@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 973D2243CF
	for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2009 22:07:12 +0100 (CET)
In-Reply-To: <20090108203324.GB29183@sirena.org.uk> (Mark Brown's message of
	"Thu\, 8 Jan 2009 20\:33\:25 +0000")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@sirena.org.uk> writes:

> On Thu, Jan 08, 2009 at 07:42:25PM +0100, Robert Jarzmik wrote:
>
> It'd probably be easier to split this up still further, with one patch
> providing a standard ASoC machine and another adding the scenario stuff
> after that.
Wish for 2 patches instead of that one, one for core support and one for
scenarii ? As this patch has already been reviewed and include into your tree,
I had hopped I shouldn't inject any more work that what had already be done ...

> As well as easing review I have to say that I'm a bit unenthusiastic
> about having the scenario stuff in here.  The general plan was to do
> this in user space, partly because experience with things like OpenMoko
> suggests that some users are going to come up with new and exciting
> scenarios and that having to rebuild the kernel is too high a barrier.
> I know Graeme has said he regrets doing the in-kernel scenarios there.
>
> Liam's ALSA scenario API was intended to do what's needed in user space:
>
> 	http://opensource.wolfsonmicro.com/node/14
>
> though it's still a work in progress.  I'm not 100% against doing this
> like you have since we don't have a clear solution right now but I'd
> like to stop and think about it.

I'd like to recall what happened to one of the mioa701 users here, when scenarii
were handled in userspace. The wm9713 chip overheated, and destroyed the battery
underneath. That was the reason to put that stuff into the kernel :
protection. This was also already discussed when this was _previously_
submitted.

And I know Liam's API, I tried it. Let me tell you my point of view : the
mioa701 users have a standard API (alsa) to control the sound of the mioa701. I
could force them to migrate towards Liam's library. But I can't have a guarantee
of maintainance over that library. I don't even know if it will be the final
solution.

Let me propose a deal : you include that library in the standard alsa-lib, which
will then slowly sink into Angstrom, OpenEmbedded, or whatever distribution
comes along, and then I'll remove all the scenario code away.

>> If we are going to do it in kernel space then it'd be better to lift at
> least some of it out of your driver since the mechanics of what you've
> got aren't very specific to this machine, just the lists of endpoints.
> I'd also suggest masking off the controls you're controlling via the
> scenario stuff from user space - Takashi has commit
> 03ad1d710ea51a51dfbe62caa2bc9a9437ae3fed in his sound-unstable-2.6.git
> which adds snd_ctl_activate_id(), allowing drivers to do this.
Will include into the next submission.

> More comments below, mostly very nitpicky:
I like nipicking :)

>
>> It doesn't cope with :
>>  - headset jack (will be integrade after jack support has
>>    hit ASoC v2)
>
> I just pushed an implementation of that just now, enjoy :)
Good. That would have to wait an ulterior update, though.

>> +#define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
>
> This is also defined somewhere or other in the PXA or ARM architecture
> code - there's a danger of multiple definitions of the macro appearing.
> checkpatch wants extra () too, I kind of agree with it.
There was a discussion to include it in kernel.h. ATM, it is defined in
arch/arm/mach-pxa/generic.h, which is not easily reachable, hence the
definition.
Moreover, if you look at that file, you'll see the definition is the same, and I
think it is perfectly correct.

>> +void setup_muxers(struct snd_soc_codec *codec, const struct mio_mixes_t mixes[])
>> +{
>> +	int pos = 0;
>> +	struct snd_kcontrol *kctl;
>> +	struct snd_ctl_elem_value ucontrol;
>> +	char mname[44];
>> +
>> +	while (mixes[pos].mixname) {
>
> A for loop over the ARRAY_SIZE() might be more idiomatic here...
Yes. Will do.

>
>> +		memset(mname, 0, 44);
>> +		strncpy(mname, mixes[pos].mixname, 43);
>
> It's bikesheding but strcpy plus termination would do the job, wouldn't
> it?
I don't get that ...

>
>> +               if (kctl) {
>
> Shouldn't we at least warn if this is false, it's an error in the static
> data for the maps.
Yes. Will do.

>
>> +                       kctl->get(kctl, &ucontrol);
>> +                       ucontrol.value.enumerated.item[0] = mixes[pos].val;
>> +                       kctl->put(kctl, &ucontrol);
>> +               }
>

> Does an open application (eg, alsamixer) notice these changes without
> the driver telling it?  snd_ctl_notify() is the API call, IIRC though
> there's a reasonable chance I am misremembering.  Though if you do mask
> them from user space it shoudn't matter anyway, I expect.
It does. At least when I change the mode, all the muxers the drivers touches
change state. I don't know how, but it works ...

>> +		{ 0, 0, 1, 1, 1, 0, 1 }, /* MIO_GSM_AUDIO_HEADSET	*/
>> +		{ 0, 1, 1, 1, 0, 1, 0 }, /* MIO_GSM_AUDIO_HANDSFREE*/
>> +		{ 0, 0, 1, 1, 0, 0, 0 }, /* MIO_GSM_AUDIO_BLUETOOTH*/
>
> Interesting indentation?
Unfortunate. Will do.

>
>> +static int isPhoneMode(int scenario)
>> +{
>> +	int onPhone = 0;
>
> The kernel doesn't generally go in for mixedCaseNames except when
> following standards that use them.
Yes. Will do.

>
>> +	switch (scenario) {
>> +	case MIO_GSM_AUDIO_HANDSET:
>> +	case MIO_GSM_AUDIO_HEADSET:
>> +	case MIO_GSM_AUDIO_BLUETOOTH:
>> +	case MIO_GSM_AUDIO_HANDSFREE:
>> +		onPhone = 1;
>
> Setting 0 in a default would be slightly easier to read (or you could
> just use return statements and not bother with the assignments).
Yes. Will go for the direct return statements.
>
>> +static int phone_stream_start(struct snd_soc_codec *codec)
>> +{
>> +       snd_soc_dapm_stream_event(codec, "AC97 HiFi",
>> +                                 SND_SOC_DAPM_STREAM_START);
>> +       return 0;
>> +}
>
> Hrm.  What are these needed for?  I'd have expected that DAPM would
> power active bypass paths up without this (I test that case frequently)
> and this isn't coordinated with what the core is doing at all.
Without this, in asoc-v2, the dapm is not powering any of the elements in the
phone audio path without this. Will check in asoc-v1, but I see no reason this
has changed. I don't quite understand what you mean by "active bypass path" so I
will make the test myself.

>
>> +/* Use GPIO8 for rear speaker amplificator */
>
> Amplifier.
Yes. Will do.

>
>> +static int rear_amp_event(struct snd_soc_dapm_widget *widget,
>> +			  struct snd_kcontrol *kctl, int event)
>> +{
>> +	struct snd_soc_codec *codec = widget->codec;
>> +	int rc;
>> +
>> +	if (SND_SOC_DAPM_EVENT_ON(event))
>> +		rc = rear_amp_power(codec, 1);
>> +	else
>> +		rc = rear_amp_power(codec, 0);
>> +
>> +	return rc;
>> +}
>
> May as well just collapse rear_amp_power() in here, it's got the same if
> statement in it anyway.
Yes. Will do.

>
>> +#define mioa701_wm9713_suspend NULL
>> +#define mioa701_wm9713_resume  NULL
>
> These can just be dropped until they're implemented (they may never need
> to be).
Yes. Will do.

>> +static int mioa701_wm9713_probe(struct platform_device *pdev)
>> +{
>> +	int ret;
>> +
>> +	if (!machine_is_mioa701())
>> +		return -ENODEV;
>
> Seems redundant to check this when you're using a platform device to
> probe - a system should only be defining that device if it can
> supported.  It's needed for most drivers which register the ASoC driver
> directly on probe.
Right. Will trash.

--
Robert
