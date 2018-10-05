From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Use the standard fall-through
	annotations" to the asoc tree
Date: Fri,  5 Oct 2018 14:25:09 +0100 (BST)
Message-ID: <20181005132509.16428112229A@debutante.sirena.org.uk>
References: <20181004183006.23983-6-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C56C26783D
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2018 15:25:11 +0200 (CEST)
In-Reply-To: <20181004183006.23983-6-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Use the standard fall-through annotations

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

>From 9c6c4d961e634413add345ee030e108e6d19cea2 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Thu, 4 Oct 2018 20:30:06 +0200
Subject: [PATCH] ASoC: topology: Use the standard fall-through annotations

As a preparatory patch for the upcoming -Wimplicit-fallthrough
compiler checks, replace with the standard "fall through" annotation.
gcc can't understand the mixed texts, unfortunately.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 17f81b9a5754..045ef136903d 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -993,7 +993,7 @@ static int soc_tplg_denum_create(struct soc_tplg *tplg, unsigned int count,
 				kfree(se);
 				continue;
 			}
-			/* fall through and create texts */
+			/* fall through */
 		case SND_SOC_TPLG_CTL_ENUM:
 		case SND_SOC_TPLG_DAPM_CTL_ENUM_DOUBLE:
 		case SND_SOC_TPLG_DAPM_CTL_ENUM_VIRT:
@@ -1310,7 +1310,7 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_denum_create(
 					ec->hdr.name);
 				goto err_se;
 			}
-			/* fall through to create texts */
+			/* fall through */
 		case SND_SOC_TPLG_CTL_ENUM:
 		case SND_SOC_TPLG_DAPM_CTL_ENUM_DOUBLE:
 		case SND_SOC_TPLG_DAPM_CTL_ENUM_VIRT:
-- 
2.19.0.rc2
