From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH] ALSA: snd-usb-caiaq: fix stream count check
Date: Sun,  4 Jan 2015 19:59:29 +0100
Message-ID: <1420397969-12961-1-git-send-email-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BFC9260684
 for <alsa-devel@alsa-project.org>; Sun,  4 Jan 2015 19:59:41 +0100 (CET)
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
Cc: tiwai@suse.de, "[v3.18+]"@mail.zonque.de, stable@kernel.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Commit 897c329bc ("ALSA: usb: caiaq: check for cdev->n_streams > 1")
introduced a safety check to protect against bogus data provided by
devices. However, the n_streams variable is already divided by
CHANNELS_PER_STREAM, so the correct check is 'n_streams > 0'.

Fix this to un-break support for stereo devices.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Cc: stable@kernel.org [v3.18+]
---
 sound/usb/caiaq/audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
index 2728447..327f864 100644
--- a/sound/usb/caiaq/audio.c
+++ b/sound/usb/caiaq/audio.c
@@ -816,7 +816,7 @@ int snd_usb_caiaq_audio_init(struct snd_usb_caiaqdev *cdev)
 		return -EINVAL;
 	}
 
-	if (cdev->n_streams < 2) {
+	if (cdev->n_streams < 1) {
 		dev_err(dev, "bogus number of streams: %d\n", cdev->n_streams);
 		return -EINVAL;
 	}
-- 
2.2.0
