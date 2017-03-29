From: Mark Brown <broonie@kernel.org>
Subject: Applied "ALSA: hda: Fix LLCH register read" to the
	asoc tree
Date: Wed, 29 Mar 2017 12:02:24 +0100
Message-ID: <E1ctBMu-0007JH-GO@debutante>
References: <1490275926-2270-2-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8459C266EFF
 for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2017 13:02:40 +0200 (CEST)
In-Reply-To: <1490275926-2270-2-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: B@sirena.org.uk
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, "B,
 Jayachandran" <jayachandran.b@intel.com>, patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ALSA: hda: Fix LLCH register read

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From ccfdf9f6a47179941cb8b5f1d3df9734e54b38c4 Mon Sep 17 00:00:00 2001
From: "B, Jayachandran" <jayachandran.b@intel.com>
Date: Fri, 24 Mar 2017 23:10:24 +0530
Subject: [PATCH] ALSA: hda: Fix LLCH register read

LLCH is a 16 bit register. Use readw instead of readl API.

Signed-off-by: B, Jayachandran <jayachandran.b@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/hda/hdac_controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
index 043065867656..6f1e99c9fed9 100644
--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -268,7 +268,7 @@ int snd_hdac_bus_parse_capabilities(struct hdac_bus *bus)
 	unsigned int offset;
 	unsigned int counter = 0;
 
-	offset = snd_hdac_chip_readl(bus, LLCH);
+	offset = snd_hdac_chip_readw(bus, LLCH);
 
 	/* Lets walk the linked capabilities list */
 	do {
-- 
2.11.0
