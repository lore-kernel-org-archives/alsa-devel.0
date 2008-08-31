From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: Distortion  fix for dell_m6_core_init
Date: Sun, 31 Aug 2008 14:53:38 -0400
Message-ID: <48BAE8B2.4020204@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 3D11D24591
	for <alsa-devel@alsa-project.org>;
	Sun, 31 Aug 2008 20:53:52 +0200 (CEST)
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

Added the EQ distortion fix to the dell_m6_core_init.

---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index 6ad6ef3..9968ee4 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -606,8 +606,9 @@ static struct hda_verb dell_eq_core_init[] = {
 };

 static struct hda_verb dell_m6_core_init[] = {
-	/* set master volume and direct control */
-	{ 0x1f, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
+	/* set master volume to max value without distortion
+	 * and direct control */
+	{ 0x1f, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xec},
 	/* setup audio connections */
 	{ 0x0d, AC_VERB_SET_CONNECT_SEL, 0x00},
 	{ 0x0a, AC_VERB_SET_CONNECT_SEL, 0x01},
