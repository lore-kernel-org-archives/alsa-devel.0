From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Remove NO_PRESENCE bit
	override for Dell 1420n Laptop
Date: Fri, 19 Jul 2013 17:09:02 +0200
Message-ID: <1374246542-14244-2-git-send-email-tiwai@suse.de>
References: <1374246542-14244-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B62D326573E
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 17:07:48 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 8B745A5386
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 17:07:48 +0200 (CEST)
In-Reply-To: <1374246542-14244-1-git-send-email-tiwai@suse.de>
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

The quirk for Dell laptops with STAC9228 overrides the pin default
config of NID 0x0f to the value with AC_DEFCFG_MISC_NO_PRESENCE bit
on.  I'm not quite sure why this was done so, but can guess that this
was introduced for avoiding this to be muted by another headphone
plug.  Now, after transition to the generic parser, this workaround
rather causes a problem (notably as unexpected speaker mutes) because
the pin is seen as if it's always plugged in.

Since the generic parser can handle multiple headphone plugging
gracefully, we can get rid of this override now.

Reported-and-tested-by: Eric Shattow <lucent@gmail.com>
Cc: <stable@vger.kernel.org> [v3.9+]
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_sigmatel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 766e567..92b9b43 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -3233,7 +3233,7 @@ static const struct hda_fixup stac927x_fixups[] = {
 			/* configure the analog microphone on some laptops */
 			{ 0x0c, 0x90a79130 },
 			/* correct the front output jack as a hp out */
-			{ 0x0f, 0x0227011f },
+			{ 0x0f, 0x0221101f },
 			/* correct the front input jack as a mic */
 			{ 0x0e, 0x02a79130 },
 			{}
-- 
1.8.3.1
