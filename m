From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH]  ASoC : fsl_ssi : Correct the condition to check AC97
 mode
Date: Wed, 4 Jan 2017 12:22:09 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB025783A@AcuExch.aculab.com>
References: <20161228110636.GA14768@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161228110636.GA14768@ubuntu>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "'Harisangam, Sharvari (S.)'" <sharvari.harisangam@visteon.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Harisangam, Sharvari (S.)
> Sent: 28 December 2016 11:07
>  Corrected the condition to check if ssi is configured for AC97
>  mode. Other modes like dsp_a also satisfy the ANDing condition.

Under the assumption that the constants have 1 bit set nothing is wrong.

	David

...
> -	return !!(ssi_private->dai_fmt & SND_SOC_DAIFMT_AC97);
...
> -	if (fmt & SND_SOC_DAIFMT_AC97)
...
