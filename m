From: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Subject: [PATCH 2/2] ALSA: hda: add dock and led support for HP
	ProBook 640 G2
Date: Thu, 8 Mar 2018 15:49:24 +0100
Message-ID: <e2198d59-2925-831c-a8a0-4a033bad27dd@secunet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
 by alsa0.perex.cz (Postfix) with ESMTP id 06A382674EC
 for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2018 15:53:10 +0100 (CET)
Content-Language: de-DE
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Hui Wang <hui.wang@canonical.com>, Florin Tudorache <florin_tudorache@live.com>, =?UTF-8?Q?Jer=c3=b3nimo_Borque?= <jeronimo@borque.com.ar>, Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds missing initialisation for HP 2013 UltraSlim Dock
Line-In/Out PINs and activates keyboard mute/micmute leds
for HP ProBook 640 G2

Signed-off-by: Dennis Wassenberg <dennis.wassenberg@secunet.com>
---
 sound/pci/hda/patch_conexant.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index d5c9b88..5b4dbce 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -958,6 +958,7 @@ static void cxt_fixup_mute_led_gpio(struct hda_codec *codec,
 	SND_PCI_QUIRK(0x1025, 0x054f, "Acer Aspire 4830T", CXT_FIXUP_ASPIRE_DMIC),
 	SND_PCI_QUIRK(0x103c, 0x8079, "HP EliteBook 840 G3", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x807C, "HP EliteBook 820 G3", CXT_FIXUP_HP_DOCK),
+	SND_PCI_QUIRK(0x103c, 0x80FD, "HP ProBook 640 G2", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x8174, "HP Spectre x360", CXT_FIXUP_HP_SPECTRE),
 	SND_PCI_QUIRK(0x103c, 0x8115, "HP Z1 Gen3", CXT_FIXUP_HP_GATE_MIC),
 	SND_PCI_QUIRK(0x103c, 0x814f, "HP ZBook 15u G3", CXT_FIXUP_MUTE_LED_GPIO),
-- 
1.9.1
