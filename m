From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/4] ALSA: Fix invalid kerneldoc markers
Date: Mon, 10 Nov 2014 17:32:35 +0100
Message-ID: <1415637155-20918-5-git-send-email-tiwai@suse.de>
References: <1415637155-20918-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E6E8D262607
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 17:32:41 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id CB014ABE7
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 16:32:41 +0000 (UTC)
In-Reply-To: <1415637155-20918-1-git-send-email-tiwai@suse.de>
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

They are no real kerneldoc comments, so drop such markers.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/uapi/sound/hdspm.h   | 12 +++++------
 sound/pci/emu10k1/emu10k1x.c |  2 +-
 sound/pci/lx6464es/lx_defs.h |  2 +-
 sound/pci/rme9652/hdspm.c    | 48 ++++++++++++++++++++++----------------------
 4 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/include/uapi/sound/hdspm.h b/include/uapi/sound/hdspm.h
index d956c3593f65..b357f1a5e29c 100644
--- a/include/uapi/sound/hdspm.h
+++ b/include/uapi/sound/hdspm.h
@@ -74,14 +74,14 @@ struct hdspm_config {
 #define SNDRV_HDSPM_IOCTL_GET_CONFIG \
 	_IOR('H', 0x41, struct hdspm_config)
 
-/**
+/*
  * If there's a TCO (TimeCode Option) board installed,
  * there are further options and status data available.
  * The hdspm_ltc structure contains the current SMPTE
  * timecode and some status information and can be
  * obtained via SNDRV_HDSPM_IOCTL_GET_LTC or in the
  * hdspm_status struct.
- **/
+ */
 
 enum hdspm_ltc_format {
 	format_invalid,
@@ -113,11 +113,11 @@ struct hdspm_ltc {
 
 #define SNDRV_HDSPM_IOCTL_GET_LTC _IOR('H', 0x46, struct hdspm_ltc)
 
-/**
+/*
  * The status data reflects the device's current state
  * as determined by the card's configuration and
  * connection status.
- **/
+ */
 
 enum hdspm_sync {
 	hdspm_sync_no_lock = 0,
@@ -171,9 +171,9 @@ struct hdspm_status {
 #define SNDRV_HDSPM_IOCTL_GET_STATUS \
 	_IOR('H', 0x47, struct hdspm_status)
 
-/**
+/*
  * Get information about the card and its add-ons.
- **/
+ */
 
 #define HDSPM_ADDON_TCO 1
 
diff --git a/sound/pci/emu10k1/emu10k1x.c b/sound/pci/emu10k1/emu10k1x.c
index e223de1408c0..15933f92f63a 100644
--- a/sound/pci/emu10k1/emu10k1x.c
+++ b/sound/pci/emu10k1/emu10k1x.c
@@ -180,7 +180,7 @@ MODULE_PARM_DESC(enable, "Enable the EMU10K1X soundcard.");
 
 /* From 0x50 - 0x5f, last samples captured */
 
-/**
+/*
  * The hardware has 3 channels for playback and 1 for capture.
  *  - channel 0 is the front channel
  *  - channel 1 is the rear channel
diff --git a/sound/pci/lx6464es/lx_defs.h b/sound/pci/lx6464es/lx_defs.h
index 49d36bdd512c..469bcc685edf 100644
--- a/sound/pci/lx6464es/lx_defs.h
+++ b/sound/pci/lx6464es/lx_defs.h
@@ -175,7 +175,7 @@ enum buffer_flags {
 	BF_ZERO		= 0x00,	/* no flags (init).*/
 };
 
-/**
+/*
 *	Stream Flags definitions
 */
 enum stream_flags {
diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index e09348c156d8..3342705a5715 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -2201,10 +2201,10 @@ static inline int hdspm_get_pll_freq(struct hdspm *hdspm)
 	return rate;
 }
 
-/**
+/*
  * Calculate the real sample rate from the
  * current DDS value.
- **/
+ */
 static int hdspm_get_system_sample_rate(struct hdspm *hdspm)
 {
 	unsigned int rate;
@@ -2270,9 +2270,9 @@ static int snd_hdspm_put_system_sample_rate(struct snd_kcontrol *kcontrol,
 }
 
 
-/**
+/*
  * Returns the WordClock sample rate class for the given card.
- **/
+ */
 static int hdspm_get_wc_sample_rate(struct hdspm *hdspm)
 {
 	int status;
@@ -2295,9 +2295,9 @@ static int hdspm_get_wc_sample_rate(struct hdspm *hdspm)
 }
 
 
-/**
+/*
  * Returns the TCO sample rate class for the given card.
- **/
+ */
 static int hdspm_get_tco_sample_rate(struct hdspm *hdspm)
 {
 	int status;
@@ -2321,9 +2321,9 @@ static int hdspm_get_tco_sample_rate(struct hdspm *hdspm)
 }
 
 
-/**
+/*
  * Returns the SYNC_IN sample rate class for the given card.
- **/
+ */
 static int hdspm_get_sync_in_sample_rate(struct hdspm *hdspm)
 {
 	int status;
@@ -2343,9 +2343,9 @@ static int hdspm_get_sync_in_sample_rate(struct hdspm *hdspm)
 	return 0;
 }
 
-/**
+/*
  * Returns the AES sample rate class for the given card.
- **/
+ */
 static int hdspm_get_aes_sample_rate(struct hdspm *hdspm, int index)
 {
 	int timecode;
@@ -2361,10 +2361,10 @@ static int hdspm_get_aes_sample_rate(struct hdspm *hdspm, int index)
 	return 0;
 }
 
-/**
+/*
  * Returns the sample rate class for input source <idx> for
  * 'new style' cards like the AIO and RayDAT.
- **/
+ */
 static int hdspm_get_s1_sample_rate(struct hdspm *hdspm, unsigned int idx)
 {
 	int status = hdspm_read(hdspm, HDSPM_RD_STATUS_2);
@@ -2512,10 +2512,10 @@ static int snd_hdspm_get_autosync_sample_rate(struct snd_kcontrol *kcontrol,
 }
 
 
-/**
+/*
  * Returns the system clock mode for the given card.
  * @returns 0 - master, 1 - slave
- **/
+ */
 static int hdspm_system_clock_mode(struct hdspm *hdspm)
 {
 	switch (hdspm->io_type) {
@@ -2534,10 +2534,10 @@ static int hdspm_system_clock_mode(struct hdspm *hdspm)
 }
 
 
-/**
+/*
  * Sets the system clock mode.
  * @param mode 0 - master, 1 - slave
- **/
+ */
 static void hdspm_set_system_clock_mode(struct hdspm *hdspm, int mode)
 {
 	hdspm_set_toggle_setting(hdspm,
@@ -2692,11 +2692,11 @@ static int snd_hdspm_put_clock_source(struct snd_kcontrol *kcontrol,
 }
 
 
-/**
+/*
  * Returns the current preferred sync reference setting.
  * The semantics of the return value are depending on the
  * card, please see the comments for clarification.
- **/
+ */
 static int hdspm_pref_sync_ref(struct hdspm * hdspm)
 {
 	switch (hdspm->io_type) {
@@ -2795,11 +2795,11 @@ static int hdspm_pref_sync_ref(struct hdspm * hdspm)
 }
 
 
-/**
+/*
  * Set the preferred sync reference to <pref>. The semantics
  * of <pref> are depending on the card type, see the comments
  * for clarification.
- **/
+ */
 static int hdspm_set_pref_sync_ref(struct hdspm * hdspm, int pref)
 {
 	int p = 0;
@@ -4101,9 +4101,9 @@ static int snd_hdspm_get_sync_check(struct snd_kcontrol *kcontrol,
 
 
 
-/**
+/*
  * TCO controls
- **/
+ */
 static void hdspm_tco_write(struct hdspm *hdspm)
 {
 	unsigned int tc[4] = { 0, 0, 0, 0};
@@ -5403,7 +5403,7 @@ static irqreturn_t snd_hdspm_interrupt(int irq, void *dev_id)
 			HDSPM_midi2IRQPending | HDSPM_midi3IRQPending);
 
 	/* now = get_cycles(); */
-	/**
+	/*
 	 *   LAT_2..LAT_0 period  counter (win)  counter (mac)
 	 *          6       4096   ~256053425     ~514672358
 	 *          5       2048   ~128024983     ~257373821
@@ -5412,7 +5412,7 @@ static irqreturn_t snd_hdspm_interrupt(int irq, void *dev_id)
 	 *          2        256    ~16003039      ~32260176
 	 *          1        128     ~7998738      ~16194507
 	 *          0         64     ~3998231       ~8191558
-	 **/
+	 */
 	/*
 	  dev_info(hdspm->card->dev, "snd_hdspm_interrupt %llu @ %llx\n",
 	   now-hdspm->last_interrupt, status & 0xFFC0);
-- 
2.1.3
