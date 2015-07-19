From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Add headset mic support for Acer
	Aspire V5-573G
Date: Sun, 19 Jul 2015 17:39:46 +0200
Message-ID: <1437320386-4986-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A757260595
 for <alsa-devel@alsa-project.org>; Sun, 19 Jul 2015 17:39:50 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D47DEAAD6
 for <alsa-devel@alsa-project.org>; Sun, 19 Jul 2015 15:39:47 +0000 (UTC)
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

From: Mateusz Sylwestrzak <matisec7@gmail.com>

Acer Aspire V5 with the ALC282 codec is given the wrong value for the
0x19 PIN by the laptop's BIOS. Overriding it with the correct value
adds support for the headset microphone which would not otherwise be
visible in the system.

The fix is based on commit 7819717b1134 with a similar quirk for Acer
Aspire with the ALC269 codec.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=96201
Cc: <stable@vger.kernel.org>
Signed-off-by: Mateusz Sylwestrzak <matisec7@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d35cf506a7db..caba66b2311c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5061,7 +5061,7 @@ static const struct hda_fixup alc269_fixups[] = {
 			{ 0x14, 0x90170110 },
 			{ 0x17, 0x40000008 },
 			{ 0x18, 0x411111f0 },
-			{ 0x19, 0x411111f0 },
+			{ 0x19, 0x01a1913c },
 			{ 0x1a, 0x411111f0 },
 			{ 0x1b, 0x411111f0 },
 			{ 0x1d, 0x40f89b2d },
-- 
2.4.5
