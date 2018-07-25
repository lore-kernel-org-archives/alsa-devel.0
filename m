From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/12] ALSA: msnd: Add missing __iomem
	annotations
Date: Wed, 25 Jul 2018 23:00:47 +0200
Message-ID: <20180725210057.18017-3-tiwai@suse.de>
References: <20180725210057.18017-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 81C46267757
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:01:04 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 76BEBB066
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:01:03 +0000 (UTC)
In-Reply-To: <20180725210057.18017-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The io-mapped buffers used in msnd drivers need __iomem annotations.

This fixes sparse warnings like:
  sound/isa/msnd/msnd_pinnacle.c:172:45: warning: incorrect type in initializer (different address spaces)

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/isa/msnd/msnd.c          | 18 +++++++++---------
 sound/isa/msnd/msnd.h          |  2 +-
 sound/isa/msnd/msnd_midi.c     |  2 +-
 sound/isa/msnd/msnd_pinnacle.c |  2 +-
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/isa/msnd/msnd.c b/sound/isa/msnd/msnd.c
index 569897f64fda..7c3203fe4869 100644
--- a/sound/isa/msnd/msnd.c
+++ b/sound/isa/msnd/msnd.c
@@ -54,7 +54,7 @@
 #define LOGNAME			"msnd"
 
 
-void snd_msnd_init_queue(void *base, int start, int size)
+void snd_msnd_init_queue(void __iomem *base, int start, int size)
 {
 	writew(PCTODSP_BASED(start), base + JQS_wStart);
 	writew(PCTODSP_OFFSET(size) - 1, base + JQS_wSize);
@@ -270,7 +270,7 @@ int snd_msnd_DARQ(struct snd_msnd *chip, int bank)
 		udelay(1);
 
 	if (chip->capturePeriods == 2) {
-		void *pDAQ = chip->mappedbase + DARQ_DATA_BUFF +
+		void __iomem *pDAQ = chip->mappedbase + DARQ_DATA_BUFF +
 			     bank * DAQDS__size + DAQDS_wStart;
 		unsigned short offset = 0x3000 + chip->capturePeriodBytes;
 
@@ -309,7 +309,7 @@ int snd_msnd_DAPQ(struct snd_msnd *chip, int start)
 {
 	u16	DAPQ_tail;
 	int	protect = start, nbanks = 0;
-	void	*DAQD;
+	void	__iomem *DAQD;
 	static int play_banks_submitted;
 	/* unsigned long flags;
 	spin_lock_irqsave(&chip->lock, flags); not necessary */
@@ -370,7 +370,7 @@ static void snd_msnd_play_reset_queue(struct snd_msnd *chip,
 				      unsigned int pcm_count)
 {
 	int	n;
-	void	*pDAQ = chip->mappedbase + DAPQ_DATA_BUFF;
+	void	__iomem *pDAQ = chip->mappedbase + DAPQ_DATA_BUFF;
 
 	chip->last_playbank = -1;
 	chip->playLimit = pcm_count * (pcm_periods - 1);
@@ -398,7 +398,7 @@ static void snd_msnd_capture_reset_queue(struct snd_msnd *chip,
 					 unsigned int pcm_count)
 {
 	int		n;
-	void		*pDAQ;
+	void		__iomem *pDAQ;
 	/* unsigned long	flags; */
 
 	/* snd_msnd_init_queue(chip->DARQ, DARQ_DATA_BUFF, DARQ_BUFF_SIZE); */
@@ -485,7 +485,7 @@ static int snd_msnd_playback_open(struct snd_pcm_substream *substream)
 	clear_bit(F_WRITING, &chip->flags);
 	snd_msnd_enable_irq(chip);
 
-	runtime->dma_area = chip->mappedbase;
+	runtime->dma_area = (__force void *)chip->mappedbase;
 	runtime->dma_bytes = 0x3000;
 
 	chip->playback_substream = substream;
@@ -508,7 +508,7 @@ static int snd_msnd_playback_hw_params(struct snd_pcm_substream *substream,
 {
 	int	i;
 	struct snd_msnd *chip = snd_pcm_substream_chip(substream);
-	void	*pDAQ =	chip->mappedbase + DAPQ_DATA_BUFF;
+	void	__iomem *pDAQ =	chip->mappedbase + DAPQ_DATA_BUFF;
 
 	chip->play_sample_size = snd_pcm_format_width(params_format(params));
 	chip->play_channels = params_channels(params);
@@ -589,7 +589,7 @@ static int snd_msnd_capture_open(struct snd_pcm_substream *substream)
 
 	set_bit(F_AUDIO_READ_INUSE, &chip->flags);
 	snd_msnd_enable_irq(chip);
-	runtime->dma_area = chip->mappedbase + 0x3000;
+	runtime->dma_area = (__force void *)chip->mappedbase + 0x3000;
 	runtime->dma_bytes = 0x3000;
 	memset(runtime->dma_area, 0, runtime->dma_bytes);
 	chip->capture_substream = substream;
@@ -654,7 +654,7 @@ static int snd_msnd_capture_hw_params(struct snd_pcm_substream *substream,
 {
 	int		i;
 	struct snd_msnd *chip = snd_pcm_substream_chip(substream);
-	void		*pDAQ = chip->mappedbase + DARQ_DATA_BUFF;
+	void		__iomem *pDAQ = chip->mappedbase + DARQ_DATA_BUFF;
 
 	chip->capture_sample_size = snd_pcm_format_width(params_format(params));
 	chip->capture_channels = params_channels(params);
diff --git a/sound/isa/msnd/msnd.h b/sound/isa/msnd/msnd.h
index 5f3c7dcd9f9d..80c718757eef 100644
--- a/sound/isa/msnd/msnd.h
+++ b/sound/isa/msnd/msnd.h
@@ -283,7 +283,7 @@ struct snd_msnd {
 
 };
 
-void snd_msnd_init_queue(void *base, int start, int size);
+void snd_msnd_init_queue(void __iomem *base, int start, int size);
 
 int snd_msnd_send_dsp_cmd(struct snd_msnd *chip, u8 cmd);
 int snd_msnd_send_word(struct snd_msnd *chip,
diff --git a/sound/isa/msnd/msnd_midi.c b/sound/isa/msnd/msnd_midi.c
index 013d8d1170fe..42876b0cb68b 100644
--- a/sound/isa/msnd/msnd_midi.c
+++ b/sound/isa/msnd/msnd_midi.c
@@ -119,7 +119,7 @@ void snd_msndmidi_input_read(void *mpuv)
 {
 	unsigned long flags;
 	struct snd_msndmidi *mpu = mpuv;
-	void *pwMIDQData = mpu->dev->mappedbase + MIDQ_DATA_BUFF;
+	void __iomem *pwMIDQData = mpu->dev->mappedbase + MIDQ_DATA_BUFF;
 	u16 head, tail, size;
 
 	spin_lock_irqsave(&mpu->input_lock, flags);
diff --git a/sound/isa/msnd/msnd_pinnacle.c b/sound/isa/msnd/msnd_pinnacle.c
index 6c584d9b6c42..642609f7eda9 100644
--- a/sound/isa/msnd/msnd_pinnacle.c
+++ b/sound/isa/msnd/msnd_pinnacle.c
@@ -169,7 +169,7 @@ static void snd_msnd_eval_dsp_msg(struct snd_msnd *chip, u16 wMessage)
 static irqreturn_t snd_msnd_interrupt(int irq, void *dev_id)
 {
 	struct snd_msnd *chip = dev_id;
-	void *pwDSPQData = chip->mappedbase + DSPQ_DATA_BUFF;
+	void __iomem *pwDSPQData = chip->mappedbase + DSPQ_DATA_BUFF;
 	u16 head, tail, size;
 
 	/* Send ack to DSP */
-- 
2.18.0
