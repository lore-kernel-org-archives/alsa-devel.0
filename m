From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 01/10] ASoC: fsl_sai: add of_match data
Date: Wed, 24 Jul 2019 15:34:22 -0700
Message-ID: <20190724223422.GA6859@Asurada-Nvidia.nvidia.com>
References: <20190722124833.28757-1-daniel.baluta@nxp.com>
 <20190722124833.28757-2-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190722124833.28757-2-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: broonie@kernel.org, festevam@gmail.com, perex@perex.cz, tiwai@suse.com, Xiubo.Lee@gmail.com, timur@kernel.org, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com, shengjiu.wang@nxp.com, angus@akkea.ca, kernel@pengutronix.de, l.stach@pengutronix.de, viorel.suman@nxp.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 22, 2019 at 03:48:24PM +0300, Daniel Baluta wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> New revisions of the SAI IP block have even more differences that need
> be taken into account by the driver. To avoid sprinking compatible
> checks all over the driver move the current differences into of_match_data.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Looks like Mark has applied this already? If so, should probably
drop applied ones and rebase the remaining patches for a resend.
