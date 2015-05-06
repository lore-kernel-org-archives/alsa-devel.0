From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Add headset mic quirk for Dell
	Inspiron 5548
Date: Wed,  6 May 2015 10:53:02 +0200
Message-ID: <1430902382-4955-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 964FD2606BA
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 10:53:03 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.se, 1452175@bugs.launchpad.net, alsa-devel@alsa-project.org
Cc: stable@kernel.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

This enables the headset microphone on Dell Inspiron 5548,
or at least some variants of it.

Cc: stable@kernel.org
BugLink: https://bugs.launchpad.net/bugs/1452175
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 06199e4..c5413e9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5337,6 +5337,13 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x17, 0x40000000},
 		{0x1d, 0x40700001},
 		{0x21, 0x02211050}),
+	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell Inspiron 5548", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+		ALC255_STANDARD_PINS,
+		{0x12, 0x90a60180},
+		{0x14, 0x90170130},
+		{0x17, 0x40000000},
+		{0x1d, 0x40700001},
+		{0x21, 0x02211040}),
 	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC256_STANDARD_PINS,
 		{0x13, 0x40000000}),
-- 
1.9.1
