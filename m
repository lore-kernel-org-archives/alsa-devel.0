From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 1/2] ASoC: Fix module refcount for auxiliary
	devices
Date: Thu, 27 Jan 2011 16:24:21 +0200
Message-ID: <1296138262-28113-2-git-send-email-jhnikula@gmail.com>
References: <1296138262-28113-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A7DDF103B25
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 15:23:12 +0100 (CET)
Received: by mail-fx0-f51.google.com with SMTP id 5so2217572fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 06:23:12 -0800 (PST)
In-Reply-To: <1296138262-28113-1-git-send-email-jhnikula@gmail.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Harsha Priya <priya.harsha@intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Commit f6c2ed5 "ASoC: Fix the device references to codec and platform drivers"
moved codec driver refcount increments from soc_bind_dai_link into
soc_probe_codec.

However, the commit didn't remove try_module_get from soc_probe_aux_dev so
the auxiliary device reference counts are incremented twice as the
soc_probe_codec is called from soc_probe_aux_dev too.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Harsha Priya <priya.harsha@intel.com>
---
 sound/soc/soc-core.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 8af47f7..e9f81c5 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1670,9 +1670,6 @@ static int soc_probe_aux_dev(struct snd_soc_card *card, int num)
 	goto out;
 
 found:
-	if (!try_module_get(codec->dev->driver->owner))
-		return -ENODEV;
-
 	ret = soc_probe_codec(card, codec);
 	if (ret < 0)
 		return ret;
-- 
1.7.2.3
