From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda/realtek - Fix the mute LED regresion
	on Lenovo X1 Carbon
Date: Sun,  9 Dec 2018 09:16:43 +0800
Message-ID: <20181209011643.4733-1-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 011E626751A
 for <alsa-devel@alsa-project.org>; Sun,  9 Dec 2018 02:17:07 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Users reported a mute LED regression on Lenovo X1 Carbon, the root
cause is we applied the fixup of ALC285_FIXUP_LENOVO_HEADPHONE_NOISE
to this machine, then the machine can't apply the fixup of
ALC269_FIXUP_THINKPAD_ACPI anymore. To fix it, we chain two fixup
together.

Fixes: c4cfcf6f4297 ("ALSA: hda/realtek - fix the pop noise on headphone for lenovo laptops")
Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 56882d9b1e43..5b13d9e8d6c7 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6450,6 +6450,8 @@ static const struct hda_fixup alc269_fixups[] = {
 	[ALC285_FIXUP_LENOVO_HEADPHONE_NOISE] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc285_fixup_invalidate_dacs,
+		.chained = true,
+		.chain_id = ALC269_FIXUP_THINKPAD_ACPI
 	},
 	[ALC295_FIXUP_HP_AUTO_MUTE] = {
 		.type = HDA_FIXUP_FUNC,
-- 
2.17.1
