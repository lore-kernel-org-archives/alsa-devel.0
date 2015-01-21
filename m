From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [alsa-devel][PATCH 3/3] ASoC: fsl_sai: Add support for Right-J
 mode
Date: Wed, 21 Jan 2015 10:53:20 -0800
Message-ID: <20150121185319.GA4238@Alpha>
References: <1421756480-7055-1-git-send-email-zidan.wang@freescale.com>
 <1421756480-7055-4-git-send-email-zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1421756480-7055-4-git-send-email-zidan.wang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: timur@tabi.org, Xiubo.Lee@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 20, 2015 at 08:21:20PM +0800, Zidan Wang wrote:
> Add Right-J mode and set TCR5 FBT bit to let data right justify.
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>

> -	if (sai->is_lsb_first)
> +	if (sai->is_lsb_first && sai->is_right_j_mode)
>  		val_cr5 |= FSL_SAI_CR5_FBT(0);

Are you sure that FBT(0) is correct for right justified mode?
Because the original code is using FBT(0) for the lsb_first
situation and it shouldn't be right justified mode as default.

Nicolin
