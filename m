From: okias <d.okias@gmail.com>
Subject: targa and targa-2ch fix for 2.6.31
Date: Thu, 9 Jul 2009 18:00:37 +0200
Message-ID: <c2673ca60907090900x3673abb1ocd63b6a606c600aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217])
	by alsa0.perex.cz (Postfix) with ESMTP id C46C62455D
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Jul 2009 18:00:38 +0200 (CEST)
Received: by bwz17 with SMTP id 17so258868bwz.32
	for <alsa-devel@alsa-project.org>; Thu, 09 Jul 2009 09:00:37 -0700 (PDT)
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

Simplify ALC882_TARGA and return gpio3 to ALC883_TARGA_DIG and
ALC883_TARGA_2ch_DIG, which I accidentally removed in commit id
64a8be74357477558183b43156c5536b642de134

Signed-off-by: David Heidelberger <d.okias@gmail.com>

---

--- sound/pci/hda/patch_realtek.c	2009-07-09 17:36:37.593323363 +0200
+++ sound/pci/hda/patch_realtek.c	2009-07-09 17:57:31.014574807 +0200
@@ -6895,9 +6895,6 @@ static struct hda_verb alc882_targa_verb
 	{0x1b, AC_VERB_SET_CONNECT_SEL, 0x00}, /* HP */

 	{0x14, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USRSP_EN},
-	{0x01, AC_VERB_SET_GPIO_MASK, 0x03},
-	{0x01, AC_VERB_SET_GPIO_DIRECTION, 0x03},
-	{0x01, AC_VERB_SET_GPIO_DATA, 0x03},
 	{ } /* end */
 };

@@ -7217,7 +7214,8 @@ static struct alc_config_preset alc882_p
 	},
 	[ALC882_TARGA] = {
 		.mixers = { alc882_targa_mixer, alc882_chmode_mixer },
-		.init_verbs = { alc882_init_verbs, alc882_targa_verbs},
+		.init_verbs = { alc882_init_verbs, alc880_gpio3_init_verbs,
+				alc882_targa_verbs},
 		.num_dacs = ARRAY_SIZE(alc882_dac_nids),
 		.dac_nids = alc882_dac_nids,
 		.dig_out_nid = ALC882_DIGOUT_NID,
@@ -9212,7 +9210,8 @@ static struct alc_config_preset alc883_p
 	},
 	[ALC883_TARGA_DIG] = {
 		.mixers = { alc883_targa_mixer, alc883_chmode_mixer },
-		.init_verbs = { alc883_init_verbs, alc883_targa_verbs},
+		.init_verbs = { alc883_init_verbs, alc880_gpio3_init_verbs,
+				alc883_targa_verbs},
 		.num_dacs = ARRAY_SIZE(alc883_dac_nids),
 		.dac_nids = alc883_dac_nids,
 		.dig_out_nid = ALC883_DIGOUT_NID,
@@ -9225,7 +9224,8 @@ static struct alc_config_preset alc883_p
 	},
 	[ALC883_TARGA_2ch_DIG] = {
 		.mixers = { alc883_targa_2ch_mixer},
-		.init_verbs = { alc883_init_verbs, alc883_targa_verbs},
+		.init_verbs = { alc883_init_verbs, alc880_gpio3_init_verbs,
+				alc883_targa_verbs},
 		.num_dacs = ARRAY_SIZE(alc883_dac_nids),
 		.dac_nids = alc883_dac_nids,
 		.adc_nids = alc883_adc_nids_alt,


-- 
Jabber/XMPP: okias@isgeek.info
SIP VoIP: sip:17474537254@proxy01.sipphone.com
