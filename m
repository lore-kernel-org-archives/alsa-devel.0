From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 2/4] ALSA: oxygen: add support for third analog
	input
Date: Fri, 16 Jan 2015 22:15:13 +0100
Message-ID: <54B97F61.7020906@ladisch.de>
References: <54B97EEB.8060108@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id BFC582654D1
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 22:16:02 +0100 (CET)
In-Reply-To: <54B97EEB.8060108@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Make it possible for cards to have three stereo analog input pairs.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/pci/oxygen/oxygen.h       |    2 +-
 sound/pci/oxygen/oxygen_lib.c   |   15 ++++++++++---
 sound/pci/oxygen/oxygen_mixer.c |   27 +++++++++++++++++++++++
 sound/pci/oxygen/oxygen_pcm.c   |   45 ++++++++++++++++++++++++++++++++++++---
 4 files changed, 82 insertions(+), 7 deletions(-)

diff --git a/sound/pci/oxygen/oxygen.h b/sound/pci/oxygen/oxygen.h
index c10ab07..293d0b9 100644
--- a/sound/pci/oxygen/oxygen.h
+++ b/sound/pci/oxygen/oxygen.h
@@ -35,7 +35,7 @@
 #define CAPTURE_1_FROM_SPDIF	0x0080
 #define CAPTURE_2_FROM_I2S_2	0x0100
 #define CAPTURE_2_FROM_AC97_1	0x0200
-     /* CAPTURE_3_FROM_I2S_3		not implemented */
+#define CAPTURE_3_FROM_I2S_3	0x0400
 #define MIDI_OUTPUT		0x0800
 #define MIDI_INPUT		0x1000
 #define AC97_CD_INPUT		0x2000
diff --git a/sound/pci/oxygen/oxygen_lib.c b/sound/pci/oxygen/oxygen_lib.c
index dbf1f2d..ab47c1c 100644
--- a/sound/pci/oxygen/oxygen_lib.c
+++ b/sound/pci/oxygen/oxygen_lib.c
@@ -441,9 +441,18 @@ static void oxygen_init(struct oxygen *chip)
 		oxygen_write16(chip, OXYGEN_I2S_B_FORMAT,
 			       OXYGEN_I2S_MASTER |
 			       OXYGEN_I2S_MUTE_MCLK);
-	oxygen_write16(chip, OXYGEN_I2S_C_FORMAT,
-		       OXYGEN_I2S_MASTER |
-		       OXYGEN_I2S_MUTE_MCLK);
+	if (chip->model.device_config & CAPTURE_3_FROM_I2S_3)
+		oxygen_write16(chip, OXYGEN_I2S_C_FORMAT,
+			       OXYGEN_RATE_48000 |
+			       chip->model.adc_i2s_format |
+			       OXYGEN_I2S_MCLK(chip->model.adc_mclks) |
+			       OXYGEN_I2S_BITS_16 |
+			       OXYGEN_I2S_MASTER |
+			       OXYGEN_I2S_BCLK_64);
+	else
+		oxygen_write16(chip, OXYGEN_I2S_C_FORMAT,
+			       OXYGEN_I2S_MASTER |
+			       OXYGEN_I2S_MUTE_MCLK);
 	oxygen_clear_bits32(chip, OXYGEN_SPDIF_CONTROL,
 			    OXYGEN_SPDIF_OUT_ENABLE |
 			    OXYGEN_SPDIF_LOOPBACK);
diff --git a/sound/pci/oxygen/oxygen_mixer.c b/sound/pci/oxygen/oxygen_mixer.c
index 2f698a9..6492bca 100644
--- a/sound/pci/oxygen/oxygen_mixer.c
+++ b/sound/pci/oxygen/oxygen_mixer.c
@@ -941,6 +941,33 @@ static const struct {
 		},
 	},
 	{
+		.pcm_dev = CAPTURE_3_FROM_I2S_3,
+		.controls = {
+			{
+				.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+				.name = "Analog Input Monitor Playback Switch",
+				.index = 2,
+				.info = snd_ctl_boolean_mono_info,
+				.get = monitor_get,
+				.put = monitor_put,
+				.private_value = OXYGEN_ADC_MONITOR_C,
+			},
+			{
+				.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+				.name = "Analog Input Monitor Playback Volume",
+				.index = 2,
+				.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
+					  SNDRV_CTL_ELEM_ACCESS_TLV_READ,
+				.info = monitor_volume_info,
+				.get = monitor_get,
+				.put = monitor_put,
+				.private_value = OXYGEN_ADC_MONITOR_C_HALF_VOL
+						| (1 << 8),
+				.tlv = { .p = monitor_db_scale, },
+			},
+		},
+	},
+	{
 		.pcm_dev = CAPTURE_1_FROM_SPDIF,
 		.controls = {
 			{
diff --git a/sound/pci/oxygen/oxygen_pcm.c b/sound/pci/oxygen/oxygen_pcm.c
index af22a74..aa2ebd1 100644
--- a/sound/pci/oxygen/oxygen_pcm.c
+++ b/sound/pci/oxygen/oxygen_pcm.c
@@ -144,9 +144,11 @@ static int oxygen_open(struct snd_pcm_substream *substream,
 		runtime->hw = *oxygen_hardware[channel];
 	switch (channel) {
 	case PCM_C:
-		runtime->hw.rates &= ~(SNDRV_PCM_RATE_32000 |
-				       SNDRV_PCM_RATE_64000);
-		runtime->hw.rate_min = 44100;
+		if (chip->model.device_config & CAPTURE_1_FROM_SPDIF) {
+			runtime->hw.rates &= ~(SNDRV_PCM_RATE_32000 |
+					       SNDRV_PCM_RATE_64000);
+			runtime->hw.rate_min = 44100;
+		}
 		/* fall through */
 	case PCM_A:
 	case PCM_B:
@@ -430,17 +432,36 @@ static int oxygen_rec_c_hw_params(struct snd_pcm_substream *substream,
 				  struct snd_pcm_hw_params *hw_params)
 {
 	struct oxygen *chip = snd_pcm_substream_chip(substream);
+	bool is_spdif;
 	int err;

 	err = oxygen_hw_params(substream, hw_params);
 	if (err < 0)
 		return err;

+	is_spdif = chip->model.device_config & CAPTURE_1_FROM_SPDIF;
+
 	spin_lock_irq(&chip->reg_lock);
 	oxygen_write8_masked(chip, OXYGEN_REC_FORMAT,
 			     oxygen_format(hw_params) << OXYGEN_REC_FORMAT_C_SHIFT,
 			     OXYGEN_REC_FORMAT_C_MASK);
+	if (!is_spdif)
+		oxygen_write16_masked(chip, OXYGEN_I2S_C_FORMAT,
+				      oxygen_rate(hw_params) |
+				      chip->model.adc_i2s_format |
+				      get_mclk(chip, PCM_B, hw_params) |
+				      oxygen_i2s_bits(hw_params),
+				      OXYGEN_I2S_RATE_MASK |
+				      OXYGEN_I2S_FORMAT_MASK |
+				      OXYGEN_I2S_MCLK_MASK |
+				      OXYGEN_I2S_BITS_MASK);
 	spin_unlock_irq(&chip->reg_lock);
+
+	if (!is_spdif) {
+		mutex_lock(&chip->mutex);
+		chip->model.set_adc_params(chip, hw_params);
+		mutex_unlock(&chip->mutex);
+	}
 	return 0;
 }

@@ -764,5 +785,23 @@ int oxygen_pcm_init(struct oxygen *chip)
 						      DEFAULT_BUFFER_BYTES,
 						      BUFFER_BYTES_MAX);
 	}
+
+	ins = !!(chip->model.device_config & CAPTURE_3_FROM_I2S_3);
+	if (ins) {
+		err = snd_pcm_new(chip->card, "Analog3", 3, 0, ins, &pcm);
+		if (err < 0)
+			return err;
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
+				&oxygen_rec_c_ops);
+		oxygen_write8_masked(chip, OXYGEN_REC_ROUTING,
+				     OXYGEN_REC_C_ROUTE_I2S_ADC_3,
+				     OXYGEN_REC_C_ROUTE_MASK);
+		pcm->private_data = chip;
+		strcpy(pcm->name, "Analog 3");
+		snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+						      snd_dma_pci_data(chip->pci),
+						      DEFAULT_BUFFER_BYTES,
+						      BUFFER_BYTES_MAX);
+	}
 	return 0;
 }
