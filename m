From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: seq: Fix incorrect sanity check at
	snd_seq_oss_synth_cleanup()
Date: Mon, 25 Jan 2016 13:53:27 +0100
Message-ID: <1453726408-16004-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id ABCA3260534
 for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2016 13:53:34 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 32D5EABB0
 for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2016 12:53:33 +0000 (UTC)
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

ALSA sequencer OSS emulation code has a sanity check for currently
opened devices, but there is a thinko there, eventually it spews
warnings and skips the operation wrongly like:
  WARNING: CPU: 1 PID: 7573 at sound/core/seq/oss/seq_oss_synth.c:311

Fix this off-by-one error.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/oss/seq_oss_synth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/seq/oss/seq_oss_synth.c b/sound/core/seq/oss/seq_oss_synth.c
index 0f3b38184fe5..b16dbef04174 100644
--- a/sound/core/seq/oss/seq_oss_synth.c
+++ b/sound/core/seq/oss/seq_oss_synth.c
@@ -308,7 +308,7 @@ snd_seq_oss_synth_cleanup(struct seq_oss_devinfo *dp)
 	struct seq_oss_synth *rec;
 	struct seq_oss_synthinfo *info;
 
-	if (snd_BUG_ON(dp->max_synthdev >= SNDRV_SEQ_OSS_MAX_SYNTH_DEVS))
+	if (snd_BUG_ON(dp->max_synthdev > SNDRV_SEQ_OSS_MAX_SYNTH_DEVS))
 		return;
 	for (i = 0; i < dp->max_synthdev; i++) {
 		info = &dp->synths[i];
-- 
2.7.0
