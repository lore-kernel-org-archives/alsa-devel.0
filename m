From: robbat2@gentoo.org
Subject: [PATCH] ALSA: HDA: patch_analog: Quirk for Asus P5Q
	Premium/Pro boards.
Date: Sat, 13 Sep 2008 16:55:01 -0700
Message-ID: <1221350101-11772-5-git-send-email-robbat2@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.isohunt.com (b01.ext.isohunt.com [208.71.112.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E6DC245E7
	for <alsa-devel@alsa-project.org>;
	Sun, 14 Sep 2008 02:01:45 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, "Robin H. Johnson" <robbat2@orbis-terrarum.net>, "Robin H. Johnson" <robbat2@gentoo.org>
List-Id: alsa-devel@alsa-project.org

From: Robin H. Johnson <robbat2@orbis-terrarum.net>

Use 6STACK_DIG for the AD2000BX variant of the AD1989B chip used by Asus
on their Asus P5Q Premium and Pro boards.

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 42b1a23..2b00c4a 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -2884,6 +2884,7 @@ static struct snd_pci_quirk ad1988_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x81ec, "Asus P5B-DLX", AD1988_6STACK_DIG),
 	SND_PCI_QUIRK(0x1043, 0x81f6, "Asus M2N-SLI", AD1988_6STACK_DIG),
 	SND_PCI_QUIRK(0x1043, 0x8277, "Asus P5K-E/WIFI-AP", AD1988_6STACK_DIG),
+	SND_PCI_QUIRK(0x1043, 0x8311, "Asus P5Q-Premium/Pro", AD1988_6STACK_DIG),
 	{}
 };
 
-- 
1.6.0.1
