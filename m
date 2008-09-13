From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: fixed hp_nid DAC for DELL_M6
Date: Sat, 13 Sep 2008 10:36:58 -0400
Message-ID: <48CBD00A.9020805@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id E7A19244A3
	for <alsa-devel@alsa-project.org>;
	Sat, 13 Sep 2008 16:37:08 +0200 (CEST)
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

This patch sets the HP out not used by the "Headphone to Line Out" switch to the
hp_nid.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index f41ba17..0218aa7 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -747,8 +747,8 @@ static struct hda_verb dell_m6_core_init[] = {
 	{ 0x1f, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xec},
 	/* setup audio connections */
 	{ 0x0d, AC_VERB_SET_CONNECT_SEL, 0x00},
-	{ 0x0a, AC_VERB_SET_CONNECT_SEL, 0x01},
-	{ 0x0f, AC_VERB_SET_CONNECT_SEL, 0x02},
+	{ 0x0a, AC_VERB_SET_CONNECT_SEL, 0x02},
+	{ 0x0f, AC_VERB_SET_CONNECT_SEL, 0x01},
 	/* setup adcs to point to mixer */
 	{ 0x20, AC_VERB_SET_CONNECT_SEL, 0x0b},
 	{ 0x21, AC_VERB_SET_CONNECT_SEL, 0x0b},
