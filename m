From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add I2C depends for SKL
	machine" to the asoc tree
Date: Wed, 18 Nov 2015 18:09:44 +0000
Message-ID: <E1Zz7Au-0000MO-KW@debutante>
References: <1447854106-6473-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 37F30265A2E
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 19:09:51 +0100 (CET)
In-Reply-To: <1447854106-6473-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kbuild test robot <fengguang.wu@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add I2C depends for SKL machine

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

>From 0928e8a54bf8889176175b2c3e5f2fc8ec1bb7ff Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Wed, 18 Nov 2015 19:11:46 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add I2C depends for SKL machine

The i2c is dependency for the i2c codec drivers, so machine should depend on
i2c. WIthout this we get build failures if I2C is not selected

   sound/soc/codecs/rl6347a.c: In function 'rl6347a_hw_write':
>> sound/soc/codecs/rl6347a.c:66:8: error: implicit declaration of function
>> 'i2c_master_send' [-Werror=implicit-function-declaration]
     ret = i2c_master_send(client, data, 4);
           ^
   sound/soc/codecs/rl6347a.c: In function 'rl6347a_hw_read':
>> sound/soc/codecs/rl6347a.c:114:8: error: implicit declaration of function
>> 'i2c_transfer' [-Werror=implicit-function-declaration]
     ret = i2c_transfer(client->adapter, xfer, 2);

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 13a762172b5d..2903823ebee1 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -145,7 +145,7 @@ config SND_SOC_INTEL_SKYLAKE
 
 config SND_SOC_INTEL_SKL_RT286_MACH
 	tristate "ASoC Audio driver for SKL with RT286 I2S mode"
-	depends on X86 && ACPI
+	depends on X86 && ACPI && I2C
 	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_RT286
-- 
2.6.2
