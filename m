From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: [PATCH v3] ASoC: AMD: Fix race condition between register access
Date: Wed, 31 Oct 2018 21:24:10 +0000
Message-ID: <1541020930-17337-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Cc: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>, "djkurtz@chromium.org" <djkurtz@chromium.org>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>"Deucher, Alexander" <Alexander.Deucher@amd.com>, Guenter Roeck <linux@roeck-us.net>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

During simultaneous running of playback and capture, we
got hit by incorrect value write on common register. This was due
to race condition between 2 streams.
Fixing this by locking the common register access.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
v2: Added 2 helper functions, removed locking in ch enable/disable as they
are separate registers.
v3: Modified helper acp_reg_read_mod_write, moved pte locks to helper
 sound/soc/amd/acp-pcm-dma.c | 66 ++++++++++++++++++++++++++++++-----------=
----
 1 file changed, 44 insertions(+), 22 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 0ac4b5b..0d4c2eb 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -121,6 +121,9 @@
 	.periods_max =3D CAPTURE_MAX_NUM_PERIODS,
 };
=20
+/* Lock to protect access to registers */
+static DEFINE_SPINLOCK(lock);
+
 static u32 acp_reg_read(void __iomem *acp_mmio, u32 reg)
 {
 	return readl(acp_mmio + (reg * 4));
@@ -131,6 +134,31 @@ static void acp_reg_write(u32 val, void __iomem *acp_m=
mio, u32 reg)
 	writel(val, acp_mmio + (reg * 4));
 }
=20
+static void acp_reg_write_srbm_targ(void __iomem *acp_mmio,
+				    u32 addr, u32 data)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&lock, flags);
+	acp_reg_write(addr, acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
+	acp_reg_write(data, acp_mmio, mmACP_SRBM_Targ_Idx_Data);
+	spin_unlock_irqrestore(&lock, flags);
+}
+
+static void acp_reg_read_mod_write(void __iomem *acp_mmio, u32 addr,
+				   u32 mask, u32 value)
+{
+	u32 val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&lock, flags);
+	val =3D acp_reg_read(acp_mmio, addr);
+	val &=3D ~mask;
+	val |=3D (mask & value);
+	acp_reg_write(val, acp_mmio, addr);
+	spin_unlock_irqrestore(&lock, flags);
+}
+
 /*
  * Configure a given dma channel parameters - enable/disable,
  * number of descriptors, priority
@@ -172,15 +200,12 @@ static void config_dma_descriptor_in_sram(void __iome=
m *acp_mmio,
 	sram_offset =3D (descr_idx * sizeof(acp_dma_dscr_transfer_t));
=20
 	/* program the source base address. */
-	acp_reg_write(sram_offset, acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
-	acp_reg_write(descr_info->src,	acp_mmio, mmACP_SRBM_Targ_Idx_Data);
+	acp_reg_write_srbm_targ(acp_mmio, sram_offset, descr_info->src);
 	/* program the destination base address. */
-	acp_reg_write(sram_offset + 4,	acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
-	acp_reg_write(descr_info->dest, acp_mmio, mmACP_SRBM_Targ_Idx_Data);
-
+	acp_reg_write_srbm_targ(acp_mmio, sram_offset + 4, descr_info->dest);
 	/* program the number of bytes to be transferred for this descriptor. */
-	acp_reg_write(sram_offset + 8,	acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
-	acp_reg_write(descr_info->xfer_val, acp_mmio, mmACP_SRBM_Targ_Idx_Data);
+	acp_reg_write_srbm_targ(acp_mmio, sram_offset + 8,
+				descr_info->xfer_val);
 }
=20
 static void pre_config_reset(void __iomem *acp_mmio, u16 ch_num)
@@ -311,24 +336,22 @@ static void acp_pte_config(void __iomem *acp_mmio, st=
ruct page *pg,
 	u32 offset;
=20
 	offset	=3D ACP_DAGB_GRP_SRBM_SRAM_BASE_OFFSET + (pte_offset * 8);
+
 	for (page_idx =3D 0; page_idx < (num_of_pages); page_idx++) {
 		/* Load the low address of page int ACP SRAM through SRBM */
-		acp_reg_write((offset + (page_idx * 8)),
-			      acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
 		addr =3D page_to_phys(pg);
=20
 		low =3D lower_32_bits(addr);
 		high =3D upper_32_bits(addr);
=20
-		acp_reg_write(low, acp_mmio, mmACP_SRBM_Targ_Idx_Data);
+		acp_reg_write_srbm_targ(acp_mmio, (offset + (page_idx * 8)),
+					low);
=20
 		/* Load the High address of page int ACP SRAM through SRBM */
-		acp_reg_write((offset + (page_idx * 8) + 4),
-			      acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
-
 		/* page enable in ACP */
 		high |=3D BIT(31);
-		acp_reg_write(high, acp_mmio, mmACP_SRBM_Targ_Idx_Data);
+		acp_reg_write_srbm_targ(acp_mmio, (offset + (page_idx * 8) + 4),
+					high);
=20
 		/* Move to next physically contiguos page */
 		pg++;
@@ -870,29 +893,28 @@ static int acp_dma_hw_params(struct snd_pcm_substream=
 *substream,
 		}
 	}
 	if (adata->asic_type =3D=3D CHIP_STONEY) {
-		val =3D acp_reg_read(adata->acp_mmio,
-				   mmACP_I2S_16BIT_RESOLUTION_EN);
 		if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
 			switch (rtd->i2s_instance) {
 			case I2S_BT_INSTANCE:
-				val |=3D ACP_I2S_BT_16BIT_RESOLUTION_EN;
+				val =3D ACP_I2S_BT_16BIT_RESOLUTION_EN;
 				break;
 			case I2S_SP_INSTANCE:
 			default:
-				val |=3D ACP_I2S_SP_16BIT_RESOLUTION_EN;
+				val =3D ACP_I2S_SP_16BIT_RESOLUTION_EN;
 			}
 		} else {
 			switch (rtd->i2s_instance) {
 			case I2S_BT_INSTANCE:
-				val |=3D ACP_I2S_BT_16BIT_RESOLUTION_EN;
+				val =3D ACP_I2S_BT_16BIT_RESOLUTION_EN;
 				break;
 			case I2S_SP_INSTANCE:
 			default:
-				val |=3D ACP_I2S_MIC_16BIT_RESOLUTION_EN;
+				val =3D ACP_I2S_MIC_16BIT_RESOLUTION_EN;
 			}
 		}
-		acp_reg_write(val, adata->acp_mmio,
-			      mmACP_I2S_16BIT_RESOLUTION_EN);
+		acp_reg_read_mod_write(adata->acp_mmio,
+				       mmACP_I2S_16BIT_RESOLUTION_EN,
+				       val, val);
 	}
=20
 	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
--=20
1.9.1
