From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/5] ASoC: topology: Use the standard
	fall-through annotations
Date: Thu,  4 Oct 2018 20:30:06 +0200
Message-ID: <20181004183006.23983-6-tiwai@suse.de>
References: <20181004183006.23983-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C04F52678B0
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2018 20:30:10 +0200 (CEST)
In-Reply-To: <20181004183006.23983-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

As a preparatory patch for the upcoming -Wimplicit-fallthrough
compiler checks, replace with the standard "fall through" annotation.
gcc can't understand the mixed texts, unfortunately.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/soc-topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 66e77e020745..c328dfa85209 100644
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
2.18.0
