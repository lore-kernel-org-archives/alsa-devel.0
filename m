From: "Shih-Yuan Lee (FourDollars)" <sylee@canonical.com>
Subject: [PATCH v2] ALSA: hda/realtek - Fix pincfg for Dell XPS
	13 9370
Date: Mon, 14 Aug 2017 18:00:47 +0800
Message-ID: <1502704847-22246-1-git-send-email-sylee@canonical.com>
References: <1502703359-20761-1-git-send-email-sylee@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
 by alsa0.perex.cz (Postfix) with ESMTP id BBD1B26731F
 for <alsa-devel@alsa-project.org>; Mon, 14 Aug 2017 12:00:51 +0200 (CEST)
Received: by mail-pg0-f68.google.com with SMTP id u185so9909360pgb.0
 for <alsa-devel@alsa-project.org>; Mon, 14 Aug 2017 03:00:51 -0700 (PDT)
In-Reply-To: <1502703359-20761-1-git-send-email-sylee@canonical.com>
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
Cc: Kailang Yang <kailang@realtek.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The initial pin configs for Dell headset mode of ALC3271 has changed.

/sys/class/sound/hwC0D0/init_pin_configs: (BIOS 0.1.4)
0x12 0xb7a60130
0x13 0xb8a61140
0x14 0x40000000
0x16 0x411111f0
0x17 0x90170110
0x18 0x411111f0
0x19 0x411111f0
0x1a 0x411111f0
0x1b 0x411111f0
0x1d 0x4087992d
0x1e 0x411111f0
0x21 0x04211020

has changed to ...

/sys/class/sound/hwC0D0/init_pin_configs: (BIOS 0.2.0)
0x12 0xb7a60130
0x13 0x40000000
0x14 0x411111f0
0x16 0x411111f0
0x17 0x90170110
0x18 0x411111f0
0x19 0x411111f0
0x1a 0x411111f0
0x1b 0x411111f0
0x1d 0x4067992d
0x1e 0x411111f0
0x21 0x04211020

Fixes: b4576de87243 ("ALSA: hda/realtek - Fix typo of pincfg for Dell
quirk")

Signed-off-by: Shih-Yuan Lee (FourDollars) <sylee@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a91a9ef..217bb58 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6647,7 +6647,6 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 	SND_HDA_PIN_QUIRK(0x10ec0299, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
 		ALC225_STANDARD_PINS,
 		{0x12, 0xb7a60130},
-		{0x13, 0xb8a61140},
 		{0x17, 0x90170110}),
 	{}
 };
-- 
2.7.4
