From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Enable headphone jack detect
	on old Fujitsu laptops
Date: Sat,  5 Sep 2015 18:18:50 +0200
Message-ID: <1441469931-25417-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E67F4260534
 for <alsa-devel@alsa-project.org>; Sat,  5 Sep 2015 18:18:53 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 74571AC04
 for <alsa-devel@alsa-project.org>; Sat,  5 Sep 2015 16:18:53 +0000 (UTC)
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

According to the bug report, FSC Amilo laptops with ALC880 can detect
the headphone jack but currently the driver disables it.  It's partly
intentionally, as non-working jack detect was reported in the past.
Let's enable now.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=102501
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 764dd5bba9ee..9b43cb95c047 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1135,7 +1135,7 @@ static const struct hda_fixup alc880_fixups[] = {
 		/* override all pins as BIOS on old Amilo is broken */
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
-			{ 0x14, 0x0121411f }, /* HP */
+			{ 0x14, 0x0121401f }, /* HP */
 			{ 0x15, 0x99030120 }, /* speaker */
 			{ 0x16, 0x99030130 }, /* bass speaker */
 			{ 0x17, 0x411111f0 }, /* N/A */
@@ -1155,7 +1155,7 @@ static const struct hda_fixup alc880_fixups[] = {
 		/* almost compatible with FUJITSU, but no bass and SPDIF */
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
-			{ 0x14, 0x0121411f }, /* HP */
+			{ 0x14, 0x0121401f }, /* HP */
 			{ 0x15, 0x99030120 }, /* speaker */
 			{ 0x16, 0x411111f0 }, /* N/A */
 			{ 0x17, 0x411111f0 }, /* N/A */
-- 
2.5.1
