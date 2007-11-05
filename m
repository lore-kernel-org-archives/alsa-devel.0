From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH] soc/sh: help GCC improve generated code
Date: Mon, 5 Nov 2007 20:03:59 +0100
Message-ID: <20071105190359.GA18964@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from roarinelk.homelinux.net (fnoeppeil59.netpark.at
	[217.175.205.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 603CA246FA
	for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2007 20:04:00 +0100 (CET)
Content-Disposition: inline
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

>From 22874e1b6db03fd42339f974fc5ea81190e7968d Mon Sep 17 00:00:00 2001
From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Mon, 5 Nov 2007 19:51:45 +0100
Subject: [PATCH] ASoC: sh: improve generated code for HAC module (AC97)

Change loops in ac97_read/write functions to count down to zero
rather than up. Gcc will then use the 'dt' (decrement-and-test) op
instead of an increment/compare op-pair.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 sound/soc/sh/hac.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sh/hac.c b/sound/soc/sh/hac.c
index 8e3f039..34b77b9 100644
--- a/sound/soc/sh/hac.c
+++ b/sound/soc/sh/hac.c
@@ -105,7 +105,7 @@ static int hac_get_codec_data(struct hac_priv *hac, unsigned short r,
 	unsigned int to1, to2, i;
 	unsigned short adr;
 
-	for (i = 0; i < AC97_READ_RETRY; ++i) {
+	for (i = AC97_READ_RETRY; i; i--) {
 		*v = 0;
 		/* wait for HAC to receive something from the codec */
 		for (to1 = TMO_E4;
@@ -132,7 +132,7 @@ static int hac_get_codec_data(struct hac_priv *hac, unsigned short r,
 		udelay(21);
 	}
 	HACREG(HACRSR) &= ~(RSR_STDRY | RSR_STARY);
-	return (i < AC97_READ_RETRY);
+	return i;
 }
 
 static unsigned short hac_read_codec_aux(struct hac_priv *hac,
@@ -141,7 +141,7 @@ static unsigned short hac_read_codec_aux(struct hac_priv *hac,
 	unsigned short val;
 	unsigned int i, to;
 
-	for (i = 0; i < AC97_READ_RETRY; i++) {
+	for (i = AC97_READ_RETRY; i; i--) {
 		/* send_read_request */
 		local_irq_disable();
 		HACREG(HACTSR) &= ~(TSR_CMDAMT);
@@ -159,10 +159,7 @@ static unsigned short hac_read_codec_aux(struct hac_priv *hac,
 			break;
 	}
 
-	if (i == AC97_READ_RETRY)
-		return ~0;
-
-	return val;
+	return i ? val : ~0;
 }
 
 static void hac_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
@@ -172,7 +169,7 @@ static void hac_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 	struct hac_priv *hac = &hac_cpu_data[unit_id];
 	unsigned int i, to;
 	/* write_codec_aux */
-	for (i = 0; i < AC97_WRITE_RETRY; i++) {
+	for (i = AC97_WRITE_RETRY; i; i--) {
 		/* send_write_request */
 		local_irq_disable();
 		HACREG(HACTSR) &= ~(TSR_CMDDMT | TSR_CMDAMT);
-- 
1.5.3.4
