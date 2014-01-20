From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [alsa-devel] [PATCH] ASoC: core: Use devm_kzalloc() instead
 kzalloc()
Date: Mon, 20 Jan 2014 03:18:44 +0000
Message-ID: <1b7c6490c56549978740f5d27bb9d392@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1389861887-32721-1-git-send-email-Li.Xiubo@freescale.com>
 <52D854A3.5090109@metafoo.de> <20140117184857.GH17314@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140117184857.GH17314@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Mar, Lars


> > I don't like this. I don't think it is a good design pattern to call
> > devm function from within (especial non-devm) library functions. It
> > creates an asymmetric API. The memory is allocated when
> > snd_dmaengine_pcm_register() is called, but it is not freed when
> > snd_dmaengine_pcm_unregister() is called. This goes against the
> > principle of least surprise.
> 
> Yes, I tend to agree - unless we only support managed registration the
> API shouldn't do managed things internally.

Got it.

Thanks,
