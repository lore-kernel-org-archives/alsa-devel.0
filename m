From: Tobin Davis <tdavis@dsl-only.net>
Subject: HDA - Add support for the OQO Model 2
Date: Thu, 31 Jan 2008 15:33:14 -0800
Message-ID: <1201822394.23369.108.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-5iL5vrkytTlpSS475vCx"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 31A001038F5
	for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2008 00:33:17 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Developers <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--=-5iL5vrkytTlpSS475vCx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds support for the OQO Model 2 Ultra Mobile PC.


Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-5iL5vrkytTlpSS475vCx
Content-Disposition: attachment; filename=OQO-Model2.patch
Content-Type: text/x-patch; name=OQO-Model2.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 823ccbb17a3d pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Wed Jan 30 14:58:38 2008 +0100
+++ b/pci/hda/patch_sigmatel.c	Thu Jan 31 15:26:55 2008 -0800
@@ -39,6 +39,7 @@
 
 enum {
 	STAC_REF,
+	STAC_9200_OQO,
 	STAC_9200_DELL_D21,
 	STAC_9200_DELL_D22,
 	STAC_9200_DELL_D23,
@@ -1052,9 +1054,15 @@ static unsigned int dell9200_m27_pin_con
 	0x90170310, 0x04a11020, 0x90170310, 0x40f003fc,
 };
 
+static unsigned int oqo9200_pin_configs[8] = {
+	0x40c000f0, 0x404000f1, 0x0221121f, 0x02211210,
+	0x90170111, 0x90a70120, 0x400000f2, 0x400000f3,
+};
+
 
 static unsigned int *stac9200_brd_tbl[STAC_9200_MODELS] = {
 	[STAC_REF] = ref9200_pin_configs,
+	[STAC_9200_OQO] = oqo9200_pin_configs,
 	[STAC_9200_DELL_D21] = dell9200_d21_pin_configs,
 	[STAC_9200_DELL_D22] = dell9200_d22_pin_configs,
 	[STAC_9200_DELL_D23] = dell9200_d23_pin_configs,
@@ -1069,6 +1077,7 @@ static unsigned int *stac9200_brd_tbl[ST
 
 static const char *stac9200_models[STAC_9200_MODELS] = {
 	[STAC_REF] = "ref",
+	[STAC_9200_OQO] = "oqo",
 	[STAC_9200_DELL_D21] = "dell-d21",
 	[STAC_9200_DELL_D22] = "dell-d22",
 	[STAC_9200_DELL_D23] = "dell-d23",
@@ -1153,6 +1162,8 @@ static struct snd_pci_quirk stac9200_cfg
 		      STAC_9200_GATEWAY),
 	SND_PCI_QUIRK(0x107b, 0x0318, "Gateway ML3019, MT3707",
 		      STAC_9200_GATEWAY),
+	/* OQO Mobile */
+	SND_PCI_QUIRK(0x1106, 0x3288, "OQO Model 2", STAC_9200_OQO),
 	{} /* terminator */
 };
 
@@ -3147,7 +3166,8 @@ static int patch_stac9200(struct hda_cod
 	spec->num_adcs = 1;
 	spec->num_pwrs = 0;
 
-	if (spec->board_config == STAC_9200_GATEWAY)
+	if ((spec->board_config == STAC_9200_GATEWAY)||
+		(spec->board_config == STAC_9200_OQO))
 		spec->init = stac9200_eapd_init;
 	else
 		spec->init = stac9200_core_init;

--=-5iL5vrkytTlpSS475vCx
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-5iL5vrkytTlpSS475vCx--
