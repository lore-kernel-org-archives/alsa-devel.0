From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 4/6] ALSA: seq: remove unused symbols
Date: Sun, 25 Jan 2015 14:35:58 +0100
Message-ID: <54C4F13E.5030609@ladisch.de>
References: <54C4F0A1.2000907@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 24A182604BE
 for <alsa-devel@alsa-project.org>; Sun, 25 Jan 2015 14:36:00 +0100 (CET)
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

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 include/sound/seq_kernel.h |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/sound/seq_kernel.h b/include/sound/seq_kernel.h
index eea5400..ab8ddd9 100644
--- a/include/sound/seq_kernel.h
+++ b/include/sound/seq_kernel.h
@@ -27,9 +27,6 @@
 typedef struct snd_seq_real_time snd_seq_real_time_t;
 typedef union snd_seq_timestamp snd_seq_timestamp_t;

-/* maximum number of events dequeued per schedule interval */
-#define SNDRV_SEQ_MAX_DEQUEUE		50
-
 /* maximum number of queues */
 #define SNDRV_SEQ_MAX_QUEUES		8

@@ -42,9 +39,6 @@ typedef union snd_seq_timestamp snd_seq_timestamp_t;
 /* max number of events in memory pool */
 #define SNDRV_SEQ_MAX_EVENTS		2000

-/* default number of events in memory chunk */
-#define SNDRV_SEQ_DEFAULT_CHUNK_EVENTS	64
-
 /* default number of events in memory pool */
 #define SNDRV_SEQ_DEFAULT_EVENTS	500
