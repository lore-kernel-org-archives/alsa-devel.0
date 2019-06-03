From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: soundwire: add initial soundwire
	support" to the asoc tree
Date: Mon,  3 Jun 2019 19:01:55 +0100 (BST)
Message-ID: <20190603180156.04C5E440049@finisterre.sirena.org.uk>
References: <20190603161821.7486-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 11321F896DE
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2019 20:01:57 +0200 (CEST)
In-Reply-To: <20190603161821.7486-3-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pan Xiuli <xiuli.pan@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: soundwire: add initial soundwire support

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From a893ef9b8bba6a1ba262d9afa04012fcab334c34 Mon Sep 17 00:00:00 2001
From: Pan Xiuli <xiuli.pan@linux.intel.com>
Date: Mon, 3 Jun 2019 11:18:14 -0500
Subject: [PATCH] ASoC: SOF: soundwire: add initial soundwire support

Add soundwire dai type and update ABI version.

Signed-off-by: Pan Xiuli <xiuli.pan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/sof/dai.h      | 1 +
 include/uapi/sound/sof/abi.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/sound/sof/dai.h b/include/sound/sof/dai.h
index 3b67c93ff101..3d174e20aa53 100644
--- a/include/sound/sof/dai.h
+++ b/include/sound/sof/dai.h
@@ -49,6 +49,7 @@ enum sof_ipc_dai_type {
 	SOF_DAI_INTEL_SSP,		/**< Intel SSP */
 	SOF_DAI_INTEL_DMIC,		/**< Intel DMIC */
 	SOF_DAI_INTEL_HDA,		/**< Intel HD/A */
+	SOF_DAI_INTEL_SOUNDWIRE,	/**< Intel SoundWire */
 };
 
 /* general purpose DAI configuration */
diff --git a/include/uapi/sound/sof/abi.h b/include/uapi/sound/sof/abi.h
index 37e0a90dc9e6..13a4eca04577 100644
--- a/include/uapi/sound/sof/abi.h
+++ b/include/uapi/sound/sof/abi.h
@@ -26,7 +26,7 @@
 
 /* SOF ABI version major, minor and patch numbers */
 #define SOF_ABI_MAJOR 3
-#define SOF_ABI_MINOR 4
+#define SOF_ABI_MINOR 5
 #define SOF_ABI_PATCH 0
 
 /* SOF ABI version number. Format within 32bit word is MMmmmppp */
-- 
2.20.1
