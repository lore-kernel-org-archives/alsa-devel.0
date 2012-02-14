From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 1/3] OMAPDSS/ASoC: Relocate ASoC HDMI
	codec. Part 2
Date: Tue, 14 Feb 2012 12:12:44 -0600
Message-ID: <1329243164.2031.1437.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
References: <1329006197-28332-1-git-send-email-ricardo.neri@ti.com>
	<1329006197-28332-2-git-send-email-ricardo.neri@ti.com>
	<20120212132036.GC3395@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E93724467
	for <alsa-devel@alsa-project.org>; Tue, 14 Feb 2012 19:13:12 +0100 (CET)
In-Reply-To: <20120212132036.GC3395@opensource.wolfsonmicro.com>
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
Cc: x0055901@ti.com, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, tomi.valkeinen@ti.com, s-guiriec@ti.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,
On Sun, 2012-02-12 at 13:20 +0000, Mark Brown wrote:
> On Sat, Feb 11, 2012 at 06:23:15PM -0600, Ricardo Neri wrote:
> 
> > The ASoC HDMI codec is to be relocated under sound/soc/codecs. This
> > patch places the codec under ASoC. A previous patch removed the code
> > from DSS. The purpose of the relocation is to give a more logical
> > organization to OMAP HDMI code.
> 
> Looks pretty clean, a few things below but mostly fairly nitpicky.
Thanks for your comments!
> 
> >  sound/soc/codecs/omap-hdmi.c |  422 ++++++++++++++++++++++++++++++++++++++++++
> 
> If this is relocating the code shouldn't some old code be being deleted?
Yes, indeed. However, as it is being relocated from DSS, I thought it
would be good to split in two patches so that the respective maintainers
can apply independently. Here is the patch that removes the code from
DSS:

http://www.spinics.net/lists/linux-omap/msg64482.html

> 
> > +	switch (sample_freq) {
> > +	case 32000:
> > +		if ((deep_color == 125) && ((pclk == 54054)
> > +				|| (pclk == 74250)))
> > +			*n = 8192;
> > +		else
> > +			*n = 4096;
> 
> Use a switch on deep_color too (in all these cases).
> 
> > +
> > +static int hdmi_audio_startup(struct snd_pcm_substream *substream,
> > +				  struct snd_soc_dai *dai)
> > +{
> > +	if (omapdss_hdmi_get_hdmi_mode() != HDMI_HDMI) {
> > +		pr_err("Current video settings do not support audio.\n");
> 
> dev_ prints please (throughout the driver).
I will correct.
> 
> > +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> > +	if (priv == NULL)
> > +		return -ENOMEM;
> 
> Use devm_ functions for this and mapping the io region - that way you
> don't have to worry about them when cleaning up and doing error
> handling...
> 
> > +	hdmi_rsrc = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +
> > +	if (!hdmi_rsrc) {
> > +		dev_err(&pdev->dev, "Cannot obtain IORESOURCE_MEM HDMI\n");
> > +		return -EINVAL;
> > +	}
> 
> ...like here :)  You should also move the allocation and mapping to the
> platform device probe and only register the CODEC once you've got
> everything else, this is more idiomatic for the Linux driver stack.

I will correct this as well.
> 
> > +static struct snd_soc_dai_driver hdmi_codec_dai_drv = {
> > +	.name = "hdmi-audio-codec",
> 
> Should proably have an omap- in here somewhere.
> 
> > +static int __init hdmi_codec_init(void)
> > +{
> > +	return platform_driver_register(&hdmi_codec_driver);
> > +}
> > +module_init(hdmi_codec_init);
> 
> module_platform_driver()
