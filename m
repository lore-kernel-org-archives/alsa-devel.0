From: Ben Dooks <ben-alsa@fluff.org>
Subject: Re: RFC: ASoC driver for S3C24XX Simtec boards
Date: Fri, 26 Jun 2009 09:46:26 +0100
Message-ID: <20090626084625.GB29142@trinity.fluff.org>
References: <20090624111155.GA390@fluff.org.uk>
	<20090625112658.GG17812@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from trinity.fluff.org (trinity.fluff.org [89.16.178.74])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F67D247B5
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Jun 2009 10:46:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090625112658.GG17812@sirena.org.uk>
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
Cc: Ben Dooks <ben@simtec.co.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 25, 2009 at 12:26:59PM +0100, Mark Brown wrote:
> On Wed, Jun 24, 2009 at 12:11:55PM +0100, Ben Dooks wrote:
> > I'd like some comments on the following driver which
> > is currently being developed to get ASoC working on
> > the TLV320AIC23 based Simtec boards.
> 
> Please do remember to CC maintainers on things.
> 
> > 1) I'm not seeing a control to enable/disable the
> >    'Speaker Amp', do I need to change the controls
> >    or how this is exported?
> 
> If you need to give manual control of this to user space use a
> DAPM_SOC_PIN_SWITCH widget.  Normally there's no need to do this since
> it falls out of the internal routing within the CODEC and having an
> explicit control for the output itself just adds an extra knob for
> userspace to twiddle.  Depending on the technology it may not even be
> desirable since having inputs connected with the amplifiers powered off
> can leave audible leakage paths.

We've not seen any problems with out boards, then the amps are coupled
with an R/C network so leakage from HP->AMP should be negligible.

Our old ALSA drivers always gave the user the choice to have the
speaker powered up or not.
 
> > static const struct snd_soc_dapm_widget tlv320aic23_dapm_widgets[] = {
> > 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
> > 	SND_SOC_DAPM_LINE("Line In", NULL),
> > 	SND_SOC_DAPM_LINE("Line Out", NULL),
> > 	SND_SOC_DAPM_MIC("Mic Jack", NULL),
> 
> > 	SND_SOC_DAPM_PGA_E("Speaker Amp", SND_SOC_NOPM,
> > 			   0, 0, NULL, 0, simtec_spk_event,
> > 			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
> 
> This looks like a SND_SOC_DAPM_SPK(); using that will help with
> sequencing.

thanks, changed. still no output in the alsactl control dump though.
 
> > static const struct snd_soc_dapm_route audio_map[] = {
> 
> This wants a better name - base_map or something?

thanks, changed.
 
> > 	if (pdata->amp_gpio > 0) {
> > 		printk(KERN_DEBUG "%s: adding amp routes\n", __func__);
> 
> pr_dbg() or dev_dbg()

changed to pr_debug, we're not keeping the platform device around
after the probe.

> > static int simtec_hw_startup(struct snd_pcm_substream *substream)
> > {
> > 	/* call any board supplied startup code, this currently only
> > 	 * covers the bast/vr1000 which have a CPLD in the way of the
> > 	 * LRCLK */
> > 	if (pdata->startup)
> > 		pdata->startup();
> > 
> > 	return 0;
> > }
> 
> This looks odd.  Does this really need to be done each time the audio
> device can be opened or should it be done once when the driver is being
> set up?  There doesn't appear to be any similar code to reverse the
> startup() on teardown so I suspect that just doing it when the driver
> starts should be fine.

I'll have to add it in the resume path as well.

> > 	/* attach gpio amp gain (if any) */
> > 	if (pdata->amp_gain[0] > 0) {
> > 		ret = gpio_request(pd->amp_gain[0], "gpio-amp-gain");
> > 		if (ret) {
> > 			dev_err(dev, "cannot get amp gpio gain0\n");
> > 			return ret;
> > 		}
> > 
> > 		ret = gpio_request(pd->amp_gain[1], "gpio-amp-gain");
> > 		if (ret) {
> > 			dev_err(dev, "cannot get amp gpio gain0\n");
> 
> gain1.

thanks, changed.

> > static int __devinit simtec_audio_probe(struct platform_device *pdev)
> > {
> > 	struct platform_device *snd_dev;
> > 	int ret;
> > 
> > 	dev_info(&pdev->dev, "probe called\n");
> 
> dev_dbg() at most.

> > 	pdata = pdev->dev.platform_data;
> > 	if (!pdata) {
> > 		dev_err(&pdev->dev, "no platform data supplied\n");
> > 		return -EINVAL;
> > 	}
> 
> Every individual bit of platform data looks optional; this suggests that
> either additional validation is desirable here or that platform data
> itself should be optional.

As such, pretty much all the systems we've got pass platform data for
some from of information, so I decided that a lack of it was a good
enough indication that there was something wrong.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
