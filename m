From: Tim Blechmann <tim@klingt.org>
Subject: [PATCH] alsa: snd_pcm_new api cleanup
Date: Thu, 5 Feb 2009 12:27:15 +0100
Message-ID: <20090205122715.5bc58b29@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DCA01037FD
	for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2009 12:27:16 +0100 (CET)
Received: from thinkpad (localhost [127.0.0.1]) (authenticated bits=0)
	by klingt.org (8.14.3/8.14.3/Debian-5) with ESMTP id n15BRFaA014439
	for <alsa-devel@alsa-project.org>; Thu, 5 Feb 2009 12:27:16 +0100
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

Impact: cleanup

snd_pcm_new takes a char *id argument, although it is not modifying
the string. it can therefore be declared as const char *id.

Signed-off-by: Tim Blechmann <tim@klingt.org>
---
 sound/core/pcm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 192a433..583453e 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -692,7 +692,7 @@ EXPORT_SYMBOL(snd_pcm_new_stream);
  *
  * Returns zero if successful, or a negative error code on failure.
  */
-int snd_pcm_new(struct snd_card *card, char *id, int device,
+int snd_pcm_new(struct snd_card *card, const char *id, int device,
 		int playback_count, int capture_count,
 	        struct snd_pcm ** rpcm)
 {
-- 
1.5.6.3
