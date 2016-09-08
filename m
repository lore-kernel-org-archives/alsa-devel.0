From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Skip Realtek SKU check for Lenovo
	machines
Date: Thu,  8 Sep 2016 15:17:44 +0200
Message-ID: <20160908131744.9202-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EB85C26670E
 for <alsa-devel@alsa-project.org>; Thu,  8 Sep 2016 15:17:45 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 47AFCACE9
 for <alsa-devel@alsa-project.org>; Thu,  8 Sep 2016 13:17:45 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

Realtek codec driver expects an implicit rule where either the codec
SSID or the pincfg NID 0x1d contains the some information encoded in
some bits.  One of the expected information is there is the
availability of PC beep, and the driver doesn't build up the PC beep
control if this is *supposed* to be disabled there.

Meanwhile, Lenovo doesn't seem to follow this requirement (yes it's
non-standard after all), and the BIOS sets just the normal SSID and
the pincfg values.  This resulted in the lack of PC beep on a few
machines, purely with a lucky or unlucky number.  It didn't bother
most people, but some people still demand the PC beep, as found in bug
reports.

This patch just adds the fixup chain to Lenovo machines to skip the
SKU checks.  Then the beep control will show up in the mixer, and user
can still decide to enable / disable it via the standard mixer
interface.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=156311
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 574b1b48996f..4be2c77031fa 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5263,6 +5263,8 @@ static const struct hda_fixup alc269_fixups[] = {
 	[ALC269_FIXUP_THINKPAD_ACPI] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = hda_fixup_thinkpad_acpi,
+		.chained = true,
+		.chain_id = ALC269_FIXUP_SKU_IGNORE,
 	},
 	[ALC269_FIXUP_DMIC_THINKPAD_ACPI] = {
 		.type = HDA_FIXUP_FUNC,
-- 
2.10.0
