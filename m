From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/2] ASoC: wm8958: check for return value
	before using as array index
Date: Thu, 30 May 2013 21:52:11 +0530
Message-ID: <1369930931-9635-2-git-send-email-vinod.koul@intel.com>
References: <1369930931-9635-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 63D952615DD
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2013 18:59:59 +0200 (CEST)
In-Reply-To: <1369930931-9635-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

return maybe EINVAL and needs to be checked

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/wm8994.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 43f82d2..cc3119d 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -384,6 +384,8 @@ static int wm8994_get_drc_enum(struct snd_kcontrol *kcontrol,
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	int drc = wm8994_get_drc(kcontrol->id.name);
 
+	if (drc < 0)
+		return drc;
 	ucontrol->value.enumerated.item[0] = wm8994->drc_cfg[drc];
 
 	return 0;
@@ -489,6 +491,8 @@ static int wm8994_get_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	int block = wm8994_get_retune_mobile_block(kcontrol->id.name);
 
+	if (block < 0)
+		return block;
 	ucontrol->value.enumerated.item[0] = wm8994->retune_mobile_cfg[block];
 
 	return 0;
-- 
1.7.0.4
