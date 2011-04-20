From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 4/4] ASoC: fix two ident style problems
Date: Wed, 20 Apr 2011 16:00:51 +0800
Message-ID: <20110420080051.11377.42364.stgit@localhost>
References: <20110420075859.11377.67437.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 10F611038E1
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Apr 2011 09:59:57 +0200 (CEST)
In-Reply-To: <20110420075859.11377.67437.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Lu Guanqun <guanqun.lu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/soc/soc-core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3b3a377d..a6f37d4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3475,7 +3475,7 @@ int snd_soc_register_dai(struct device *dev,
 
 	dai = kzalloc(sizeof(struct snd_soc_dai), GFP_KERNEL);
 	if (dai == NULL)
-			return -ENOMEM;
+		return -ENOMEM;
 
 	/* create DAI component name */
 	dai->name = fmt_single_name(dev, &dai->id);
@@ -3614,7 +3614,7 @@ int snd_soc_register_platform(struct device *dev,
 
 	platform = kzalloc(sizeof(struct snd_soc_platform), GFP_KERNEL);
 	if (platform == NULL)
-			return -ENOMEM;
+		return -ENOMEM;
 
 	/* create platform component name */
 	platform->name = fmt_single_name(dev, &platform->id);
