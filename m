From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: Add dmux to STAC 9228
Date: Thu, 18 Oct 2007 17:36:32 -0400
Message-ID: <4717D1E0.9080903@embeddedalley.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050007090200000406030306"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp110.biz.mail.re2.yahoo.com (smtp110.biz.mail.re2.yahoo.com
	[206.190.53.9]) by alsa0.perex.cz (Postfix) with SMTP id 87330248CB
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Oct 2007 23:36:30 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, "Tellman, Steven" <Steven.Tellman@idt.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050007090200000406030306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added a dmux to the STAC9228 cards with DMIC support. And added a 
STAC_DIGITAL_INPUT_SOURCE macro for repeating mixer code.
---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

--------------050007090200000406030306
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="stac9228_dmux.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stac9228_dmux.patch"

diff -r 821a4558dd47 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Thu Oct 18 17:38:17 2007 +0200
+++ b/pci/hda/patch_sigmatel.c	Thu Oct 18 17:35:56 2007 -0400
@@ -430,6 +430,16 @@ static struct hda_verb stac9205_core_ini
 	{}
 };
 
+#define STAC_DIGITAL_INPUT_SOURCE(cnt) \
+	{ \
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+		.name = "Digital Input Source", \
+		.count = cnt, \
+		.info = stac92xx_dmux_enum_info, \
+		.get = stac92xx_dmux_enum_get, \
+		.put = stac92xx_dmux_enum_put,\
+	}
+
 #define STAC_INPUT_SOURCE(cnt) \
 	{ \
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
@@ -482,14 +492,7 @@ static struct snd_kcontrol_new stac925x_
 };
 
 static struct snd_kcontrol_new stac9205_mixer[] = {
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Digital Input Source",
-		.count = 1,
-		.info = stac92xx_dmux_enum_info,
-		.get = stac92xx_dmux_enum_get,
-		.put = stac92xx_dmux_enum_put,
-	},
+	STAC_DIGITAL_INPUT_SOURCE(1),
 	STAC_INPUT_SOURCE(2),
 	STAC_ANALOG_LOOPBACK(0xFE0, 0x7E0),
 	STAC_VOLKNOB(0x24),
@@ -521,6 +524,7 @@ static struct snd_kcontrol_new stac922x_
 
 
 static struct snd_kcontrol_new stac927x_mixer[] = {
+	STAC_DIGITAL_INPUT_SOURCE(1),
 	STAC_INPUT_SOURCE(3),
 	STAC_VOLKNOB(0x24),
 	STAC_ANALOG_LOOPBACK(0xFEB, 0x7EB),
@@ -2773,6 +2777,7 @@ static int patch_stac927x(struct hda_cod
 	case 0x10280209: /* STAC 9228 */
 		spec->dmic_nids = stac927x_dmic_nids;
 		spec->num_dmics = STAC927X_NUM_DMICS;
+		spec->dmux_nid = 0x1c;
 		break;
 	default:
 		spec->num_dmics = 0;	

--------------050007090200000406030306
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050007090200000406030306--
