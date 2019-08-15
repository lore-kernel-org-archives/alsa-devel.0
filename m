From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 4/4] ASoC: SOF: pcm: add ALH support
Date: Thu, 15 Aug 2019 14:20:18 -0500
Message-ID: <20190815192018.30570-5-pierre-louis.bossart@linux.intel.com>
References: <20190815192018.30570-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 14A56F8015B
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2019 21:22:51 +0200 (CEST)
In-Reply-To: <20190815192018.30570-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Even if ALH has no specific configuration, we still need to handle the
common parameters for all DAIs

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/pcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index 8612896673a5..e3f6a6dc0f36 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -675,6 +675,9 @@ static int sof_pcm_dai_link_fixup(struct snd_soc_pcm_runtime *rtd,
 	case SOF_DAI_INTEL_HDA:
 		/* do nothing for HDA dai_link */
 		break;
+	case SOF_DAI_INTEL_ALH:
+		/* do nothing for ALH dai_link */
+		break;
 	default:
 		dev_err(sdev->dev, "error: invalid DAI type %d\n",
 			dai->dai_config->type);
-- 
2.20.1
