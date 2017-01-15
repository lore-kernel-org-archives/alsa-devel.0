From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/1] ASoC: fsl_asrc: use dma_transfer_direction
 enum when calling dmaengine_prep_dma_cyclic
Date: Sun, 15 Jan 2017 11:24:36 -0200
Message-ID: <CAOMZO5DaR1r2E21njxtvg-4BZc1uR4rE25z0ncqavqZq76sm_Q@mail.gmail.com>
References: <20170115124331.3546-1-nicolas.iooss_linux@m4x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170115124331.3546-1-nicolas.iooss_linux@m4x.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Cc: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 15, 2017 at 10:43 AM, Nicolas Iooss
<nicolas.iooss_linux@m4x.org> wrote:
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

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
