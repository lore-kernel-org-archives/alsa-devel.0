From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Subject: Re: [PATCH 1/4] ASoC: ALSA ASoC CQ0093 Voice Codec
	Driver
Date: Tue, 22 Sep 2009 15:42:37 -0600
Message-ID: <4AB944CD.5090702@ridgerun.com>
References: <1253647738-32527-1-git-send-email-miguel.aguilar@ridgerun.com>
	<20090922212244.GA4736@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.navvo.net (mail.navvo.net [74.208.67.6])
	by alsa0.perex.cz (Postfix) with ESMTP id D906F244FD
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Sep 2009 23:42:43 +0200 (CEST)
In-Reply-To: <20090922212244.GA4736@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, diego.dompe@ridgerun.com, alsa-devel@alsa-project.org, nsnehaprabha@ti.com, todd.fischer@ridgerun.com
List-Id: alsa-devel@alsa-project.org

Mark,

Mark Brown wrote:
> On Tue, Sep 22, 2009 at 01:28:58PM -0600, miguel.aguilar@ridgerun.com wrote:
> 
> Looks mostly good - the main issue here is the device registration
> stuff, everything else is fairly minor.
> 
>> +	select SND_SOC_CQ0093VC if ARCH_DAVINCI_DM365
> 
> This probably should have no dependency (see below about device
> registration).
[MA] OK I'll remove that dependency.
> 
>> +#define AUDIO_NAME "cq0093"
>> +#define CQ93VC_VERSION "0.1"
> 
> I'd just drop these.
[MA] Ok.
> 
>> +static int cq93vc_hw_params(struct snd_pcm_substream *substream,
>> +			   struct snd_pcm_hw_params *params,
>> +			   struct snd_soc_dai *dai)
>> +{
>> +	return 0;
>> +}
> 
> Just omit this if it's empty.
[MA] Ok.
> 
>> +static const struct snd_kcontrol_new cq93vc_snd_controls[] = {
>> +	SOC_SINGLE("PGA Capture Volume", VC_REG05, 0, 0x03, 0),
>> +	SOC_SINGLE("Mono DAC Playback Volume", VC_REG09, 0, 0x3f, 0),
> 
> Any chance of adding TLV information for these?  Not essential but it's
> nice for userspace applications.
[MA] I'll take a look if there is chance of adding TLV.
> 
>> +static int cq93vc_add_controls(struct snd_soc_codec *codec)
>> +{
> 
> Please use snd_soc_add_controls instead.
[MA] Ok.
> 
>> +static int cq93vc_set_bias_level(struct snd_soc_codec *codec,
>> +				enum snd_soc_bias_level level)
>> +{
>> +	switch (level) {
>> +	case SND_SOC_BIAS_ON:
>> +		/* all power is driven by DAPM system */
>> +		cq93vc_write(codec, VC_REG12, POWER_ALL_ON);
> 
> The code is OK but the driver isn't using DAPM.
[MA] Should it use DAPM, if so, How is the proper way to do that?
> 
>> +static int cq93vc_probe(struct platform_device *pdev)
>> +{
> 
> You should make the driver a regular platform device - that way you
> won't need to do the trick with the global variable to get the resources
> and you won't need to register the DAIs on module_init.  See wm8350 for
> an example of doing this with a platform device.
> 
I tried that and I got many some Virtual memory errors since there is the VCIF 
and the CQ0093 codecs belong to the same register domain of the DM365, the first 
driver which is being registered is the CQ0093 before the VCIF, but the VCIF is 
the one that enables the common clock for both, so that's why I get the virtual 
memory error. I'll take a look into wm8350 code and I'll try to make it a 
platform device.

-- 
Miguel Angel Aguilar Ulloa
Embedded Software Engineer
RidgeRun Embedded Solutions
miguel.aguilar@ridgerun.com
Office: +(506) 2225-9596
