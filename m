From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH] ASoC: AMD: Fix race condition between register access
Date: Mon, 29 Oct 2018 19:32:52 -0600
Message-ID: <CAGS+omAbvoYpZvK+WWejDF3YJWpCqDJXA7=3+7--nO897LLE8g@mail.gmail.com>
References: <1540798621-32627-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540798621-32627-1-git-send-email-akshu.agrawal@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Akshu Agrawal <Akshu.Agrawal@amd.com>
Cc: Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com, Vijendar.Mukunda@amd.com, Guenter Roeck <linux@roeck-us.net>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Akshu,


On Mon, Oct 29, 2018 at 1:39 AM Agrawal, Akshu <Akshu.Agrawal@amd.com> wrote:
>
> During simultaneous running of playback and capture, we
> got hit by incorrect value write on common register. This was due
> to race condition between 2 streams.
> Fixing this by locking the common register access.

Nice catch!  It looks looks like one of the operations you are trying
to make atomic is that two step Addr + Data register update.
If so, then I recommend refactoring a bit, and just doing that locked
2-step-access in its own helper function, like this:

  static void acp_reg_write_srbm_targ(void __iomem *acp_mmio, u32
addr, u32 data)
  {
    unsigned long flags;

    spin_lock_irqsave(&lock, flags);
    acp_reg_write(addr, acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
    acp_reg_write(data, acp_mmio, mmACP_SRBM_Targ_Idx_Data);
    spin_unlock_irqrestore(&lock, flags);
  }

And similarly, you can add 2 more locking helpers, one for modifying
the imr/ch and another for mmACP_I2S_16BIT_RESOLUTION_EN.

>
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> ---
>  sound/soc/amd/acp-pcm-dma.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
> index 0ac4b5b..993a7db 100644
> --- a/sound/soc/amd/acp-pcm-dma.c
> +++ b/sound/soc/amd/acp-pcm-dma.c
> @@ -121,6 +121,9 @@
>         .periods_max = CAPTURE_MAX_NUM_PERIODS,
>  };
>
> +/* Lock to protect access to registers */
> +static DEFINE_SPINLOCK(lock);
> +
>  static u32 acp_reg_read(void __iomem *acp_mmio, u32 reg)
>  {
>         return readl(acp_mmio + (reg * 4));
> @@ -168,9 +171,12 @@ static void config_dma_descriptor_in_sram(void __iomem *acp_mmio,
>                                           acp_dma_dscr_transfer_t *descr_info)
>  {
>         u32 sram_offset;
> +       unsigned long flags;
>
>         sram_offset = (descr_idx * sizeof(acp_dma_dscr_transfer_t));
>
> +       spin_lock_irqsave(&lock, flags);
> +
>         /* program the source base address. */
>         acp_reg_write(sram_offset, acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
>         acp_reg_write(descr_info->src,  acp_mmio, mmACP_SRBM_Targ_Idx_Data);
> @@ -181,6 +187,8 @@ static void config_dma_descriptor_in_sram(void __iomem *acp_mmio,
>         /* program the number of bytes to be transferred for this descriptor. */
>         acp_reg_write(sram_offset + 8,  acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
>         acp_reg_write(descr_info->xfer_val, acp_mmio, mmACP_SRBM_Targ_Idx_Data);
> +
> +       spin_unlock_irqrestore(&lock, flags);
>  }
>
>  static void pre_config_reset(void __iomem *acp_mmio, u16 ch_num)
> @@ -309,8 +317,12 @@ static void acp_pte_config(void __iomem *acp_mmio, struct page *pg,
>         u32 low;
>         u32 high;
>         u32 offset;
> +       unsigned long flags;
>
>         offset  = ACP_DAGB_GRP_SRBM_SRAM_BASE_OFFSET + (pte_offset * 8);
> +
> +       spin_lock_irqsave(&lock, flags);
> +
>         for (page_idx = 0; page_idx < (num_of_pages); page_idx++) {
>                 /* Load the low address of page int ACP SRAM through SRBM */
>                 acp_reg_write((offset + (page_idx * 8)),
> @@ -333,6 +345,8 @@ static void acp_pte_config(void __iomem *acp_mmio, struct page *pg,
>                 /* Move to next physically contiguos page */
>                 pg++;
>         }
> +
> +       spin_unlock_irqrestore(&lock, flags);
>  }
>
>  static void config_acp_dma(void __iomem *acp_mmio,
> @@ -367,6 +381,7 @@ static void acp_dma_cap_channel_enable(void __iomem *acp_mmio,
>                                        u16 cap_channel)
>  {
>         u32 val, ch_reg, imr_reg, res_reg;
> +       unsigned long flags;
>
>         switch (cap_channel) {
>         case CAP_CHANNEL1:
> @@ -381,6 +396,8 @@ static void acp_dma_cap_channel_enable(void __iomem *acp_mmio,
>                 imr_reg = mmACP_I2SMICSP_IMR0;
>                 break;
>         }
> +       spin_lock_irqsave(&lock, flags);
> +
>         val = acp_reg_read(acp_mmio,
>                            mmACP_I2S_16BIT_RESOLUTION_EN);
>         if (val & ACP_I2S_MIC_16BIT_RESOLUTION_EN) {
> @@ -393,12 +410,15 @@ static void acp_dma_cap_channel_enable(void __iomem *acp_mmio,
>         val &= ~ACP_I2SMICSP_IMR1__I2SMICSP_RXFOM_MASK;
>         acp_reg_write(val, acp_mmio, imr_reg);
>         acp_reg_write(0x1, acp_mmio, ch_reg);
> +
> +       spin_unlock_irqrestore(&lock, flags);
>  }
>
>  static void acp_dma_cap_channel_disable(void __iomem *acp_mmio,
>                                         u16 cap_channel)
>  {
>         u32 val, ch_reg, imr_reg;
> +       unsigned long flags;
>
>         switch (cap_channel) {
>         case CAP_CHANNEL1:
> @@ -411,11 +431,15 @@ static void acp_dma_cap_channel_disable(void __iomem *acp_mmio,
>                 ch_reg = mmACP_I2SMICSP_RER0;
>                 break;
>         }
> +       spin_lock_irqsave(&lock, flags);
> +
>         val = acp_reg_read(acp_mmio, imr_reg);
>         val |= ACP_I2SMICSP_IMR1__I2SMICSP_RXDAM_MASK;
>         val |= ACP_I2SMICSP_IMR1__I2SMICSP_RXFOM_MASK;
>         acp_reg_write(val, acp_mmio, imr_reg);
>         acp_reg_write(0x0, acp_mmio, ch_reg);
> +
> +       spin_unlock_irqrestore(&lock, flags);
>  }
>
>  /* Start a given DMA channel transfer */
> @@ -847,6 +871,7 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
>         int status;
>         uint64_t size;
>         u32 val = 0;
> +       unsigned long flags;
>         struct page *pg;
>         struct snd_pcm_runtime *runtime;
>         struct audio_substream_data *rtd;
> @@ -870,6 +895,8 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
>                 }
>         }
>         if (adata->asic_type == CHIP_STONEY) {
> +               spin_lock_irqsave(&lock, flags);
> +
>                 val = acp_reg_read(adata->acp_mmio,
>                                    mmACP_I2S_16BIT_RESOLUTION_EN);
>                 if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> @@ -893,6 +920,8 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
>                 }
>                 acp_reg_write(val, adata->acp_mmio,
>                               mmACP_I2S_16BIT_RESOLUTION_EN);
> +
> +               spin_unlock_irqrestore(&lock, flags);
>         }
>
>         if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> --
> 1.9.1
>
