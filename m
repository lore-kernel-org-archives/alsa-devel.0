From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 1/2] speaker-test: move existing endian macros
	up in the file
Date: Sat,  9 May 2009 19:47:39 -0500
Message-ID: <1241916460-13648-1-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f158.google.com (mail-gx0-f158.google.com
	[209.85.217.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 3644024534
	for <alsa-devel@alsa-project.org>;
	Sun, 10 May 2009 02:48:10 +0200 (CEST)
Received: by gxk2 with SMTP id 2so4288968gxk.8
	for <alsa-devel@alsa-project.org>; Sat, 09 May 2009 17:48:09 -0700 (PDT)
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
Cc: Dan McGee <dpmcgee@gmail.com>
List-Id: alsa-devel@alsa-project.org

This is necessary for a later patch removing the various endianness checks
sprinkled throughout the code.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 speaker-test/speaker-test.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/speaker-test/speaker-test.c b/speaker-test/speaker-test.c
index d983a4f..c1d53b6 100644
--- a/speaker-test/speaker-test.c
+++ b/speaker-test/speaker-test.c
@@ -68,6 +68,16 @@ enum {
 
 #define MAX_CHANNELS	16
 
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+#define COMPOSE_ID(a,b,c,d)	((a) | ((b)<<8) | ((c)<<16) | ((d)<<24))
+#define LE_SHORT(v)		(v)
+#define LE_INT(v)		(v)
+#else
+#define COMPOSE_ID(a,b,c,d)	((d) | ((c)<<8) | ((b)<<16) | ((a)<<24))
+#define LE_SHORT(v)		bswap_16(v)
+#define LE_INT(v)		bswap_32(v)
+#endif
+
 static char              *device      = "default";       /* playback device */
 static snd_pcm_format_t   format      = SND_PCM_FORMAT_S16; /* sample format */
 static unsigned int       rate        = 48000;	            /* stream rate */
@@ -520,16 +530,6 @@ struct wave_header {
   } chunk;
 };
 
-#if __BYTE_ORDER == __LITTLE_ENDIAN
-#define COMPOSE_ID(a,b,c,d)	((a) | ((b)<<8) | ((c)<<16) | ((d)<<24))
-#define LE_SHORT(v)		(v)
-#define LE_INT(v)		(v)
-#else
-#define COMPOSE_ID(a,b,c,d)	((d) | ((c)<<8) | ((b)<<16) | ((a)<<24))
-#define LE_SHORT(v)		bswap_16(v)
-#define LE_INT(v)		bswap_32(v)
-#endif
-
 #define WAV_RIFF		COMPOSE_ID('R','I','F','F')
 #define WAV_WAVE		COMPOSE_ID('W','A','V','E')
 #define WAV_FMT			COMPOSE_ID('f','m','t',' ')
-- 
1.6.2.4
