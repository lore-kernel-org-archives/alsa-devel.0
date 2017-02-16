From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] ALSA: hda/realtek - Cannot adjust speaker's
	volume on a Dell AIO
Date: Thu, 16 Feb 2017 15:26:54 +0800
Message-ID: <20170216072654.6311-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id E3EDA2666EA
 for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2017 08:27:11 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com
Cc: hui.wang@canonical.com, alsa-devel@alsa-project.org, Kai-Heng Feng <kai.heng.feng@canonical.com>
List-Id: alsa-devel@alsa-project.org

The issue is the same as "dd9aa335c880 ALSA: hda/realtek - Can't adjust
speaker's volume on a Dell AIO", the output requires to connect to a node
with Amp-out capability.

Applying the same fixup "ALC298_FIXUP_SPK_VOLUME" can fix the issue.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 7d660ee1d5e8..2bae6fc26c73 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6065,6 +6065,12 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 	SND_HDA_PIN_QUIRK(0x10ec0298, 0x1028, "Dell", ALC298_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC298_STANDARD_PINS,
 		{0x17, 0x90170150}),
+	SND_HDA_PIN_QUIRK(0x10ec0298, 0x1028, "Dell", ALC298_FIXUP_SPK_VOLUME,
+		{0x12, 0xb7a60140},
+		{0x13, 0xb7a60150},
+		{0x17, 0x90170110},
+		{0x1a, 0x03011020},
+		{0x21, 0x03211030}),
 	{}
 };
 
-- 
2.11.1
