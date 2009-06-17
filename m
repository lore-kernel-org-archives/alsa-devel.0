From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] ALSA: snd_usb_caiaq: fix legacy input streaming
Date: Wed, 17 Jun 2009 17:45:11 +0200
Message-ID: <1245253511-7242-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D7C82414F
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Jun 2009 17:45:21 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Seems that nobody recently tried the input on the very first supported
sound card model, RK2. This patch fixes the byte offset to make it
running again.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 sound/usb/caiaq/audio.c  |    5 +++--
 sound/usb/caiaq/device.c |    2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
index b144513..8f9b60c 100644
--- a/sound/usb/caiaq/audio.c
+++ b/sound/usb/caiaq/audio.c
@@ -199,8 +199,9 @@ static int snd_usb_caiaq_pcm_prepare(struct snd_pcm_substream *substream)
 		dev->period_out_count[index] = BYTES_PER_SAMPLE + 1;
 		dev->audio_out_buf_pos[index] = BYTES_PER_SAMPLE + 1;
 	} else {
-		dev->period_in_count[index] = BYTES_PER_SAMPLE;
-		dev->audio_in_buf_pos[index] = BYTES_PER_SAMPLE;
+		int in_pos = (dev->spec.data_alignment == 2) ? 0 : 2;
+		dev->period_in_count[index] = BYTES_PER_SAMPLE + in_pos;
+		dev->audio_in_buf_pos[index] = BYTES_PER_SAMPLE + in_pos;
 	}
 
 	if (dev->streaming)
diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index 2240624..0e5db71 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -35,7 +35,7 @@
 #include "input.h"
 
 MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
-MODULE_DESCRIPTION("caiaq USB audio, version 1.3.16");
+MODULE_DESCRIPTION("caiaq USB audio, version 1.3.17");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Native Instruments, RigKontrol2},"
 			 "{Native Instruments, RigKontrol3},"
-- 
1.6.3.1
