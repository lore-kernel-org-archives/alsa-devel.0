From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [RESEND PATCH v3] ASoC: fsl_sai: Move clock operation to PM
 runtime
Date: Tue, 7 May 2019 16:11:09 -0700
Message-ID: <20190507231108.GA22188@Asurada-Nvidia.nvidia.com>
References: <20190507140632.15996-1-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190507140632.15996-1-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, "timur@kernel.org" <timur@kernel.org>, "festevam@gmail.com" <festevam@gmail.com>, "tiwai@suse.com" <tiwai@suse.com>, dl-linux-imx <linux-imx@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, May 07, 2019 at 02:06:52PM +0000, Daniel Baluta wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
> 
> Turn off/on clocks when device enters suspend/resume. This
> can help saving power.
> 
> As a further optimization, we turn off/on mclk only when SAI
> is in master mode because otherwise mclk is externally provided.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> Reviewed-by: Viorel Suman <viorel.suman@nxp.com>
  
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
