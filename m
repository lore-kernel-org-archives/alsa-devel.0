From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: [PATCH] hda-codec - Fix definition of AC_KNBCAP_DELTA
	to match datasheet.
Date: Tue, 4 Dec 2007 02:12:48 -0500
Message-ID: <76366b180712032312p73a98249hf9269e5044a818c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.186])
	by alsa0.perex.cz (Postfix) with ESMTP id F2D8D244BC
	for <alsa-devel@alsa-project.org>; Tue,  4 Dec 2007 08:12:49 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so2638893rvb
	for <alsa-devel@alsa-project.org>; Mon, 03 Dec 2007 23:12:48 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

hda-codec - Fix definition of AC_KNBCAP_DELTA to match datasheet.

AC_KNBCAP_DELTA is incorrectly defined as (1<<8). According to the ALC883
datasheet rev 1.3, this is bit 7 after AC_KNBCAP_NUM_STEPS which is a 0x7f
mask.

Signed-off-by: Andrew Paprocki <andrew@ishiboo.com>


diff -r da002fb740a42b4fd6dcbd45693f9bee3c828812 -r
65b577e690e95e4ace950c3f986270dd3e992192 pci/hda/hda_codec.h
--- a/pci/hda/hda_codec.h       Mon Dec 03 22:52:58 2007 -0500
+++ b/pci/hda/hda_codec.h       Mon Dec 03 23:02:51 2007 -0500
@@ -238,7 +238,7 @@ enum {

 /* Volume knobs capabilities */
 #define AC_KNBCAP_NUM_STEPS            (0x7f<<0)
-#define AC_KNBCAP_DELTA                        (1<<8)
+#define AC_KNBCAP_DELTA                        (1<<7)

 /*
  * Control Parameters
