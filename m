From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 6/6] ALSA: seq: increase the maximum number of
	queues
Date: Sun, 25 Jan 2015 14:36:46 +0100
Message-ID: <54C4F16E.8070005@ladisch.de>
References: <54C4F0A1.2000907@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 9A569260447
 for <alsa-devel@alsa-project.org>; Sun, 25 Jan 2015 14:36:45 +0100 (CET)
In-Reply-To: <54C4F0A1.2000907@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Queues are used both for scheduling playback events and for assigning
timestamps to recorded events, so it is easy to need quite a lot of
them, especially on a multi-user system.  Additionally, the actual
queue objects are allocated dynamically, so it does not really make
sense to have a low limit.  Increase it to something still sane.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 include/sound/seq_kernel.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/seq_kernel.h b/include/sound/seq_kernel.h
index f1c8e94..18a2ac5 100644
--- a/include/sound/seq_kernel.h
+++ b/include/sound/seq_kernel.h
@@ -28,7 +28,7 @@ typedef struct snd_seq_real_time snd_seq_real_time_t;
 typedef union snd_seq_timestamp snd_seq_timestamp_t;

 /* maximum number of queues */
-#define SNDRV_SEQ_MAX_QUEUES		8
+#define SNDRV_SEQ_MAX_QUEUES		32

 /* max number of concurrent clients */
 #define SNDRV_SEQ_MAX_CLIENTS 		192
