From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] ALSA: hda/realtek: Add headset mic support for
	Intel NUC Skull Canyon
Date: Mon, 20 Nov 2017 02:29:13 -0500
Message-ID: <20171120072913.306-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EC0F266F89
 for <alsa-devel@alsa-project.org>; Mon, 20 Nov 2017 08:29:20 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Kai-Heng Feng <kai.heng.feng@canonical.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Users have been using knob "model=dell-headset-multi" on Intel Skull
Canyon for a while.

Add the equivalent quirk, ALC269_FIXUP_DELL1_MIC_NO_PRESENCE for Skull
Canyon.

BugLink: https://bugs.launchpad.net/bugs/1732034
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1797110cb096..5bb5623339dc 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6455,6 +6455,10 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		ALC225_STANDARD_PINS,
 		{0x12, 0xb7a60130},
 		{0x1b, 0x90170110}),
+	SND_HDA_PIN_QUIRK(0x10ec0233, 0x8086, "Intel NUC Skull Canyon", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x1b, 0x01111010},
+		{0x1e, 0x01451130},
+		{0x21, 0x02211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0236, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 		{0x12, 0x90a60140},
 		{0x14, 0x90170110},
-- 
2.14.1
