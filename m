From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: STAC9228 updated DMUX nid.
Date: Fri, 19 Oct 2007 15:03:15 -0400
Message-ID: <4718FF73.4020405@embeddedalley.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040603020806000504090101"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp109.biz.mail.re2.yahoo.com (smtp109.biz.mail.re2.yahoo.com
	[206.190.53.8]) by alsa0.perex.cz (Postfix) with SMTP id 2931624682
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Oct 2007 21:03:18 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040603020806000504090101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Changed the dmux for STAC9228 from ADC1MUX to ADC0MUX to avoid confusion.
---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

--------------040603020806000504090101
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="stac9228_dmux_correction.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stac9228_dmux_correction.patch"

diff -r 7cf5e23f804e pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Fri Oct 19 08:23:00 2007 +0200
+++ b/pci/hda/patch_sigmatel.c	Fri Oct 19 13:47:35 2007 -0400
@@ -2777,7 +2777,7 @@ static int patch_stac927x(struct hda_cod
 	case 0x10280209: /* STAC 9228 */
 		spec->dmic_nids = stac927x_dmic_nids;
 		spec->num_dmics = STAC927X_NUM_DMICS;
-		spec->dmux_nid = 0x1c;
+		spec->dmux_nid = 0x1b;
 		break;
 	default:
 		spec->num_dmics = 0;	

--------------040603020806000504090101
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------040603020806000504090101--
