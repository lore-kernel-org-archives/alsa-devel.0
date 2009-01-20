From: Risto Suominen <Risto.Suominen@gmail.com>
Subject: [PATCH - snd-powermac 5/5] Add vmaster controls for
	Pmac 5500, iMac G3 SL, and PBook G3 Lombard
Date: Tue, 20 Jan 2009 22:01:17 +0200
Message-ID: <1232481677-11579-5-git-send-email-Risto.Suominen@gmail.com>
References: <> <1232481677-11579-1-git-send-email-Risto.Suominen@gmail.com>
	<1232481677-11579-2-git-send-email-Risto.Suominen@gmail.com>
	<1232481677-11579-3-git-send-email-Risto.Suominen@gmail.com>
	<1232481677-11579-4-git-send-email-Risto.Suominen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gw03.mail.saunalahti.fi (gw03.mail.saunalahti.fi
	[195.197.172.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DCCCE103861
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 21:01:36 +0100 (CET)
In-Reply-To: <1232481677-11579-4-git-send-email-Risto.Suominen@gmail.com>
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

Add virtual master controls for PowerMac 5500 (AWACS) and iMac G3 Slot-loading
and PowerBook G3 Lombard (Screamer).

Signed-off-by: Risto Suominen <Risto.Suominen@gmail.com>

diff --git a/sound/ppc/Kconfig b/sound/ppc/Kconfig
index 777de2b..bd2338a 100644
--- a/sound/ppc/Kconfig
+++ b/sound/ppc/Kconfig
@@ -13,6 +13,7 @@ config SND_POWERMAC
 	tristate "PowerMac (AWACS, DACA, Burgundy, Tumbler, Keywest)"
 	depends on I2C && INPUT && PPC_PMAC
 	select SND_PCM
+	select SND_VMASTER
 	help
 	  Say Y here to include support for the integrated sound device.
 
diff --git a/sound/ppc/awacs.c b/sound/ppc/awacs.c
index 9abbf64..66956f4 100644
--- a/sound/ppc/awacs.c
+++ b/sound/ppc/awacs.c
@@ -608,9 +608,12 @@ static struct snd_kcontrol_new snd_pmac_screamer_mixers_beige[] __initdata = {
 	AWACS_SWITCH("CD Capture Switch", 0, SHIFT_MUX_LINE, 0),
 };
 
-static struct snd_kcontrol_new snd_pmac_screamer_mixers_imac[] __initdata = {
+static struct snd_kcontrol_new snd_pmac_screamer_mixers_lo[] __initdata = {
 	AWACS_VOLUME("Line out Playback Volume", 2, 6, 1),
-	AWACS_VOLUME("Master Playback Volume", 5, 6, 1),
+};
+
+static struct snd_kcontrol_new snd_pmac_screamer_mixers_imac[] __initdata = {
+	AWACS_VOLUME("Play-through Playback Volume", 5, 6, 1),
 	AWACS_SWITCH("CD Capture Switch", 0, SHIFT_MUX_CD, 0),
 };
 
@@ -627,6 +630,10 @@ static struct snd_kcontrol_new snd_pmac_awacs_mixers_pmac7500[] __initdata = {
 	AWACS_SWITCH("Line Capture Switch", 0, SHIFT_MUX_MIC, 0),
 };
 
+static struct snd_kcontrol_new snd_pmac_awacs_mixers_pmac5500[] __initdata = {
+	AWACS_VOLUME("Headphone Playback Volume", 2, 6, 1),
+};
+
 static struct snd_kcontrol_new snd_pmac_awacs_mixers_pmac[] __initdata = {
 	AWACS_VOLUME("Master Playback Volume", 2, 6, 1),
 	AWACS_SWITCH("CD Capture Switch", 0, SHIFT_MUX_CD, 0),
@@ -645,12 +652,19 @@ static struct snd_kcontrol_new snd_pmac_screamer_mixers2[] __initdata = {
 	AWACS_SWITCH("Mic Capture Switch", 0, SHIFT_MUX_LINE, 0),
 };
 
+static struct snd_kcontrol_new snd_pmac_awacs_mixers2_pmac5500[] __initdata = {
+	AWACS_SWITCH("CD Capture Switch", 0, SHIFT_MUX_CD, 0),
+};
+
 static struct snd_kcontrol_new snd_pmac_awacs_master_sw __initdata =
 AWACS_SWITCH("Master Playback Switch", 1, SHIFT_HDMUTE, 1);
 
 static struct snd_kcontrol_new snd_pmac_awacs_master_sw_imac __initdata =
 AWACS_SWITCH("Line out Playback Switch", 1, SHIFT_HDMUTE, 1);
 
+static struct snd_kcontrol_new snd_pmac_awacs_master_sw_pmac5500 __initdata =
+AWACS_SWITCH("Headphone Playback Switch", 1, SHIFT_HDMUTE, 1);
+
 static struct snd_kcontrol_new snd_pmac_awacs_mic_boost[] __initdata = {
 	AWACS_SWITCH("Mic Boost Capture Switch", 0, SHIFT_GAINLINE, 0),
 };
@@ -868,6 +882,8 @@ snd_pmac_awacs_init(struct snd_pmac *chip)
 	int lombard = IS_LOMBARD;
 	int imac;
 	int err, vol;
+	struct snd_kcontrol *vmaster_sw, *vmaster_vol;
+	struct snd_kcontrol *master_vol, *speaker_vol;
 
 	imac1 = IS_IMAC1;
 	imac2 = IS_IMAC2;
@@ -966,21 +982,32 @@ snd_pmac_awacs_init(struct snd_pmac *chip)
 	else if (!pm7500)
 		err = build_mixers(chip, ARRAY_SIZE(snd_pmac_awacs_mixers2),
 				   snd_pmac_awacs_mixers2);
+	if (pm5500)
+		err |= build_mixers(chip,
+				   ARRAY_SIZE(snd_pmac_awacs_mixers2_pmac5500),
+				   snd_pmac_awacs_mixers2_pmac5500);
 	if (err < 0)
 		return err;
 	if (pm7500)
 		err = build_mixers(chip,
 				   ARRAY_SIZE(snd_pmac_awacs_mixers_pmac7500),
 				   snd_pmac_awacs_mixers_pmac7500);
+	else if (pm5500)
+		err = snd_ctl_add(chip->card,
+		    (master_vol = snd_ctl_new1(snd_pmac_awacs_mixers_pmac5500,
+						chip)));
 	else if (beige)
 		err = build_mixers(chip,
 				   ARRAY_SIZE(snd_pmac_screamer_mixers_beige),
 				   snd_pmac_screamer_mixers_beige);
-	else if (imac || lombard)
+	else if (imac || lombard) {
+		err = snd_ctl_add(chip->card,
+		    (master_vol = snd_ctl_new1(snd_pmac_screamer_mixers_lo,
+						chip)));
 		err = build_mixers(chip,
 				   ARRAY_SIZE(snd_pmac_screamer_mixers_imac),
 				   snd_pmac_screamer_mixers_imac);
-	else if (g4agp)
+	} else if (g4agp)
 		err = build_mixers(chip,
 				   ARRAY_SIZE(snd_pmac_screamer_mixers_g4agp),
 				   snd_pmac_screamer_mixers_g4agp);
@@ -992,6 +1019,8 @@ snd_pmac_awacs_init(struct snd_pmac *chip)
 		return err;
 	chip->master_sw_ctl = snd_ctl_new1((pm7500 || imac || g4agp || lombard)
 			? &snd_pmac_awacs_master_sw_imac
+			: pm5500
+			? &snd_pmac_awacs_master_sw_pmac5500
 			: &snd_pmac_awacs_master_sw, chip);
 	err = snd_ctl_add(chip->card, chip->master_sw_ctl);
 	if (err < 0)
@@ -1023,8 +1052,9 @@ snd_pmac_awacs_init(struct snd_pmac *chip)
 #endif /* PMAC_AMP_AVAIL */
 	{
 		/* route A = headphone, route C = speaker */
-		err = build_mixers(chip, ARRAY_SIZE(snd_pmac_awacs_speaker_vol),
-					snd_pmac_awacs_speaker_vol);
+		err = snd_ctl_add(chip->card,
+		    (speaker_vol = snd_ctl_new1(snd_pmac_awacs_speaker_vol,
+						chip)));
 		if (err < 0)
 			return err;
 		chip->speaker_sw_ctl = snd_ctl_new1(imac1
@@ -1037,6 +1067,23 @@ snd_pmac_awacs_init(struct snd_pmac *chip)
 			return err;
 	}
 
+	if (pm5500 || imac || lombard) {
+		vmaster_sw = snd_ctl_make_virtual_master(
+			"Master Playback Switch", (unsigned int *) NULL);
+		err = snd_ctl_add_slave_uncached(vmaster_sw,
+						 chip->master_sw_ctl);
+		err |= snd_ctl_add_slave_uncached(vmaster_sw,
+						  chip->speaker_sw_ctl);
+		err |= snd_ctl_add(chip->card, vmaster_sw);
+		vmaster_vol = snd_ctl_make_virtual_master(
+			"Master Playback Volume", (unsigned int *) NULL);
+		err |= snd_ctl_add_slave(vmaster_vol, master_vol);
+		err |= snd_ctl_add_slave(vmaster_vol, speaker_vol);
+		err |= snd_ctl_add(chip->card, vmaster_vol);
+		if (err < 0)
+			return err;
+	}
+
 	if (beige || g4agp)
 		err = build_mixers(chip,
 				ARRAY_SIZE(snd_pmac_screamer_mic_boost_beige),
-- 
1.5.4.3
