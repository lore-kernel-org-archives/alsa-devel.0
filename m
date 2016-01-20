From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Degrade i915 binding failure
	message
Date: Wed, 20 Jan 2016 15:08:51 +0100
Message-ID: <1453298931-3275-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C1C8A26060C
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2016 15:08:52 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id CCF3CADD6
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2016 14:08:51 +0000 (UTC)
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

Currently HD-audio driver on Intel Skylake or Broxteon gives an error
message when binding with i915 audio component fails.  However, this
isn't any serious error on a system without Intel graphics.  Indeed
there are such systems, where a third-party codec (e.g. Creative) is
put on the mobo while using other discrete GPU (e.g. Nvidia).
Printing a kernel "error" message is overreaction in such a case.

This patch downgrades the print level for that message.  For systems
that mandate the i915 binding (e.g. Haswell or Broadwell HDMI/DP),
another kernel error message is shown in addition to make clear what
went wrong.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=111021
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/hdac_i915.c     | 2 +-
 sound/pci/hda/hda_intel.c | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
index c50177fb469f..f6854dbd7d8d 100644
--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -306,7 +306,7 @@ out_master_del:
 out_err:
 	kfree(acomp);
 	bus->audio_component = NULL;
-	dev_err(dev, "failed to add i915 component master (%d)\n", ret);
+	dev_info(dev, "failed to add i915 component master (%d)\n", ret);
 
 	return ret;
 }
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index c0bef11afa7e..86bbc6307c4f 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2078,9 +2078,11 @@ static int azx_probe_continue(struct azx *chip)
 			 * for other chips, still continue probing as other
 			 * codecs can be on the same link.
 			 */
-			if (CONTROLLER_IN_GPU(pci))
+			if (CONTROLLER_IN_GPU(pci)) {
+				dev_err(chip->card->dev,
+					"HSW/BDW HD-audio HDMI/DP requires binding with gfx driver\n");
 				goto out_free;
-			else
+			} else
 				goto skip_i915;
 		}
 
-- 
2.7.0
