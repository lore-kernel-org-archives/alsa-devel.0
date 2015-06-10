From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Continue probing even if i915
	binding fails
Date: Wed, 10 Jun 2015 12:26:04 +0200
Message-ID: <1433931965-12337-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 450BC265947
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2015 12:26:07 +0200 (CEST)
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
Cc: Libin Yang <libin.yang@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Currently snd-hda-intel driver aborts the probing of Intel HD-audio
controller with i915 power well management when binding with i915
driver via hda_i915_init() fails.  This is no big problem for Haswell
and Broadwell where the HD-audio controllers are dedicated to
HDMI/DP, thus i915 link is mandatory.  However, Skylake, Baytrail and
Braswell have only one controller and both HDMI/DP and analog codecs
share the same bus.  Thus, even if HDMI/DP isn't usable, we should
keep the controller working for other codecs.

For fixing this, this patch simply allows continuing the probing even
if hda_i915_init() call fails.  This may leave stale sound components
for HDMI/DP devices that are unbound with graphics.  We could abort
the probing selectively, but from the code simplicity POV, it's better
to continue in all cases.

Reported-by: Libin Yang <libin.yang@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
This is for 4.1.  Appying to 4.2 may result in trivial conflicts.

 sound/pci/hda/hda_intel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index fea198c58196..8a0af6770e1d 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1855,7 +1855,7 @@ static int azx_probe_continue(struct azx *chip)
 #ifdef CONFIG_SND_HDA_I915
 		err = hda_i915_init(hda);
 		if (err < 0)
-			goto out_free;
+			goto skip_i915;
 		err = hda_display_power(hda, true);
 		if (err < 0) {
 			dev_err(chip->card->dev,
@@ -1865,6 +1865,7 @@ static int azx_probe_continue(struct azx *chip)
 #endif
 	}
 
+ skip_i915:
 	err = azx_first_init(chip);
 	if (err < 0)
 		goto out_free;
-- 
2.4.3
