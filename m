From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 16/16] ALSA: pci: make snd_pcm_hardware const
Date: Sat, 12 Aug 2017 21:01:28 +0530
Message-ID: <1502551888-30325-17-git-send-email-bhumirks@gmail.com>
References: <1502551888-30325-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502551888-30325-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, T-Bone@parisc-linux.org, perex@perex.cz, tiwai@suse.com, clemens@ladisch.de, jayakumar.alsa@gmail.com, linux-parisc@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make these const as they are only used during a copy operation.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/pci/ad1889.c        |  4 ++--
 sound/pci/als300.c        |  4 ++--
 sound/pci/als4000.c       |  4 ++--
 sound/pci/atiixp.c        |  2 +-
 sound/pci/atiixp_modem.c  |  2 +-
 sound/pci/bt87x.c         |  4 ++--
 sound/pci/cmipci.c        | 12 ++++++------
 sound/pci/cs4281.c        |  4 ++--
 sound/pci/ens1370.c       |  6 +++---
 sound/pci/es1938.c        |  4 ++--
 sound/pci/es1968.c        |  4 ++--
 sound/pci/fm801.c         |  4 ++--
 sound/pci/intel8x0.c      |  2 +-
 sound/pci/intel8x0m.c     |  2 +-
 sound/pci/maestro3.c      |  4 ++--
 sound/pci/rme32.c         |  8 ++++----
 sound/pci/rme96.c         |  8 ++++----
 sound/pci/sis7019.c       |  4 ++--
 sound/pci/sonicvibes.c    |  4 ++--
 sound/pci/via82xx.c       |  2 +-
 sound/pci/via82xx_modem.c |  2 +-
 21 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/sound/pci/ad1889.c b/sound/pci/ad1889.c
index 8c36990..0bf2c04 100644
--- a/sound/pci/ad1889.c
+++ b/sound/pci/ad1889.c
@@ -283,7 +283,7 @@ struct snd_ad1889 {
 	return snd_pcm_lib_free_pages(substream);
 }
 
-static struct snd_pcm_hardware snd_ad1889_playback_hw = {
+static const struct snd_pcm_hardware snd_ad1889_playback_hw = {
 	.info = SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_BLOCK_TRANSFER,
 	.formats = SNDRV_PCM_FMTBIT_S16_LE,
@@ -300,7 +300,7 @@ struct snd_ad1889 {
 	/*.fifo_size = 0,*/
 };
 
-static struct snd_pcm_hardware snd_ad1889_capture_hw = {
+static const struct snd_pcm_hardware snd_ad1889_capture_hw = {
 	.info = SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_BLOCK_TRANSFER,
 	.formats = SNDRV_PCM_FMTBIT_S16_LE,
diff --git a/sound/pci/als300.c b/sound/pci/als300.c
index ab75601..eaa2d85 100644
--- a/sound/pci/als300.c
+++ b/sound/pci/als300.c
@@ -328,7 +328,7 @@ static int snd_als300_ac97(struct snd_als300 *chip)
  * the card when it is running outside of legacy
  * mode.
  */
-static struct snd_pcm_hardware snd_als300_playback_hw =
+static const struct snd_pcm_hardware snd_als300_playback_hw =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP |
 				SNDRV_PCM_INFO_INTERLEAVED |
@@ -347,7 +347,7 @@ static int snd_als300_ac97(struct snd_als300 *chip)
 	.periods_max =		2,
 };
 
-static struct snd_pcm_hardware snd_als300_capture_hw =
+static const struct snd_pcm_hardware snd_als300_capture_hw =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP |
 				SNDRV_PCM_INFO_INTERLEAVED |
diff --git a/sound/pci/als4000.c b/sound/pci/als4000.c
index 7844a75..26b097e 100644
--- a/sound/pci/als4000.c
+++ b/sound/pci/als4000.c
@@ -592,7 +592,7 @@ static irqreturn_t snd_als4000_interrupt(int irq, void *dev_id)
 
 /*****************************************************************/
 
-static struct snd_pcm_hardware snd_als4000_playback =
+static const struct snd_pcm_hardware snd_als4000_playback =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_MMAP_VALID),
@@ -611,7 +611,7 @@ static irqreturn_t snd_als4000_interrupt(int irq, void *dev_id)
 	.fifo_size =		0
 };
 
-static struct snd_pcm_hardware snd_als4000_capture =
+static const struct snd_pcm_hardware snd_als4000_capture =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_MMAP_VALID),
diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
index a40c918..de53c2a 100644
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -1009,7 +1009,7 @@ static int snd_atiixp_pcm_hw_free(struct snd_pcm_substream *substream)
 /*
  * pcm hardware definition, identical for all DMA types
  */
-static struct snd_pcm_hardware snd_atiixp_pcm_hw =
+static const struct snd_pcm_hardware snd_atiixp_pcm_hw =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
diff --git a/sound/pci/atiixp_modem.c b/sound/pci/atiixp_modem.c
index 52e0ea7..a586635 100644
--- a/sound/pci/atiixp_modem.c
+++ b/sound/pci/atiixp_modem.c
@@ -834,7 +834,7 @@ static int snd_atiixp_pcm_hw_free(struct snd_pcm_substream *substream)
 /*
  * pcm hardware definition, identical for all DMA types
  */
-static struct snd_pcm_hardware snd_atiixp_pcm_hw =
+static const struct snd_pcm_hardware snd_atiixp_pcm_hw =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
diff --git a/sound/pci/bt87x.c b/sound/pci/bt87x.c
index de02342..d8ade87 100644
--- a/sound/pci/bt87x.c
+++ b/sound/pci/bt87x.c
@@ -353,7 +353,7 @@ static irqreturn_t snd_bt87x_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct snd_pcm_hardware snd_bt87x_digital_hw = {
+static const struct snd_pcm_hardware snd_bt87x_digital_hw = {
 	.info = SNDRV_PCM_INFO_MMAP |
 		SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -370,7 +370,7 @@ static irqreturn_t snd_bt87x_interrupt(int irq, void *dev_id)
 	.periods_max = 255,
 };
 
-static struct snd_pcm_hardware snd_bt87x_analog_hw = {
+static const struct snd_pcm_hardware snd_bt87x_analog_hw = {
 	.info = SNDRV_PCM_INFO_MMAP |
 		SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index a460cb6..a45245f 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -1477,7 +1477,7 @@ static irqreturn_t snd_cmipci_interrupt(int irq, void *dev_id)
  */
 
 /* playback on channel A */
-static struct snd_pcm_hardware snd_cmipci_playback =
+static const struct snd_pcm_hardware snd_cmipci_playback =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER | SNDRV_PCM_INFO_PAUSE |
@@ -1497,7 +1497,7 @@ static irqreturn_t snd_cmipci_interrupt(int irq, void *dev_id)
 };
 
 /* capture on channel B */
-static struct snd_pcm_hardware snd_cmipci_capture =
+static const struct snd_pcm_hardware snd_cmipci_capture =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER | SNDRV_PCM_INFO_PAUSE |
@@ -1517,7 +1517,7 @@ static irqreturn_t snd_cmipci_interrupt(int irq, void *dev_id)
 };
 
 /* playback on channel B - stereo 16bit only? */
-static struct snd_pcm_hardware snd_cmipci_playback2 =
+static const struct snd_pcm_hardware snd_cmipci_playback2 =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER | SNDRV_PCM_INFO_PAUSE |
@@ -1537,7 +1537,7 @@ static irqreturn_t snd_cmipci_interrupt(int irq, void *dev_id)
 };
 
 /* spdif playback on channel A */
-static struct snd_pcm_hardware snd_cmipci_playback_spdif =
+static const struct snd_pcm_hardware snd_cmipci_playback_spdif =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER | SNDRV_PCM_INFO_PAUSE |
@@ -1557,7 +1557,7 @@ static irqreturn_t snd_cmipci_interrupt(int irq, void *dev_id)
 };
 
 /* spdif playback on channel A (32bit, IEC958 subframes) */
-static struct snd_pcm_hardware snd_cmipci_playback_iec958_subframe =
+static const struct snd_pcm_hardware snd_cmipci_playback_iec958_subframe =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER | SNDRV_PCM_INFO_PAUSE |
@@ -1577,7 +1577,7 @@ static irqreturn_t snd_cmipci_interrupt(int irq, void *dev_id)
 };
 
 /* spdif capture on channel B */
-static struct snd_pcm_hardware snd_cmipci_capture_spdif =
+static const struct snd_pcm_hardware snd_cmipci_capture_spdif =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER | SNDRV_PCM_INFO_PAUSE |
diff --git a/sound/pci/cs4281.c b/sound/pci/cs4281.c
index ee7ba4b..ec42476 100644
--- a/sound/pci/cs4281.c
+++ b/sound/pci/cs4281.c
@@ -847,7 +847,7 @@ static snd_pcm_uframes_t snd_cs4281_pointer(struct snd_pcm_substream *substream)
 	       snd_cs4281_peekBA0(chip, dma->regDCC) - 1;
 }
 
-static struct snd_pcm_hardware snd_cs4281_playback =
+static const struct snd_pcm_hardware snd_cs4281_playback =
 {
 	.info =			SNDRV_PCM_INFO_MMAP |
 				SNDRV_PCM_INFO_INTERLEAVED |
@@ -872,7 +872,7 @@ static snd_pcm_uframes_t snd_cs4281_pointer(struct snd_pcm_substream *substream)
 	.fifo_size =		CS4281_FIFO_SIZE,
 };
 
-static struct snd_pcm_hardware snd_cs4281_capture =
+static const struct snd_pcm_hardware snd_cs4281_capture =
 {
 	.info =			SNDRV_PCM_INFO_MMAP |
 				SNDRV_PCM_INFO_INTERLEAVED |
diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index f0d978e..d4cd645 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -1059,7 +1059,7 @@ static snd_pcm_uframes_t snd_ensoniq_capture_pointer(struct snd_pcm_substream *s
 	return ptr;
 }
 
-static struct snd_pcm_hardware snd_ensoniq_playback1 =
+static const struct snd_pcm_hardware snd_ensoniq_playback1 =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -1086,7 +1086,7 @@ static snd_pcm_uframes_t snd_ensoniq_capture_pointer(struct snd_pcm_substream *s
 	.fifo_size =		0,
 };
 
-static struct snd_pcm_hardware snd_ensoniq_playback2 =
+static const struct snd_pcm_hardware snd_ensoniq_playback2 =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -1106,7 +1106,7 @@ static snd_pcm_uframes_t snd_ensoniq_capture_pointer(struct snd_pcm_substream *s
 	.fifo_size =		0,
 };
 
-static struct snd_pcm_hardware snd_ensoniq_capture =
+static const struct snd_pcm_hardware snd_ensoniq_capture =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
diff --git a/sound/pci/es1938.c b/sound/pci/es1938.c
index 069902a..9d248eb 100644
--- a/sound/pci/es1938.c
+++ b/sound/pci/es1938.c
@@ -900,7 +900,7 @@ static int snd_es1938_pcm_hw_free(struct snd_pcm_substream *substream)
 /* ----------------------------------------------------------------------
  * Audio1 Capture (ADC)
  * ----------------------------------------------------------------------*/
-static struct snd_pcm_hardware snd_es1938_capture =
+static const struct snd_pcm_hardware snd_es1938_capture =
 {
 	.info =			(SNDRV_PCM_INFO_INTERLEAVED |
 				SNDRV_PCM_INFO_BLOCK_TRANSFER),
@@ -922,7 +922,7 @@ static int snd_es1938_pcm_hw_free(struct snd_pcm_substream *substream)
 /* -----------------------------------------------------------------------
  * Audio2 Playback (DAC)
  * -----------------------------------------------------------------------*/
-static struct snd_pcm_hardware snd_es1938_playback =
+static const struct snd_pcm_hardware snd_es1938_playback =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
index 2ec2b1c..0b1845c 100644
--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -1290,7 +1290,7 @@ static snd_pcm_uframes_t snd_es1968_pcm_pointer(struct snd_pcm_substream *substr
 	return bytes_to_frames(substream->runtime, ptr % es->dma_size);
 }
 
-static struct snd_pcm_hardware snd_es1968_playback = {
+static const struct snd_pcm_hardware snd_es1968_playback = {
 	.info =			(SNDRV_PCM_INFO_MMAP |
                		         SNDRV_PCM_INFO_MMAP_VALID |
 				 SNDRV_PCM_INFO_INTERLEAVED |
@@ -1311,7 +1311,7 @@ static snd_pcm_uframes_t snd_es1968_pcm_pointer(struct snd_pcm_substream *substr
 	.fifo_size =		0,
 };
 
-static struct snd_pcm_hardware snd_es1968_capture = {
+static const struct snd_pcm_hardware snd_es1968_capture = {
 	.info =			(SNDRV_PCM_INFO_NONINTERLEAVED |
 				 SNDRV_PCM_INFO_MMAP |
 				 SNDRV_PCM_INFO_MMAP_VALID |
diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index 8e6b04b..73a67bc 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -599,7 +599,7 @@ static irqreturn_t snd_fm801_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct snd_pcm_hardware snd_fm801_playback =
+static const struct snd_pcm_hardware snd_fm801_playback =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -619,7 +619,7 @@ static irqreturn_t snd_fm801_interrupt(int irq, void *dev_id)
 	.fifo_size =		0,
 };
 
-static struct snd_pcm_hardware snd_fm801_capture =
+static const struct snd_pcm_hardware snd_fm801_capture =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index fcd032e..851ccff 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -1115,7 +1115,7 @@ static snd_pcm_uframes_t snd_intel8x0_pcm_pointer(struct snd_pcm_substream *subs
 	return bytes_to_frames(substream->runtime, ptr);
 }
 
-static struct snd_pcm_hardware snd_intel8x0_stream =
+static const struct snd_pcm_hardware snd_intel8x0_stream =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
diff --git a/sound/pci/intel8x0m.c b/sound/pci/intel8x0m.c
index 2f1b878..3a4769a 100644
--- a/sound/pci/intel8x0m.c
+++ b/sound/pci/intel8x0m.c
@@ -611,7 +611,7 @@ static int snd_intel8x0m_pcm_prepare(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_hardware snd_intel8x0m_stream =
+static const struct snd_pcm_hardware snd_intel8x0m_stream =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
diff --git a/sound/pci/maestro3.c b/sound/pci/maestro3.c
index cafea6d..97ac80a 100644
--- a/sound/pci/maestro3.c
+++ b/sound/pci/maestro3.c
@@ -1681,7 +1681,7 @@ static irqreturn_t snd_m3_interrupt(int irq, void *dev_id)
 /*
  */
 
-static struct snd_pcm_hardware snd_m3_playback =
+static const struct snd_pcm_hardware snd_m3_playback =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP |
 				 SNDRV_PCM_INFO_INTERLEAVED |
@@ -1702,7 +1702,7 @@ static irqreturn_t snd_m3_interrupt(int irq, void *dev_id)
 	.periods_max =		1024,
 };
 
-static struct snd_pcm_hardware snd_m3_capture =
+static const struct snd_pcm_hardware snd_m3_capture =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP |
 				 SNDRV_PCM_INFO_INTERLEAVED |
diff --git a/sound/pci/rme32.c b/sound/pci/rme32.c
index e4cdef9..f0906ba 100644
--- a/sound/pci/rme32.c
+++ b/sound/pci/rme32.c
@@ -314,7 +314,7 @@ static int snd_rme32_capture_copy_kernel(struct snd_pcm_substream *substream,
 /*
  * SPDIF I/O capabilities (half-duplex mode)
  */
-static struct snd_pcm_hardware snd_rme32_spdif_info = {
+static const struct snd_pcm_hardware snd_rme32_spdif_info = {
 	.info =		(SNDRV_PCM_INFO_MMAP_IOMEM |
 			 SNDRV_PCM_INFO_MMAP_VALID |
 			 SNDRV_PCM_INFO_INTERLEAVED | 
@@ -340,7 +340,7 @@ static int snd_rme32_capture_copy_kernel(struct snd_pcm_substream *substream,
 /*
  * ADAT I/O capabilities (half-duplex mode)
  */
-static struct snd_pcm_hardware snd_rme32_adat_info =
+static const struct snd_pcm_hardware snd_rme32_adat_info =
 {
 	.info =		     (SNDRV_PCM_INFO_MMAP_IOMEM |
 			      SNDRV_PCM_INFO_MMAP_VALID |
@@ -365,7 +365,7 @@ static int snd_rme32_capture_copy_kernel(struct snd_pcm_substream *substream,
 /*
  * SPDIF I/O capabilities (full-duplex mode)
  */
-static struct snd_pcm_hardware snd_rme32_spdif_fd_info = {
+static const struct snd_pcm_hardware snd_rme32_spdif_fd_info = {
 	.info =		(SNDRV_PCM_INFO_MMAP |
 			 SNDRV_PCM_INFO_MMAP_VALID |
 			 SNDRV_PCM_INFO_INTERLEAVED | 
@@ -391,7 +391,7 @@ static int snd_rme32_capture_copy_kernel(struct snd_pcm_substream *substream,
 /*
  * ADAT I/O capabilities (full-duplex mode)
  */
-static struct snd_pcm_hardware snd_rme32_adat_fd_info =
+static const struct snd_pcm_hardware snd_rme32_adat_fd_info =
 {
 	.info =		     (SNDRV_PCM_INFO_MMAP |
 			      SNDRV_PCM_INFO_MMAP_VALID |
diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
index 2e19ba5..31b9a3d 100644
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -384,7 +384,7 @@ struct rme96 {
 /*
  * Digital output capabilities (S/PDIF)
  */
-static struct snd_pcm_hardware snd_rme96_playback_spdif_info =
+static const struct snd_pcm_hardware snd_rme96_playback_spdif_info =
 {
 	.info =		     (SNDRV_PCM_INFO_MMAP_IOMEM |
 			      SNDRV_PCM_INFO_MMAP_VALID |
@@ -415,7 +415,7 @@ struct rme96 {
 /*
  * Digital input capabilities (S/PDIF)
  */
-static struct snd_pcm_hardware snd_rme96_capture_spdif_info =
+static const struct snd_pcm_hardware snd_rme96_capture_spdif_info =
 {
 	.info =		     (SNDRV_PCM_INFO_MMAP_IOMEM |
 			      SNDRV_PCM_INFO_MMAP_VALID |
@@ -446,7 +446,7 @@ struct rme96 {
 /*
  * Digital output capabilities (ADAT)
  */
-static struct snd_pcm_hardware snd_rme96_playback_adat_info =
+static const struct snd_pcm_hardware snd_rme96_playback_adat_info =
 {
 	.info =		     (SNDRV_PCM_INFO_MMAP_IOMEM |
 			      SNDRV_PCM_INFO_MMAP_VALID |
@@ -473,7 +473,7 @@ struct rme96 {
 /*
  * Digital input capabilities (ADAT)
  */
-static struct snd_pcm_hardware snd_rme96_capture_adat_info =
+static const struct snd_pcm_hardware snd_rme96_capture_adat_info =
 {
 	.info =		     (SNDRV_PCM_INFO_MMAP_IOMEM |
 			      SNDRV_PCM_INFO_MMAP_VALID |
diff --git a/sound/pci/sis7019.c b/sound/pci/sis7019.c
index 3518887..964acf3 100644
--- a/sound/pci/sis7019.c
+++ b/sound/pci/sis7019.c
@@ -159,7 +159,7 @@ struct sis7019 {
  * We'll add a constraint upon open that limits the period and buffer sample
  * size to values that are legal for the hardware.
  */
-static struct snd_pcm_hardware sis_playback_hw_info = {
+static const struct snd_pcm_hardware sis_playback_hw_info = {
 	.info = (SNDRV_PCM_INFO_MMAP |
 		 SNDRV_PCM_INFO_MMAP_VALID |
 		 SNDRV_PCM_INFO_INTERLEAVED |
@@ -180,7 +180,7 @@ struct sis7019 {
 	.periods_max = (0xfff9 / 9),
 };
 
-static struct snd_pcm_hardware sis_capture_hw_info = {
+static const struct snd_pcm_hardware sis_capture_hw_info = {
 	.info = (SNDRV_PCM_INFO_MMAP |
 		 SNDRV_PCM_INFO_MMAP_VALID |
 		 SNDRV_PCM_INFO_INTERLEAVED |
diff --git a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
index 784d762..a8abb15 100644
--- a/sound/pci/sonicvibes.c
+++ b/sound/pci/sonicvibes.c
@@ -776,7 +776,7 @@ static snd_pcm_uframes_t snd_sonicvibes_capture_pointer(struct snd_pcm_substream
 	return bytes_to_frames(substream->runtime, ptr);
 }
 
-static struct snd_pcm_hardware snd_sonicvibes_playback =
+static const struct snd_pcm_hardware snd_sonicvibes_playback =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -795,7 +795,7 @@ static snd_pcm_uframes_t snd_sonicvibes_capture_pointer(struct snd_pcm_substream
 	.fifo_size =		0,
 };
 
-static struct snd_pcm_hardware snd_sonicvibes_capture =
+static const struct snd_pcm_hardware snd_sonicvibes_capture =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
diff --git a/sound/pci/via82xx.c b/sound/pci/via82xx.c
index c767b86..3a1c0b8 100644
--- a/sound/pci/via82xx.c
+++ b/sound/pci/via82xx.c
@@ -1150,7 +1150,7 @@ static int snd_via8233_capture_prepare(struct snd_pcm_substream *substream)
 /*
  * pcm hardware definition, identical for both playback and capture
  */
-static struct snd_pcm_hardware snd_via82xx_hw =
+static const struct snd_pcm_hardware snd_via82xx_hw =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
diff --git a/sound/pci/via82xx_modem.c b/sound/pci/via82xx_modem.c
index 55f79b2..8a69221 100644
--- a/sound/pci/via82xx_modem.c
+++ b/sound/pci/via82xx_modem.c
@@ -714,7 +714,7 @@ static int snd_via82xx_pcm_prepare(struct snd_pcm_substream *substream)
 /*
  * pcm hardware definition, identical for both playback and capture
  */
-static struct snd_pcm_hardware snd_via82xx_hw =
+static const struct snd_pcm_hardware snd_via82xx_hw =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
-- 
1.9.1
