From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH V2] ASoC: fsl_ssi: refine ipg clock usage in this module
Date: Thu, 11 Sep 2014 21:43:59 -0500
Message-ID: <54125DEF.4090101@tabi.org>
References: <27584da8e3ab291ab8dbcbb411579613f8384a59.1410413734.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <27584da8e3ab291ab8dbcbb411579613f8384a59.1410413734.git.shengjiu.wang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shengjiu Wang <shengjiu.wang@freescale.com>, nicoleotsuka@gmail.com, Li.Xiubo@freescale.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Shengjiu Wang wrote:
> +	ret = clk_prepare_enable(ssi_private->clk);
> +	if (ret)
> +		return ret;

Will this work on PowerPC, where ssi_private->clk is always NULL?
