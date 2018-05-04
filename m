From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: dice: support transmission mode at
	176.4/192.0 kHz for M-Audio 610/2626
Date: Fri,  4 May 2018 18:57:17 +0900
Message-ID: <20180504095717.25036-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 0806A266C1C
 for <alsa-devel@alsa-project.org>; Fri,  4 May 2018 11:58:49 +0200 (CEST)
Received: by mail-pg0-f66.google.com with SMTP id g20-v6so8451408pgv.1
 for <alsa-devel@alsa-project.org>; Fri, 04 May 2018 02:58:49 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

At highest sampling transmission frequency, ALSA dice driver
detects jumbo payload in tx packets from M-Audio 610/2626.

$ dmesg
snd_dice fw1.0: Detect jumbo payload: 0388 0348

Usual dice devices have a quirk called as dual-wire incompliant to
IEC 61883-6 at highest sampling transmission frequency. On the other hand,
M-Audio 610/2626 is compliant. This is a reason of the detection of jumbo
payload.

This commit adds support compliant transmission mode. For these devices,
tx packets are correctly handled by this driver, while rx packets can't
make these devices generate sound, unfortunately. The other factor affects
it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-stream.c | 6 +++++-
 sound/firewire/dice/dice.c        | 9 +++++++++
 sound/firewire/dice/dice.h        | 2 ++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index 422a1ab1ddf5..e3dbe357b4fa 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -204,7 +204,11 @@ static int keep_resources(struct snd_dice *dice,
 	 * For this quirk, blocking mode is required and PCM buffer size should
 	 * be aligned to SYT_INTERVAL.
 	 */
-	double_pcm_frames = rate > 96000;
+	if (rate < 176400 || dice->no_dualwire)
+		double_pcm_frames = false;
+	else
+		double_pcm_frames = true;
+
 	if (double_pcm_frames) {
 		rate /= 2;
 		pcm_chs *= 2;
diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index 40f7a32e4893..8baad7704bf0 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -236,6 +236,15 @@ static int dice_probe(struct fw_unit *unit,
 				(snd_dice_detect_formats_t)entry->driver_data;
 	}
 
+	/*
+	 * M-Audio units are compliant to IEC 61883-6 at high sampling
+	 * transmission frequency thus don't support 'dualwire' quirk. These
+	 * units have 0x0100d1 in its version field in config ROM, against
+	 * the value of DICE_INTERFACE.
+	 */
+	if (entry->vendor_id == OUI_MAUDIO)
+		dice->no_dualwire = true;
+
 	spin_lock_init(&dice->lock);
 	mutex_init(&dice->mutex);
 	init_completion(&dice->clock_accepted);
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index 505b79fea6d9..66e7a277ab68 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -113,6 +113,8 @@ struct snd_dice {
 	bool global_enabled;
 	struct completion clock_accepted;
 	unsigned int substreams_counter;
+
+	bool no_dualwire;
 };
 
 enum snd_dice_addr_type {
-- 
2.14.1
