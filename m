From: Peter Rosin <peda@lysator.liu.se>
Subject: [PATCH 1/1] ALSA: AT73C213: Rectify misleading comment.
Date: Wed, 10 Nov 2010 15:55:05 +0100
Message-ID: <4CDAB249.40407@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>From 0cacebce4aaa9a3ea460df8aac1cdd39e2e71527 Mon Sep 17 00:00:00 2001
From: Peter Rosin <peda@axentia.se>
Date: Wed, 10 Nov 2010 15:49:44 +0100
Subject: [PATCH 1/1] ALSA: AT73C213: Rectify misleading comment.

The Atmel SSC can divide by even numbers, not only powers of two.

Signed-off-by: Peter Rosin <peda@axentia.se>

diff --git a/sound/spi/at73c213.c b/sound/spi/at73c213.c
index 1bc56b2..337a002 100644
--- a/sound/spi/at73c213.c
+++ b/sound/spi/at73c213.c
@@ -155,7 +155,7 @@ static int snd_at73c213_set_bitrate(struct snd_at73c213 *chip)
 	if (max_tries < 1)
 		max_tries = 1;
 
-	/* ssc_div must be a power of 2. */
+	/* ssc_div must be even. */
 	ssc_div = (ssc_div + 1) & ~1UL;
 
 	if ((ssc_rate / (ssc_div * 2 * 16)) < BITRATE_MIN) {
-- 
1.7.2.3
