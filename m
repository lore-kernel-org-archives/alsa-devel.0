From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: ALSA ASoC CQ0093 Voice Codec
 Driver
Date: Tue, 22 Sep 2009 14:22:45 -0700
Message-ID: <20090922212244.GA4736@sirena.org.uk>
References: <1253647738-32527-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s-utl02-sjpop.stsn.net (s-utl02-sjpop.stsn.net [72.254.0.202])
	by alsa0.perex.cz (Postfix) with SMTP id 98BD5244CA
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Sep 2009 23:23:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1253647738-32527-1-git-send-email-miguel.aguilar@ridgerun.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: miguel.aguilar@ridgerun.com
Cc: davinci-linux-open-source@linux.davincidsp.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, diego.dompe@ridgerun.com, alsa-devel@alsa-project.org, nsnehaprabha@ti.com, todd.fischer@ridgerun.com
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 22, 2009 at 01:28:58PM -0600, miguel.aguilar@ridgerun.com wrote:

Looks mostly good - the main issue here is the device registration
stuff, everything else is fairly minor.

> +	select SND_SOC_CQ0093VC if ARCH_DAVINCI_DM365

This probably should have no dependency (see below about device
registration).

> +#define AUDIO_NAME "cq0093"
> +#define CQ93VC_VERSION "0.1"

I'd just drop these.

> +static int cq93vc_hw_params(struct snd_pcm_substream *substream,
> +			   struct snd_pcm_hw_params *params,
> +			   struct snd_soc_dai *dai)
> +{
> +	return 0;
> +}

Just omit this if it's empty.

> +static const struct snd_kcontrol_new cq93vc_snd_controls[] = {
> +	SOC_SINGLE("PGA Capture Volume", VC_REG05, 0, 0x03, 0),
> +	SOC_SINGLE("Mono DAC Playback Volume", VC_REG09, 0, 0x3f, 0),

Any chance of adding TLV information for these?  Not essential but it's
nice for userspace applications.

> +static int cq93vc_add_controls(struct snd_soc_codec *codec)
> +{

Please use snd_soc_add_controls instead.

> +static int cq93vc_set_bias_level(struct snd_soc_codec *codec,
> +				enum snd_soc_bias_level level)
> +{
> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +		/* all power is driven by DAPM system */
> +		cq93vc_write(codec, VC_REG12, POWER_ALL_ON);

The code is OK but the driver isn't using DAPM.

> +static int cq93vc_probe(struct platform_device *pdev)
> +{

You should make the driver a regular platform device - that way you
won't need to do the trick with the global variable to get the resources
and you won't need to register the DAIs on module_init.  See wm8350 for
an example of doing this with a platform device.
