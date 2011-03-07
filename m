From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH] ASoC: sound:soc:soc-core fix one small
	indentation issue
Date: Mon,  7 Mar 2011 23:14:45 +0800
Message-ID: <1299510885-3133-1-git-send-email-guanqun.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 6445F2447A
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 16:13:53 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/soc/soc-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 64befac..f6ba502 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3438,7 +3438,7 @@ int snd_soc_register_platform(struct device *dev,
 
 	platform = kzalloc(sizeof(struct snd_soc_platform), GFP_KERNEL);
 	if (platform == NULL)
-			return -ENOMEM;
+		return -ENOMEM;
 
 	/* create platform component name */
 	platform->name = fmt_single_name(dev, &platform->id);
-- 
1.7.2.3
