From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 06/11] ALSA: bebob: add SYT-Match support
Date: Sun, 14 Jun 2015 12:49:32 +0900
Message-ID: <1434253777-433-7-git-send-email-o-takashi@sakamocchi.jp>
References: <1434253777-433-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id DEA832604FA
 for <alsa-devel@alsa-project.org>; Sun, 14 Jun 2015 05:49:45 +0200 (CEST)
In-Reply-To: <1434253777-433-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: kim@incendio.no, alsa-devel@alsa-project.org, jh1ood@gmail.com, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

In previous commits, this driver can detect the source of clock as mush
as possible. SYT-Match mode is also available.

This commit purge the restriction.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_pcm.c    |  5 -----
 sound/firewire/bebob/bebob_stream.c | 20 ++++++++++++++++++--
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/sound/firewire/bebob/bebob_pcm.c b/sound/firewire/bebob/bebob_pcm.c
index e3f65a0..e0a6b06 100644
--- a/sound/firewire/bebob/bebob_pcm.c
+++ b/sound/firewire/bebob/bebob_pcm.c
@@ -171,11 +171,6 @@ pcm_open(struct snd_pcm_substream *substream)
 	err = snd_bebob_stream_get_clock_src(bebob, &src);
 	if (err < 0)
 		goto err_locked;
-	/* SYT-Match is not supported. */
-	if (src == SND_BEBOB_CLOCK_TYPE_SYT) {
-		err = -EBUSY;
-		goto err_locked;
-	}
 
 	/*
 	 * When source of clock is internal or any PCM stream are running,
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index c8af8ff..5335c30 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -474,8 +474,24 @@ destroy_both_connections(struct snd_bebob *bebob)
 static int
 get_sync_mode(struct snd_bebob *bebob, enum cip_flags *sync_mode)
 {
-	/* currently this module doesn't support SYT-Match mode */
-	*sync_mode = CIP_SYNC_TO_DEVICE;
+	enum snd_bebob_clock_type src;
+	int err;
+
+	err = snd_bebob_stream_get_clock_src(bebob, &src);
+	if (err < 0)
+		return err;
+
+	switch (src) {
+	case SND_BEBOB_CLOCK_TYPE_INTERNAL:
+	case SND_BEBOB_CLOCK_TYPE_EXTERNAL:
+		*sync_mode = CIP_SYNC_TO_DEVICE;
+		break;
+	default:
+	case SND_BEBOB_CLOCK_TYPE_SYT:
+		*sync_mode = 0;
+		break;
+	}
+
 	return 0;
 }
 
-- 
2.1.4
