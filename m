From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Fix the wrong pincaps set in
	ALC861VD dallas/hp fixup
Date: Mon, 17 Dec 2012 20:13:41 +0100
Message-ID: <1355771621-11086-3-git-send-email-tiwai@suse.de>
References: <1355771621-11086-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DDE0E2602C6
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2012 20:13:47 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id B07FCA3E1C
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2012 20:13:47 +0100 (CET)
In-Reply-To: <1355771621-11086-1-git-send-email-tiwai@suse.de>
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

The workaround to force VREF50 for dallas/hp model with ALC861VD
was introduced in commit 8fdcb6fe4204bdb4c6991652717ab5063751414e,
but it contained wrong pincap override bits.

This patch fixes to exclude VREF80 pincap bit correctly.

Cc: <stable@vger.kernel.org> [v3.2+]
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 16d210a..6ee3459 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6570,8 +6570,8 @@ static void alc861vd_fixup_dallas(struct hda_codec *codec,
 				  const struct alc_fixup *fix, int action)
 {
 	if (action == ALC_FIXUP_ACT_PRE_PROBE) {
-		snd_hda_override_pin_caps(codec, 0x18, 0x00001714);
-		snd_hda_override_pin_caps(codec, 0x19, 0x0000171c);
+		snd_hda_override_pin_caps(codec, 0x18, 0x00000734);
+		snd_hda_override_pin_caps(codec, 0x19, 0x0000073c);
 	}
 }
 
-- 
1.8.0.1
