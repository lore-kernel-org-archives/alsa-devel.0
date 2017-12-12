From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 00/10] ASoC: fsl_ssi: Clean up - coding style level
Date: Tue, 12 Dec 2017 15:32:24 -0800
Message-ID: <20171212233223.GA2019@Asurada-Nvidia>
References: <1512420403-10164-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1512420403-10164-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, fabio.estevam@nxp.com, timur@tabi.org, mail@maciej.szmigiero.name, caleb@crome.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 04, 2017 at 12:46:33PM -0800, Nicolin Chen wrote:

> Nicolin Chen (10):
>   ASoC: fsl_ssi: Remove unused struct device
>   ASoC: fsl_ssi: Rename fsl_ssi_private to fsl_ssi
>   ASoC: fsl_ssi: Cache pdev->dev pointer
>   ASoC: fsl_ssi: Refine all comments
>   ASoC: fsl_ssi: Rename registers and fields macros
>   ASoC: fsl_ssi: Refine indentations and wrappings
>   ASoC: fsl_ssi: Refine printk outputs
>   ASoC: fsl_ssi: Rename cpu_dai parameter to dai
>   ASoC: fsl_ssi: Rename scr_val to scr
>   ASoC: fsl_ssi: Replace fsl_ssi_rxtx_reg_val with fsl_ssi_regvals

Have revised some comments at one of patches and rebased the rest.
Will send v2 tonight. So let's ignore this version for now. Thanks
