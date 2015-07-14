From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Fix to add dapm mixer info"
	to the asoc tree
Date: Tue, 14 Jul 2015 11:11:38 +0100
Message-ID: <E1ZExBa-0004U4-Ac@debutante>
References: <1436859647-24213-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E877F261B36
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2015 12:11:51 +0200 (CEST)
In-Reply-To: <1436859647-24213-1-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Fix to add dapm mixer info

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

>From 2c57d478018551f2a0983293413f2f198e49ec23 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Tue, 14 Jul 2015 13:10:47 +0530
Subject: [PATCH] ASoC: topology: Fix to add dapm mixer info

Mixer control for widgets can't be created if the info is NULL. So assign
the correct info for this.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 7a19df313fe8..59ac211f8fe7 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -144,7 +144,7 @@ static const struct snd_soc_tplg_kcontrol_ops io_ops[] = {
 	{SND_SOC_TPLG_CTL_STROBE, snd_soc_get_strobe,
 		snd_soc_put_strobe, NULL},
 	{SND_SOC_TPLG_DAPM_CTL_VOLSW, snd_soc_dapm_get_volsw,
-		snd_soc_dapm_put_volsw, NULL},
+		snd_soc_dapm_put_volsw, snd_soc_info_volsw},
 	{SND_SOC_TPLG_DAPM_CTL_ENUM_DOUBLE, snd_soc_dapm_get_enum_double,
 		snd_soc_dapm_put_enum_double, snd_soc_info_enum_double},
 	{SND_SOC_TPLG_DAPM_CTL_ENUM_VIRT, snd_soc_dapm_get_enum_double,
-- 
2.1.4
