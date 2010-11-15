From: Peter Rosin <peda@axentia.se>
Subject: [PATCH] ALSA: AT73C213: Rectify misleading comments.
Date: Mon, 15 Nov 2010 12:29:06 +0100
Message-ID: <1289820546-2078-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	by alsa0.perex.cz (Postfix) with ESMTP id D536D24152
	for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2010 12:29:35 +0100 (CET)
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
Cc: Peter Rosin <peda@axentia.se>, Hans-Christian Egtvedt <hcegtvedt@atmel.com>
List-Id: alsa-devel@alsa-project.org

The Atmel SSC can divide by even numbers, not only powers of two and
the given values are binary, not hexadecimal.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/spi/at73c213.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

I'm working on a driver based on AT73C213 and have had to look up
if the below nits were code problems or comment problems.  The Atmel
specs tells me that the comments are wrong and this patch fixes
those comments.

Cheers and thanks,
Peter

diff --git a/sound/spi/at73c213.c b/sound/spi/at73c213.c
index 1bc56b2..548e17a 100644
--- a/sound/spi/at73c213.c
+++ b/sound/spi/at73c213.c
@@ -155,7 +155,7 @@ static int snd_at73c213_set_bitrate(struct snd_at73c213 *chip)
 	if (max_tries < 1)
 		max_tries = 1;
 
-	/* ssc_div must be a power of 2. */
+	/* ssc_div must be even. */
 	ssc_div = (ssc_div + 1) & ~1UL;
 
 	if ((ssc_rate / (ssc_div * 2 * 16)) < BITRATE_MIN) {
@@ -621,7 +621,7 @@ static int snd_at73c213_line_capture_volume_info(
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 2;
-	/* When inverted will give values 0x10001 => 0. */
+	/* When inverted will give values 10001b => 0. */
 	uinfo->value.integer.min = 14;
 	uinfo->value.integer.max = 31;
 
@@ -634,7 +634,7 @@ static int snd_at73c213_aux_capture_volume_info(
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 1;
-	/* When inverted will give values 0x10001 => 0. */
+	/* When inverted will give values 10001b => 0. */
 	uinfo->value.integer.min = 14;
 	uinfo->value.integer.max = 31;
 
-- 
1.7.2.3
