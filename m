From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: STAC9228 Subsystem update
Date: Tue, 06 Nov 2007 14:17:31 -0500
Message-ID: <4730BDCB.8000903@embeddedalley.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030703020805070103070103"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp110.biz.mail.re2.yahoo.com (smtp110.biz.mail.re2.yahoo.com
	[206.190.53.9]) by alsa0.perex.cz (Postfix) with SMTP id 7A54024819
	for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2007 20:17:26 +0100 (CET)
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

This is a multi-part message in MIME format.
--------------030703020805070103070103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added more laptops subsystem id's that have STAC9228 DMIC support.
---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

--------------030703020805070103070103
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="stac9228_dmic_subsys.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stac9228_dmic_subsys.patch"

diff -r 43708ece3f6f pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Tue Nov 06 11:56:17 2007 +0100
+++ b/pci/hda/patch_sigmatel.c	Tue Nov 06 14:01:53 2007 -0500
@@ -2921,8 +2921,10 @@ static int patch_stac927x(struct hda_cod
 	}
 
 	switch (codec->subsystem_id) {
-	case 0x1028020A: /* STAC 9228 */
-	case 0x10280209: /* STAC 9228 */
+	case 0x10280242: /* STAC 9228 */
+	case 0x102801f3:
+	case 0x1028020A:
+	case 0x10280209:
 		spec->dmic_nids = stac927x_dmic_nids;
 		spec->num_dmics = STAC927X_NUM_DMICS;
 		spec->dmux_nid = 0x1b;

--------------030703020805070103070103
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------030703020805070103070103--
