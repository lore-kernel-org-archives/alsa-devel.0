From: robbat2@gentoo.org
Subject: [PATCH] ALSA: HDA: hda_proc: Fix printf format
	specifier
Date: Sat, 13 Sep 2008 16:54:57 -0700
Message-ID: <1221350101-11772-1-git-send-email-robbat2@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.isohunt.com (b01.ext.isohunt.com [208.71.112.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DB463245E3
	for <alsa-devel@alsa-project.org>;
	Sun, 14 Sep 2008 01:55:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, "Robin H. Johnson" <robbat2@gentoo.org>
List-Id: alsa-devel@alsa-project.org

From: Robin H. Johnson <robbat2@gentoo.org>

The Pincap output had a typod format specifier, leading to an extraneous "08"
in the output, which is a reserved bit of the Vref field, and was really
confused :-).

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>

diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
index 4927c4b..743d779 100644
--- a/sound/pci/hda/hda_proc.c
+++ b/sound/pci/hda/hda_proc.c
@@ -216,7 +216,7 @@ static void print_pin_caps(struct snd_info_buffer *buffer,
 	unsigned int caps, val;
 
 	caps = snd_hda_param_read(codec, nid, AC_PAR_PIN_CAP);
-	snd_iprintf(buffer, "  Pincap 0x08%x:", caps);
+	snd_iprintf(buffer, "  Pincap 0x%08x:", caps);
 	if (caps & AC_PINCAP_IN)
 		snd_iprintf(buffer, " IN");
 	if (caps & AC_PINCAP_OUT)
-- 
1.6.0.1
