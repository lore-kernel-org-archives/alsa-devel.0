From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Add ASoC Intel SST Atom sysfs
	description" to the asoc tree
Date: Mon, 05 Dec 2016 17:23:20 +0000
Message-ID: <E1cDwz2-0007ZM-HT@finisterre>
References: <20161205081841.19322-5-sebastien.guiriec@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D3AE4266DA6
 for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2016 18:23:33 +0100 (CET)
In-Reply-To: <20161205081841.19322-5-sebastien.guiriec@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastien Guiriec <sebastien.guiriec@intel.com>
Cc: vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Add ASoC Intel SST Atom sysfs description

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

>From da91723ce0c5e0bbd5dc91d66447ba165241c257 Mon Sep 17 00:00:00 2001
From: Sebastien Guiriec <sebastien.guiriec@intel.com>
Date: Mon, 5 Dec 2016 17:45:03 +0100
Subject: [PATCH] ASoC: Intel: Add ASoC Intel SST Atom sysfs description

For ASoC Intel SST Atom based devices a sysfs entry is created
in order to track FW version. The FW version is useful in order to
check the different Version of LPE DSP FW across Intel SoCs.

Signed-off-by: Sebastien Guiriec <sebastien.guiriec@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/ABI/testing/sysfs-platform-sst-atom | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-sst-atom

diff --git a/Documentation/ABI/testing/sysfs-platform-sst-atom b/Documentation/ABI/testing/sysfs-platform-sst-atom
new file mode 100644
index 000000000000..0d07c0395660
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-sst-atom
@@ -0,0 +1,17 @@
+What:		/sys/devices/platform/8086%x:00/firmware_version
+Date:		November 2016
+KernelVersion:	4.10
+Contact:	"Sebastien Guiriec" <sebastien.guiriec@intel.com>
+Description:
+		LPE Firmware version for SST driver on all atom
+		plaforms (BYT/CHT/Merrifield/BSW).
+		If the FW has never been loaded it will display:
+			"FW not yet loaded"
+		If FW has been loaded it will display:
+			"v01.aa.bb.cc"
+		aa: Major version is reflecting SoC version:
+			0d: BYT FW
+			0b: BSW FW
+			07: Merrifield FW
+		bb: Minor version
+		cc: Build version
-- 
2.10.2
