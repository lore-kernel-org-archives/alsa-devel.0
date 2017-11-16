From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: initialize return value
	properly" to the asoc tree
Date: Thu, 16 Nov 2017 19:28:51 +0000 (GMT)
Message-ID: <20171116192851.EF7D344005B@finisterre.ee.mobilebroadband>
References: <20171106133114.339667-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 618AB267799
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 20:28:56 +0100 (CET)
In-Reply-To: <20171106133114.339667-1-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-kernel@vger.kernel.org, Harsha Priya N <harshapriya.n@intel.com>, Mark Brown <broonie@kernel.org>, Naveen Manohar <naveen.m@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: initialize return value properly

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From cc20c4df1627dd515ea90dd20e2684a8a1c76693 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 6 Nov 2017 14:30:36 +0100
Subject: [PATCH] ASoC: intel: initialize return value properly

When CONFIG_SND_SOC_HDAC_HDMI is disabled, we can run into an
uninitialized variable:

sound/soc/intel/skylake/skl.c: In function 'skl_resume':
sound/soc/intel/skylake/skl.c:326:6: error: 'ret' may be used uninitialized in this function [-Werror=maybe-uninitialized]

I have run into this on today's linux-next kernel, but it appears
that this is an older problem that was just hard to trigger
with randconfig builds as CONFIG_SND_SOC_HDAC_HDMI would in
effect be impossible to disable when having SND_SOC_INTEL_SKYLAKE
enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 31d8634e8aa1..acb0ab470ca6 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -355,6 +355,7 @@ static int skl_resume(struct device *dev)
 
 		if (ebus->cmd_dma_state)
 			snd_hdac_bus_init_cmd_io(&ebus->bus);
+		ret = 0;
 	} else {
 		ret = _skl_resume(ebus);
 
-- 
2.14.1
