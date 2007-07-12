From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: stac9202 mixer fix
Date: Thu, 12 Jul 2007 09:11:42 -0400
Message-ID: <4696288E.1030709@embeddedalley.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080801060302030405050404"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp102.biz.mail.re2.yahoo.com (smtp102.biz.mail.re2.yahoo.com
	[68.142.229.216]) by alsa0.perex.cz (Postfix) with SMTP id BD3D624361
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jul 2007 15:11:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de, mporter@embeddedalley.com, stevel@embeddedalley.com
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080801060302030405050404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added support for line out controls for STAC9202 cards, and fixed issue 
where master mixer control was being created twice for headphone and 
speaker outs.
---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

--------------080801060302030405050404
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="stac9202_master_ctl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stac9202_master_ctl.patch"

diff -r 273fac42ced9 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Wed Jul 04 15:17:38 2007 +0200
+++ b/pci/hda/patch_sigmatel.c	Wed Jul 11 22:13:06 2007 -0400
@@ -334,8 +334,6 @@ static struct snd_kcontrol_new stac9200_
 };
 
 static struct snd_kcontrol_new stac925x_mixer[] = {
-	HDA_CODEC_VOLUME("Master Playback Volume", 0xe, 0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Master Playback Switch", 0xe, 0, HDA_OUTPUT),
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Input Source",
@@ -1401,7 +1399,15 @@ static int stac92xx_auto_create_hp_ctls(
 			continue;
 		add_spec_dacs(spec, nid);
 	}
-
+	for (i = 0; i < cfg->line_outs; i++) {
+		nid = snd_hda_codec_read(codec, cfg->line_out_pins[i], 0,
+					AC_VERB_GET_CONNECT_LIST, 0) & 0xff;
+		if (check_in_dac_nids(spec, nid))
+			nid = 0;
+		if (! nid)
+			continue;
+		add_spec_dacs(spec, nid);
+	}
 	for (i = old_num_dacs; i < spec->multiout.num_dacs; i++) {
 		static const char *pfxs[] = {
 			"Speaker", "External Speaker", "Speaker2",

--------------080801060302030405050404
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080801060302030405050404--
