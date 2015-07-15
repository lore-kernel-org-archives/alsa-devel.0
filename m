From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Fix Skylake codec timeouts
Date: Wed, 15 Jul 2015 09:39:35 +0200
Message-ID: <1436945975-3279-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D3C2265CF4
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 09:39:49 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: hui.wang@canonical.com, mengdong.lin@intel.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

When the controller is powered up but the HDMI codec is powered down
on Skylake, the power well is turned off. When the codec is then
powered up again, we need to poke the codec a little extra to make
sure it wakes up. Otherwise we'll get sad "no response from codec"
messages and broken audio.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
Tested-by: Woodrow Shen <woodrow.shen@canonical.com>
---

 * It would good to have an ack from Intel on this patch, since they
   have better hardware knowledge than I.

 * Also I haven't really kept track of all recent reorganisation of the
   hda driver so I'm not totally sure how many kernels back (if any)
   that this applies to

 sound/pci/hda/hda_intel.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index ca151b4..872e9a7 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -567,9 +567,17 @@ static int azx_position_check(struct azx *chip, struct azx_dev *azx_dev)
 /* Enable/disable i915 display power for the link */
 static int azx_intel_link_power(struct azx *chip, bool enable)
 {
+	int err;
 	struct hdac_bus *bus = azx_bus(chip);
 
-	return snd_hdac_display_power(bus, enable);
+	err = snd_hdac_display_power(bus, enable);
+	if (err < 0)
+		return err;
+	if (enable && (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)) {
+		snd_hdac_set_codec_wakeup(bus, true);
+		snd_hdac_set_codec_wakeup(bus, false);
+	}
+	return 0;
 }
 
 /*
-- 
1.9.1
