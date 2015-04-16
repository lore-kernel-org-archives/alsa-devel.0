From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 15/16] ALSA: hda/tegra - Fix build error and
	warning
Date: Thu, 16 Apr 2015 18:14:29 +0200
Message-ID: <1429200870-5288-16-git-send-email-tiwai@suse.de>
References: <1429200870-5288-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D989261AE0
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2015 18:14:38 +0200 (CEST)
In-Reply-To: <1429200870-5288-1-git-send-email-tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

I seem to have failed to run the build test properly...
   sound/pci/hda/hda_tegra.c: In function 'hda_tegra_dev_free':
   sound/pci/hda/hda_tegra.c:310:20: error: 'bus' undeclared (first use in this function)
         snd_hdac_bus_exit(bus);

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_tegra.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index d5349809f43d..801e9fb4a467 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -102,8 +102,6 @@ static int substream_alloc_pages(struct azx *chip,
 				 struct snd_pcm_substream *substream,
 				 size_t size)
 {
-	struct azx_dev *azx_dev = get_azx_dev(substream);
-
 	return snd_pcm_lib_malloc_pages(substream, size);
 }
 
@@ -304,7 +302,7 @@ static int hda_tegra_dev_free(struct snd_device *device)
 
 	azx_free_stream_pages(chip);
 	azx_free_streams(chip);
-	snd_hdac_bus_exit(bus);
+	snd_hdac_bus_exit(azx_bus(chip));
 
 	return 0;
 }
-- 
2.3.5
