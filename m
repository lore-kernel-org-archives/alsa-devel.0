From: <twischer@de.adit-jv.com>
Subject: [PATCH 07/10] ALSA: aloop: Move CABLE_VALID_BOTH to the top of file
Date: Tue, 26 Mar 2019 08:49:31 +0100
Message-ID: <1553586574-18608-3-git-send-email-twischer@de.adit-jv.com>
References: <1553529644-5654-1-git-send-email-twischer@de.adit-jv.com>
 <1553586574-18608-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553586574-18608-1-git-send-email-twischer@de.adit-jv.com>
Sender: linux-kernel-owner@vger.kernel.org
To: patch@alsa-project.org, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Timo Wischer <twischer@de.adit-jv.com>
List-Id: alsa-devel@alsa-project.org

From: Timo Wischer <twischer@de.adit-jv.com>

so all functions can use the same.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
---
 sound/drivers/aloop.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 3105757..85a1519 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -69,6 +69,10 @@ MODULE_PARM_DESC(pcm_notify, "Break capture when PCM format/rate/channels change
 
 #define NO_PITCH 100000
 
+#define CABLE_VALID_PLAYBACK	BIT(SNDRV_PCM_STREAM_PLAYBACK)
+#define CABLE_VALID_CAPTURE	BIT(SNDRV_PCM_STREAM_CAPTURE)
+#define CABLE_VALID_BOTH	(CABLE_VALID_PLAYBACK | CABLE_VALID_CAPTURE)
+
 struct loopback_cable;
 struct loopback_pcm;
 
@@ -238,10 +242,6 @@ static inline int loopback_jiffies_timer_stop_sync(struct loopback_pcm *dpcm)
 	return 0;
 }
 
-#define CABLE_VALID_PLAYBACK	(1 << SNDRV_PCM_STREAM_PLAYBACK)
-#define CABLE_VALID_CAPTURE	(1 << SNDRV_PCM_STREAM_CAPTURE)
-#define CABLE_VALID_BOTH	(CABLE_VALID_PLAYBACK|CABLE_VALID_CAPTURE)
-
 static int loopback_check_format(struct loopback_cable *cable, int stream)
 {
 	struct snd_pcm_runtime *runtime, *cruntime;
-- 
2.7.4
