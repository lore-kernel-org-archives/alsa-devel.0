From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH RFC/untested] hda-intel: suspend HDA codecs and
 the PCI device in error cases
Date: Fri, 8 Feb 2019 11:50:25 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1902081000370.25485@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by alsa0.perex.cz (Postfix) with ESMTP id 19AB1267437
 for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2019 11:50:50 +0100 (CET)
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
Cc: Hans de Goede <hdegoede@redhat.com>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>

If HDA probing on Intel platforms fails, all the devices, that have
previously been powered up, have to be suspended again.

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---

I came across HDA not suspending when no codec driver has successfully 
probed while working on SOF. Then I decided to look how this is handled in 
the mainline Intel HDA code and I think something like this patch is 
needed, however, I don't have a set up to test it. I haven't looked at the 
tegra HDA implementation, possibly they need something similar. Please, 
comment.

 sound/pci/hda/hda_intel.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index e784130..d3caa37 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2229,14 +2229,14 @@ static int azx_probe_continue(struct azx *chip)
 	/* create codec instances */
 	err = azx_probe_codecs(chip, azx_max_codecs[chip->driver_type]);
 	if (err < 0)
-		goto out_free;
+		goto out_power_down;
 
 #ifdef CONFIG_SND_HDA_PATCH_LOADER
 	if (chip->fw) {
 		err = snd_hda_load_patch(&chip->bus, chip->fw->size,
 					 chip->fw->data);
 		if (err < 0)
-			goto out_free;
+			goto out_power_down;
 #ifndef CONFIG_PM
 		release_firmware(chip->fw); /* no longer needed */
 		chip->fw = NULL;
@@ -2246,12 +2246,12 @@ static int azx_probe_continue(struct azx *chip)
 	if ((probe_only[dev] & 1) == 0) {
 		err = azx_codec_configure(chip);
 		if (err < 0)
-			goto out_free;
+			goto out_power_down;
 	}
 
 	err = snd_card_register(chip->card);
 	if (err < 0)
-		goto out_free;
+		goto out_power_down;
 
 	setup_vga_switcheroo_runtime_pm(chip);
 
@@ -2260,6 +2260,7 @@ static int azx_probe_continue(struct azx *chip)
 
 	set_default_power_save(chip);
 
+out_power_down:
 	if (azx_has_pm_runtime(chip))
 		pm_runtime_put_autosuspend(&pci->dev);
 
-- 
1.9.3
