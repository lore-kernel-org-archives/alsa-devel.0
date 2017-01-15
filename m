From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 1/1] ASoC: fsl_asrc: use dma_transfer_direction enum when
 calling dmaengine_prep_dma_cyclic
Date: Sun, 15 Jan 2017 11:16:50 -0800
Message-ID: <20170115191649.GA4465@Asurada-CZ80>
References: <20170115124331.3546-1-nicolas.iooss_linux@m4x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170115124331.3546-1-nicolas.iooss_linux@m4x.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 15, 2017 at 01:43:31PM +0100, Nicolas Iooss wrote:
> When fsl_asrc_dma_prepare_and_submit() calls
> dmaengine_prep_dma_cyclic(), it uses either DMA_TO_DEVICE or
> DMA_FROM_DEVICE. These values are both items of dma_data_direction enum,
> not of dma_data_direction enum, which is the type expected by
> dmaengine_prep_dma_cyclic().
> 
> Replace DMA_TO_DEVICE with DMA_MEM_TO_DEV and DMA_FROM_DEVICE with
> DMA_DEV_TO_MEM to fix this type mismatch issue.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks.
