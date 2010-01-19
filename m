From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Subject: Re: [PATCH 2/2] Davinci: DM365: Enable DaVinci Voice
 Codec support for DM365 EVM
Date: Tue, 19 Jan 2010 14:47:16 -0600
Message-ID: <4B561A54.6070201@ridgerun.com>
References: <1262902641-14821-1-git-send-email-miguel.aguilar@ridgerun.com>
	<20100108113121.GB10128@sirena.org.uk>
	<4B476D3B.3050200@ridgerun.com>
	<20100108193720.GA3088@sirena.org.uk>
	<4B4B3F97.8060508@ridgerun.com>
	<20100111153458.GA2661@rakim.wolfsonmicro.main>
	<4B4B4987.1080507@ridgerun.com>
	<20100111162101.GA26771@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.navvo.net (mail.navvo.net [74.208.67.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 826A924156
	for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2010 21:50:07 +0100 (CET)
In-Reply-To: <20100111162101.GA26771@rakim.wolfsonmicro.main>
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
Cc: davinci-linux-open-source@linux.davincidsp.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, "Nori, Sekhar" <nsekhar@ti.com>, diego.dompe@ridgerun.com, alsa-devel@alsa-project.org, "Narnakaje, Snehaprabha" <nsnehaprabha@ti.com>, todd.fischer@ridgerun.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

I have a specific doubt about the codec_dev element snd_soc_device struct of the 
DM365 EVM.

Since I have two codecs on the EVM, I have two snd_soc_codec_device structures:

* AIC3x

struct snd_soc_codec_device soc_codec_dev_aic3x = {
	.probe = aic3x_probe,
	.remove = aic3x_remove,
	.suspend = aic3x_suspend,
	.resume = aic3x_resume,
};

* Voice Codec

struct snd_soc_codec_device soc_codec_dev_cq93vc = {
	.probe = cq93vc_probe,
	.remove = cq93vc_remove,
	.suspend = cq93vc_suspend,
	.resume = cq93vc_resume,
};

But I can set only one at a time in the dm365_evm_snd_devdata:

/* evm audio subsystem */
static struct snd_soc_device dm365_evm_snd_devdata = {
	.card = &dm365_snd_soc_card_evm,
***	
	.codec_dev = &soc_codec_dev_aic3x,
or
	.codec_dev = &soc_codec_dev_cq93vc,
***
	.codec_data = &aic3x_setup,
};

So in case what is the proper way to do this?

Thanks,

Miguel Aguilar
