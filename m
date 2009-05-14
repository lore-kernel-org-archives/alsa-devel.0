From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH V1 07/13] Add SNDRV_PCM_FMTBIT_S32_BE as a
	valid AC97 format
Date: Wed, 13 May 2009 21:59:14 -0400
Message-ID: <20090514015914.28145.53583.stgit@terra>
References: <20090514015729.28145.30483.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 29FED24399
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 03:59:24 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so720053ywq.2
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 18:59:23 -0700 (PDT)
In-Reply-To: <20090514015729.28145.30483.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: grant.likely@secretlab.ca, broonie@sirena.org.uk
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add SNDRV_PCM_FMTBIT_S32_BE as a valid AC97 format

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---
 include/sound/soc-dai.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 496dc30..352d7ee 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -79,7 +79,8 @@ struct snd_pcm_substream;
 #define SND_SOC_CLOCK_OUT		1
 
 #define SND_SOC_STD_AC97_FMTS (SNDRV_PCM_FMTBIT_S16_LE |\
-                               SNDRV_PCM_FMTBIT_S32_LE)
+                               SNDRV_PCM_FMTBIT_S32_LE |\
+                               SNDRV_PCM_FMTBIT_S32_BE)
 
 struct snd_soc_dai_ops;
 struct snd_soc_dai;
