From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/2] ASoC: Remove unused fields in struct mfld_mc_private
Date: Tue, 27 Sep 2011 10:38:07 +0800
Message-ID: <1317091087.315.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, Harsha Priya <priya.harsha@intel.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Both *socdev and *codec of struct mfld_mc_private are not being used
in this driver, remove it.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/mid-x86/mfld_machine.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mid-x86/mfld_machine.c b/sound/soc/mid-x86/mfld_machine.c
index 429aa1b..1d818dc 100644
--- a/sound/soc/mid-x86/mfld_machine.c
+++ b/sound/soc/mid-x86/mfld_machine.c
@@ -54,9 +54,7 @@ static unsigned int	hs_switch;
 static unsigned int	lo_dac;
 
 struct mfld_mc_private {
-	struct platform_device *socdev;
 	void __iomem *int_base;
-	struct snd_soc_codec *codec;
 	u8 interrupt_status;
 };
 
-- 
1.7.4.1
