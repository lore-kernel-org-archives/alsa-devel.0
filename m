From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 1/3] ASoC: fsl_ssi: mark SACNT register volatile
Date: Sun, 10 Jan 2016 15:33:55 -0600
Message-ID: <5692CE43.20708@tabi.org>
References: <56770FE1.4060202@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56770FE1.4060202@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-kernel <linux-kernel@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

Maciej S. Szmigiero wrote:
> +	regmap_write(regs, CCSR_SSI_SACNT,
> +			ssi_private->regcache_sacnt);

So I'm not familiar with all of the regcache features, but I understand 
this patch.  I was wondering if it makes sense to write the same exact 
value that was read previously.  Isn't it possible for the WR or RD bits 
to change between fsl_ssi_suspend() and fsl_ssi_resume()?  That is, 
should we be doing this instead?

u32 temp;
regmap_read(regs, CCSR_SSI_SACNT, &temp);
temp &= 0x18; // preserve WR and RD
regmap_write(regs, CCSR_SSI_SACNT, (ssi_private->regcache_sacnt & ~0x18) 
| temp);
