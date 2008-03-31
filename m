From: Jiang zhe <zhe.jiang@intel.com>
Subject: [PATCH]Should use HDA_OUTPUT instead of HDA_INPUT to
	mute pin 15	of ALC880
Date: Mon, 31 Mar 2008 15:14:49 +0800
Message-ID: <1206947689.13847.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-tEWWnsgILQHda5BBdOYN"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id E176224470
	for <alsa-devel@alsa-project.org>;
	Mon, 31 Mar 2008 09:13:19 +0200 (CEST)
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
Cc: tiwai@suse.de, zhe.jiang@intel.com
List-Id: alsa-devel@alsa-project.org


--=-tEWWnsgILQHda5BBdOYN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

To mute the output of Pin widget 15 in ALC880, we should use the
HDA_OUTPUT. However, current code looks like :
snd_hda_codec_amp_stereo(codec, 0x15, HDA_INPUT, 0, HDA_AMP_MUTE, bits);
It may be a misspelling.

Best regards!

Signed-off-by: Jiang zhe <zhe.jiang@intel.com>

--=-tEWWnsgILQHda5BBdOYN
Content-Disposition: attachment; filename=alc880_pin_15_should_be_HDA_OUTPUT.patch
Content-Type: text/x-patch; name=alc880_pin_15_should_be_HDA_OUTPUT.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- alsa-driver-hg20080323/alsa-kernel/pci/hda/patch_realtek.c	2008-03-23 09:00:08.000000000 +0800
+++ b/alsa-kernel/pci/hda/patch_realtek.c	2008-03-31 14:59:10.000000000 +0800
@@ -1894,7 +1894,7 @@ static void alc880_uniwill_p53_hp_automu
  	present = snd_hda_codec_read(codec, 0x14, 0,
 				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
 	bits = present ? HDA_AMP_MUTE : 0;
-	snd_hda_codec_amp_stereo(codec, 0x15, HDA_INPUT, 0, HDA_AMP_MUTE, bits);
+	snd_hda_codec_amp_stereo(codec, 0x15, HDA_OUTPUT, 0, HDA_AMP_MUTE, bits);
 }
 
 static void alc880_uniwill_p53_dcvol_automute(struct hda_codec *codec)

--=-tEWWnsgILQHda5BBdOYN
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-tEWWnsgILQHda5BBdOYN--
