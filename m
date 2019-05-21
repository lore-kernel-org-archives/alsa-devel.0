From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: sof-rt5682: add newline for
	clarity" to the asoc tree
Date: Tue, 21 May 2019 21:32:40 +0100 (BST)
Message-ID: <20190521203240.839A41126D13@debutante.sirena.org.uk>
References: <20190520194645.432-4-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 97378F89674
 for <alsa-devel@alsa-project.org>; Tue, 21 May 2019 22:32:49 +0200 (CEST)
In-Reply-To: <20190520194645.432-4-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Sathya Prakash M R <sathya.prakash.m.r@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: sof-rt5682: add newline for clarity

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

>From b385256eb54f0193f0f595a675409ba6e7282ffe Mon Sep 17 00:00:00 2001
From: Sathya Prakash M R <sathya.prakash.m.r@intel.com>
Date: Mon, 20 May 2019 14:46:43 -0500
Subject: [PATCH] ASoC: Intel: sof-rt5682: add newline for clarity

Make sure quirk handling is cleary split from number of links.

Signed-off-by: Sathya Prakash M R <sathya.prakash.m.r@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/sof_rt5682.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index f28fb98cc306..fea42e275326 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -519,6 +519,7 @@ static int sof_audio_probe(struct platform_device *pdev)
 
 	/* compute number of dai links */
 	sof_audio_card_rt5682.num_links = 1 + dmic_num + hdmi_num;
+
 	if (sof_rt5682_quirk & SOF_SPEAKER_AMP_PRESENT)
 		sof_audio_card_rt5682.num_links++;
 
-- 
2.20.1
