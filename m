From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] Show processing coefficients in codec proc file
Date: Thu, 19 Aug 2010 20:17:42 +0200
Message-ID: <4C6D7546.4000506@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010409060503090209020409"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B35D2452A
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Aug 2010 20:17:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010409060503090209020409
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This patch is helpful for tracking down bugs without having all
information about the chip.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------010409060503090209020409
Content-Type: text/x-patch;
 name="0001-Show-processing-coefficients-in-codec-proc-file.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Show-processing-coefficients-in-codec-proc-file.patch"

>From 568a3c0e45396cf6cfd8e8dac13f76f756c7e3f3 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Thu, 19 Aug 2010 18:40:44 +0200
Subject: [PATCH 1/2] Show processing coefficients in codec proc file

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_proc.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
index f025200..88e40f0 100644
--- a/sound/pci/hda/hda_proc.c
+++ b/sound/pci/hda/hda_proc.c
@@ -467,11 +467,23 @@ static void print_unsol_cap(struct snd_info_buffer *buffer,
 static void print_proc_caps(struct snd_info_buffer *buffer,
 			    struct hda_codec *codec, hda_nid_t nid)
 {
+        int i, val;
 	unsigned int proc_caps = snd_hda_param_read(codec, nid,
 						    AC_PAR_PROC_CAP);
+	unsigned int ncoeff = (proc_caps & AC_PCAP_NUM_COEF) >> 
+                              AC_PCAP_NUM_COEF_SHIFT;
+
 	snd_iprintf(buffer, "  Processing caps: benign=%d, ncoeff=%d\n",
-		    proc_caps & AC_PCAP_BENIGN,
-		    (proc_caps & AC_PCAP_NUM_COEF) >> AC_PCAP_NUM_COEF_SHIFT);
+		    proc_caps & AC_PCAP_BENIGN, ncoeff);
+	for (i = 0; i < ncoeff; i++) {
+		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_COEF_INDEX,
+				    i);
+		val = snd_hda_codec_read(codec, nid, 0,
+					 AC_VERB_GET_PROC_COEF, 0);
+                snd_iprintf(buffer, "  Processing coef %d: 0x%x\n", i, 
+                            val);
+        }
+        
 }
 
 static void print_conn_list(struct snd_info_buffer *buffer,
-- 
1.7.0.4


--------------010409060503090209020409
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------010409060503090209020409--
