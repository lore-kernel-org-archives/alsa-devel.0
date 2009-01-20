From: Risto Suominen <Risto.Suominen@gmail.com>
Subject: [PATCH - snd-powermac 1/5] Correct HP detection and
	input selectors for PMac 5500
Date: Tue, 20 Jan 2009 22:01:13 +0200
Message-ID: <1232481677-11579-1-git-send-email-Risto.Suominen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gw03.mail.saunalahti.fi (gw03.mail.saunalahti.fi
	[195.197.172.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3728F1037E3
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 21:01:24 +0100 (CET)
In-Reply-To: <>
References: <>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, Risto Suominen <Risto.Suominen@gmail.com>
List-Id: alsa-devel@alsa-project.org

Correct headphone detection and input selectors for PowerMac 5500 (AWACS).

Signed-off-by: Risto Suominen <Risto.Suominen@gmail.com>

diff --git a/sound/ppc/awacs.c b/sound/ppc/awacs.c
index 7bd33e6..0258ccb 100644
--- a/sound/ppc/awacs.c
+++ b/sound/ppc/awacs.c
@@ -767,6 +767,7 @@ static void snd_pmac_awacs_resume(struct snd_pmac *chip)
 #endif /* CONFIG_PM */
 
 #define IS_PM7500 (machine_is_compatible("AAPL,7500"))
+#define IS_PM5500 (machine_is_compatible("AAPL,e411"))
 #define IS_BEIGE (machine_is_compatible("AAPL,Gossamer"))
 #define IS_IMAC1 (machine_is_compatible("PowerMac2,1"))
 #define IS_IMAC2 (machine_is_compatible("PowerMac2,2") \
@@ -858,6 +859,7 @@ int __init
 snd_pmac_awacs_init(struct snd_pmac *chip)
 {
 	int pm7500 = IS_PM7500;
+	int pm5500 = IS_PM5500;
 	int beige = IS_BEIGE;
 	int g4agp = IS_G4AGP;
 	int imac;
@@ -915,7 +917,7 @@ snd_pmac_awacs_init(struct snd_pmac *chip)
 		/* set headphone-jack detection bit */
 		switch (chip->model) {
 		case PMAC_AWACS:
-			chip->hp_stat_mask = pm7500 ? MASK_HDPCONN
+			chip->hp_stat_mask = pm7500 || pm5500 ? MASK_HDPCONN
 				: MASK_LOCONN;
 			break;
 		case PMAC_SCREAMER:
@@ -954,7 +956,7 @@ snd_pmac_awacs_init(struct snd_pmac *chip)
 		return err;
 	if (beige || g4agp)
 		;
-	else if (chip->model == PMAC_SCREAMER)
+	else if (chip->model == PMAC_SCREAMER || pm5500)
 		err = build_mixers(chip, ARRAY_SIZE(snd_pmac_screamer_mixers2),
 				   snd_pmac_screamer_mixers2);
 	else if (!pm7500)
-- 
1.5.4.3
