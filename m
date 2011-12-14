From: Dong Aisheng-B29396 <B29396@freescale.com>
Subject: RE: [PATCH 5/5] ASoC: mxs: correct 'direction' of
 device_prep_dma_cyclic
Date: Wed, 14 Dec 2011 08:49:36 +0000
Message-ID: <7FE21149F4667147B645348EC605788503F3AE@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1323791286-29574-1-git-send-email-shawn.guo@linaro.org>
 <1323848866-19768-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323848866-19768-1-git-send-email-shawn.guo@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dong Aisheng <dong.aisheng@linaro.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Shawn Guo
> Sent: Wednesday, December 14, 2011 3:48 PM
> To: Liam Girdwood; Mark Brown
> Cc: Dong Aisheng; alsa-devel@alsa-project.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Shawn Guo
> Subject: [PATCH 5/5] ASoC: mxs: correct 'direction' of
> device_prep_dma_cyclic
> 
> The commit 49920bc (dmaengine: add new enum dma_transfer_direction)
> changes the type of parameter 'direction' of device_prep_dma_cyclic from
> dma_data_direction to dma_transfer_direction.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  sound/soc/mxs/mxs-pcm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

Regards
Dong Aisheng
