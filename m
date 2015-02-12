From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 01/13] ASoC: core: allow pcms to be registered
	as nonatomic
Date: Thu, 12 Feb 2015 09:59:53 +0530
Message-ID: <1423715405-4562-2-git-send-email-vinod.koul@intel.com>
References: <1423715405-4562-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 57D3C2650BD
 for <alsa-devel@alsa-project.org>; Thu, 12 Feb 2015 05:32:54 +0100 (CET)
In-Reply-To: <1423715405-4562-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.de>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

ALSA core with commit 257f8cce5d40 - "ALSA: pcm: Allow nonatomic trigger
operations" allows trigger ops to implemented as nonatomic. For ASoC, we can
specify this in dailinks and is updated while snd_pcm is created

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>
---
 include/sound/soc.h |    3 +++
 sound/soc/soc-pcm.c |    1 +
 2 files changed, 4 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index b4fca9aed2a2..3ccab0b7349f 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -950,6 +950,9 @@ struct snd_soc_dai_link {
 	unsigned int symmetric_channels:1;
 	unsigned int symmetric_samplebits:1;
 
+	/* Mark this pcm with non atomic ops */
+	bool nonatomic;
+
 	/* Do not create a PCM for this DAI link (Backend link) */
 	unsigned int no_pcm:1;
 
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index eb87d96e2cf0..cef2ff5188d1 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2526,6 +2526,7 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 	/* DAPM dai link stream work */
 	INIT_DELAYED_WORK(&rtd->delayed_work, close_delayed_work);
 
+	pcm->nonatomic = rtd->dai_link->nonatomic;
 	rtd->pcm = pcm;
 	pcm->private_data = rtd;
 
-- 
1.7.9.5
