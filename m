From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Common: Fix NULL dereference in
	tx_wait_done" to the asoc tree
Date: Wed, 26 Jun 2019 12:32:44 +0100 (BST)
Message-ID: <20190626113244.BF8C3440049@finisterre.sirena.org.uk>
References: <20190613190436.20156-6-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3AC87F896B7
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2019 13:32:48 +0200 (CEST)
In-Reply-To: <20190613190436.20156-6-cezary.rojewski@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, tiwai@suse.com, lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Common: Fix NULL dereference in tx_wait_done

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

>From 9f4f42d710d417745cff05845f93370126f77ff7 Mon Sep 17 00:00:00 2001
From: Cezary Rojewski <cezary.rojewski@intel.com>
Date: Thu, 13 Jun 2019 21:04:34 +0200
Subject: [PATCH] ASoC: Intel: Common: Fix NULL dereference in tx_wait_done

rx_data and rx_bytes present for tx_wait_done are optional parameters.
If not provided, function should not attempt to copy received data.
This change fixes memcpy NULL pointer dereference issue occurring when
optional rx_data is NULL while received message size is non-zero.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/sst-ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/sst-ipc.c b/sound/soc/intel/common/sst-ipc.c
index dcff13802c00..fc3340f1da3a 100644
--- a/sound/soc/intel/common/sst-ipc.c
+++ b/sound/soc/intel/common/sst-ipc.c
@@ -71,7 +71,7 @@ static int tx_wait_done(struct sst_generic_ipc *ipc,
 	} else {
 
 		/* copy the data returned from DSP */
-		if (msg->rx_size)
+		if (rx_data)
 			memcpy(rx_data, msg->rx_data, msg->rx_size);
 		ret = msg->errno;
 	}
-- 
2.20.1
