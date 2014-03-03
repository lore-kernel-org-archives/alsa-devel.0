From: Marius Knaust <marius.knaust@gmail.com>
Subject: [PATCH] ALSA: hda - Added inverted digital-mic
 handling for Acer TravelMate 8371
Date: Mon, 03 Mar 2014 01:48:58 +0100
Message-ID: <5313D17A.1070607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f49.google.com (mail-ee0-f49.google.com [74.125.83.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AE522654CF
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 01:49:00 +0100 (CET)
Received: by mail-ee0-f49.google.com with SMTP id b57so3611815eek.8
 for <alsa-devel@alsa-project.org>; Sun, 02 Mar 2014 16:49:00 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Marius Knaust <marius.knaust@gmail.com>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 534796e..9fc7bb6 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4255,6 +4255,7 @@ static const struct hda_fixup alc269_fixups[] = {
 };

 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
+	SND_PCI_QUIRK(0x1025, 0x0283, "Acer TravelMate 8371",
ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1025, 0x029b, "Acer 1810TZ", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1025, 0x0349, "Acer AOD260", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1025, 0x047c, "Acer AC700", ALC269_FIXUP_ACER_AC700),
