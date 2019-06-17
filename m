From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Intel: hda: add new macro
	hstream_to_sof_hda_stream()" to the asoc tree
Date: Mon, 17 Jun 2019 16:24:28 +0100 (BST)
Message-ID: <20190617152428.C0B96440046@finisterre.sirena.org.uk>
References: <20190612172347.22338-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 88913F89730
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2019 17:24:29 +0200 (CEST)
In-Reply-To: <20190612172347.22338-3-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: Intel: hda: add new macro hstream_to_sof_hda_stream()

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

>From f5dbba9fee801f4678a50d92c785f7f24d4ee2c6 Mon Sep 17 00:00:00 2001
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Wed, 12 Jun 2019 12:23:34 -0500
Subject: [PATCH] ASoC: SOF: Intel: hda: add new macro
 hstream_to_sof_hda_stream()

Add a new macro to get sof_intel_hda_stream from hdac_ext_stream.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/hda.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 502b0a3c2e3c..376b1ca51e2b 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -415,6 +415,9 @@ struct sof_intel_hda_stream {
 	int hw_params_upon_resume; /* set up hw_params upon resume */
 };
 
+#define hstream_to_sof_hda_stream(hstream) \
+	container_of(hstream, struct sof_intel_hda_stream, hda_stream)
+
 #define bus_to_sof_hda(bus) \
 	container_of(bus, struct sof_intel_hda_dev, hbus.core)
 
-- 
2.20.1
