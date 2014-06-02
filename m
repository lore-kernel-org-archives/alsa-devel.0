From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix COEF widget NID for ALC260
	replacer fixup
Date: Mon,  2 Jun 2014 15:32:53 +0200
Message-ID: <1401715973-23354-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AEE71265138
 for <alsa-devel@alsa-project.org>; Mon,  2 Jun 2014 15:32:53 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1BA6FAC8F
 for <alsa-devel@alsa-project.org>; Mon,  2 Jun 2014 13:32:53 +0000 (UTC)
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

The conversion to a fixup table for Replacer model with ALC260 in
commit 20f7d928 took the wrong widget NID for COEF setups.  Namely,
NID 0x1a should have been used instead of NID 0x20, which is the
common node for all Realtek codecs but ALC260.

Fixes: 20f7d928fa6e ('ALSA: hda/realtek - Replace ALC260 model=replacer with the auto-parser')
Cc: <stable@vger.kernel.org> [v3.4+]
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a00cd69bc3aa..3d611c37f25a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1669,8 +1669,8 @@ static const struct hda_fixup alc260_fixups[] = {
 	[ALC260_FIXUP_REPLACER] = {
 		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
-			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x07 },
-			{ 0x20, AC_VERB_SET_PROC_COEF,  0x3050 },
+			{ 0x1a, AC_VERB_SET_COEF_INDEX, 0x07 },
+			{ 0x1a, AC_VERB_SET_PROC_COEF,  0x3050 },
 			{ }
 		},
 		.chained = true,
-- 
1.9.3
