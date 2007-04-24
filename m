From: Tobin Davis <gruemaster@email.uophx.edu>
Subject: HDA-Intel: Fix headphone squeal on Conexant audio
Date: Tue, 24 Apr 2007 07:44:38 -0700
Message-ID: <1177425878.4274.90.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=-Z6xnXJ5pg1PbgXtK/2as"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ONLPEXCVWL06.OLS.Phoenix.edu (unknown [204.17.31.62])
	by alsa0.perex.cz (Postfix) with ESMTP id B343324591
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Apr 2007 16:44:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Developers <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--=-Z6xnXJ5pg1PbgXtK/2as
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch fixes the headphone squeal and noise on Conexant CX20551
(Waikiki) audio.


-- 
Tobin Davis <gruemaster@email.uophx.edu>

--=-Z6xnXJ5pg1PbgXtK/2as
Content-Disposition: attachment; filename=conexant-test20.patch
Content-Type: text/x-patch; name=conexant-test20.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 05d4738cc065 pci/hda/patch_conexant.c
--- a/pci/hda/patch_conexant.c	Mon Apr 23 17:17:48 2007 +0200
+++ b/pci/hda/patch_conexant.c	Mon Apr 23 09:00:46 2007 -0700
@@ -993,22 +993,10 @@ static struct snd_kcontrol_new cxt5047_m
 	HDA_CODEC_MUTE("PCM Switch", 0x10, 0x00, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("PCM-2 Volume", 0x1c, 0x00, HDA_OUTPUT),
 	HDA_CODEC_MUTE("PCM-2 Switch", 0x1c, 0x00, HDA_OUTPUT),
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Master Playback Volume",
-		.info = snd_hda_mixer_amp_volume_info,
-		.get = snd_hda_mixer_amp_volume_get,
-		.put = cxt5047_hp_master_vol_put,
-		.private_value = HDA_COMPOSE_AMP_VAL(0x13, 3, 0, HDA_OUTPUT),
-	},
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Master Playback Switch",
-		.info = cxt_eapd_info,
-		.get = cxt_eapd_get,
-		.put = cxt5047_hp_master_sw_put,
-		.private_value = 0x13,
-	},
+	HDA_CODEC_VOLUME("Speaker Volume", 0x1d, 0x00, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Speaker Switch", 0x1d, 0x00, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Headphone Volume", 0x13, 0x00, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Headphone Switch", 0x13, 0x00, HDA_OUTPUT),
 
 	{}
 };
@@ -1079,7 +1067,8 @@ static struct hda_verb cxt5047_init_verb
 	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_50 },
 	{0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_50 },
 	/* HP, Speaker  */
-	{0x13, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
+	{0x13, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP },
+	{0x13, AC_VERB_SET_CONNECT_SEL,0x1},
 	{0x1d, AC_VERB_SET_CONNECT_SEL,0x0},
 	/* Record selector: Mic */
 	{0x12, AC_VERB_SET_CONNECT_SEL,0x03},

--=-Z6xnXJ5pg1PbgXtK/2as
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-Z6xnXJ5pg1PbgXtK/2as--
