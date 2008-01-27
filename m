From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: ASOC v2 driver structure
Date: Sun, 27 Jan 2008 11:45:25 -0500
Message-ID: <9e4733910801270845i58b41269s708cb1ee58e7eba8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by alsa0.perex.cz (Postfix) with ESMTP id DB5AA103894
	for <alsa-devel@alsa-project.org>; Sun, 27 Jan 2008 17:45:26 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so2414672wag.8
	for <alsa-devel@alsa-project.org>; Sun, 27 Jan 2008 08:45:25 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA-devel <alsa-devel@alsa-project.org>, Liam Girdwood <liam.girdwood@wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

I'm trying to write an asoc v2 driver for my powerpc based SOC
(mpc5200) hardware. We have two audio devices on the board, a WM8580
and a TAS5504.  How do you do this with asoc v2? The card is created
in snd_soc_machine_create(); there seems to be an assumption of a
single card per machine.

Or are you supposed to mix the different devices into a single pcm
driver? What would happen in pxa2xx-pcm.c if more than one of these
were defined?

static int pxa2xx_pcm_probe(struct device *dev)
{
	struct snd_soc_platform *platform = to_snd_soc_platform(dev);
	int ret;
	
	platform->pcm_ops = &pxa2xx_pcm_ops;
	platform->pcm_new = pxa2xx_pcm_new,
	platform->pcm_free = pxa2xx_pcm_free_dma_buffers,
#if defined(CONFIG_SND_PXA2XX_SOC_I2S)	
	ret = snd_soc_platform_add_dai(platform, &pxa2xx_i2s, 1);
	if (ret < 0)
		return ret;
#endif
#if defined(CONFIG_SND_PXA2XX_SOC_AC97)	
	ret = snd_soc_platform_add_dai(platform, pxa2xx_ac97, 3);
	if (ret < 0)
		return ret;
#endif
#if defined(CONFIG_SND_PXA2XX_SOC_SSP)	
	ret = snd_soc_platform_add_dai(platform, pxa2xx_ssp, 3);
	if (ret < 0)
		return ret;
#endif	
	ret = snd_soc_register_platform(platform);
	return ret;
}



-- 
Jon Smirl
jonsmirl@gmail.com
