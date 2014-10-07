From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH] ALSA: usb: caiaq: check for cdev->n_streams > 1
Date: Tue,  7 Oct 2014 14:25:13 +0200
Message-ID: <1412684713-6622-1-git-send-email-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id AFDD2260452
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 14:25:18 +0200 (CEST)
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
Cc: tiwai@suse.de, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Coverity spotted a possible DIV0 condition when cdev->n_streams is 0.

Fix this by making sure the value is > 1 in snd_usb_caiaq_audio_init().

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/usb/caiaq/audio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
index 7103b09..2728447 100644
--- a/sound/usb/caiaq/audio.c
+++ b/sound/usb/caiaq/audio.c
@@ -816,6 +816,11 @@ int snd_usb_caiaq_audio_init(struct snd_usb_caiaqdev *cdev)
 		return -EINVAL;
 	}
 
+	if (cdev->n_streams < 2) {
+		dev_err(dev, "bogus number of streams: %d\n", cdev->n_streams);
+		return -EINVAL;
+	}
+
 	ret = snd_pcm_new(cdev->chip.card, cdev->product_name, 0,
 			cdev->n_audio_out, cdev->n_audio_in, &cdev->pcm);
 
-- 
2.1.0
