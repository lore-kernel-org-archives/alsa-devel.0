From: Risto Suominen <Risto.Suominen@gmail.com>
Subject: [PATCH - snd-powermac 2/5] Correct volume controls for
	PowerBook G3 Lombard
Date: Tue, 20 Jan 2009 22:01:14 +0200
Message-ID: <1232481677-11579-2-git-send-email-Risto.Suominen@gmail.com>
References: <>
 <1232481677-11579-1-git-send-email-Risto.Suominen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gw03.mail.saunalahti.fi (gw03.mail.saunalahti.fi
	[195.197.172.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 60D04103851
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 21:01:27 +0100 (CET)
In-Reply-To: <1232481677-11579-1-git-send-email-Risto.Suominen@gmail.com>
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

Correct volume controls for PowerBook G3 Lombard (Screamer).

Signed-off-by: Risto Suominen <Risto.Suominen@gmail.com>

diff --git a/sound/ppc/awacs.c b/sound/ppc/awacs.c
index 0258ccb..d89c23e 100644
--- a/sound/ppc/awacs.c
+++ b/sound/ppc/awacs.c
@@ -773,6 +773,7 @@ static void snd_pmac_awacs_resume(struct snd_pmac *chip)
 #define IS_IMAC2 (machine_is_compatible("PowerMac2,2") \
 		|| machine_is_compatible("PowerMac4,1"))
 #define IS_G4AGP (machine_is_compatible("PowerMac3,1"))
+#define IS_LOMBARD (machine_is_compatible("PowerBook1,1"))
 
 static int imac1, imac2;
 
@@ -862,6 +863,7 @@ snd_pmac_awacs_init(struct snd_pmac *chip)
 	int pm5500 = IS_PM5500;
 	int beige = IS_BEIGE;
 	int g4agp = IS_G4AGP;
+	int lombard = IS_LOMBARD;
 	int imac;
 	int err, vol;
 
@@ -972,7 +974,7 @@ snd_pmac_awacs_init(struct snd_pmac *chip)
 		err = build_mixers(chip,
 				   ARRAY_SIZE(snd_pmac_screamer_mixers_beige),
 				   snd_pmac_screamer_mixers_beige);
-	else if (imac)
+	else if (imac || lombard)
 		err = build_mixers(chip,
 				   ARRAY_SIZE(snd_pmac_screamer_mixers_imac),
 				   snd_pmac_screamer_mixers_imac);
@@ -986,7 +988,7 @@ snd_pmac_awacs_init(struct snd_pmac *chip)
 				   snd_pmac_awacs_mixers_pmac);
 	if (err < 0)
 		return err;
-	chip->master_sw_ctl = snd_ctl_new1((pm7500 || imac || g4agp)
+	chip->master_sw_ctl = snd_ctl_new1((pm7500 || imac || g4agp || lombard)
 			? &snd_pmac_awacs_master_sw_imac
 			: &snd_pmac_awacs_master_sw, chip);
 	err = snd_ctl_add(chip->card, chip->master_sw_ctl);
-- 
1.5.4.3
