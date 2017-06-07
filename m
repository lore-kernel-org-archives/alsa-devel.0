From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Fix potential build issues
	with undeclared structs" to the asoc tree
Date: Wed, 07 Jun 2017 20:31:43 +0100
Message-ID: <E1dIggB-0003dn-N6@debutante>
References: <1496760904-6427-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A971E2671CA
 for <alsa-devel@alsa-project.org>; Wed,  7 Jun 2017 21:31:50 +0200 (CEST)
In-Reply-To: <1496760904-6427-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Fix potential build issues with undeclared structs

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

>From 294de6e372673229432dc8bcd80964223bc1589d Mon Sep 17 00:00:00 2001
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date: Tue, 6 Jun 2017 15:55:04 +0100
Subject: [PATCH] ASoC: topology: Fix potential build issues with undeclared
 structs

We should be declaring snd_kcontrol_new and soc_dai_link as both are
used within this header so need to be declared.

[Reworded commit message to indicate this wasn't an immediate build
failure -- broonie]

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-topology.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/sound/soc-topology.h b/include/sound/soc-topology.h
index f9cc7b9271ac..b8da221615e0 100644
--- a/include/sound/soc-topology.h
+++ b/include/sound/soc-topology.h
@@ -28,6 +28,8 @@ struct snd_soc_component;
 struct snd_soc_tplg_pcm_fe;
 struct snd_soc_dapm_context;
 struct snd_soc_card;
+struct snd_kcontrol_new;
+struct snd_soc_dai_link;
 
 /* object scan be loaded and unloaded in groups with identfying indexes */
 #define SND_SOC_TPLG_INDEX_ALL	0	/* ID that matches all FW objects */
-- 
2.11.0
