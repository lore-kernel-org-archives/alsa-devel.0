From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Correct AD1986A 3stack pin
	configs
Date: Tue,  7 Jan 2014 18:21:32 +0100
Message-ID: <1389115293-20543-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E914261A7C
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 18:21:34 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0221AAC3F
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 17:21:34 +0000 (UTC)
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

The 3stack pin configs for AD1986A codec had incorrect values that
resulted in broken mic and line-in.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=66621
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_analog.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index b174eb1567b8..819d4a98abaf 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -281,11 +281,11 @@ static const struct hda_fixup ad1986a_fixups[] = {
 		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x1a, 0x02214021 }, /* headphone */
 			{ 0x1b, 0x01014011 }, /* front */
-			{ 0x1c, 0x01013012 }, /* surround */
-			{ 0x1d, 0x01019015 }, /* clfe */
+			{ 0x1c, 0x01813030 }, /* line-in */
+			{ 0x1d, 0x01a19020 }, /* rear mic */
 			{ 0x1e, 0x411111f0 }, /* N/A */
 			{ 0x1f, 0x02a190f0 }, /* mic */
-			{ 0x20, 0x018130f0 }, /* line-in */
+			{ 0x20, 0x411111f0 }, /* N/A */
 			{}
 		},
 	},
-- 
1.8.5.2
