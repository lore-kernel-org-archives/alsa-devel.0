From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: core - cleanup platform debugfs on probe
	failure.
Date: Fri,  2 Mar 2012 16:13:44 +0000
Message-ID: <1330704824-29931-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog118.obsmtp.com (na3sys009aog118.obsmtp.com
	[74.125.149.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 399642451D
	for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2012 17:13:54 +0100 (CET)
Received: by mail-we0-f180.google.com with SMTP id f3so1168774wer.25
	for <alsa-devel@alsa-project.org>; Fri, 02 Mar 2012 08:13:52 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Make sure we cleanup the platform debugfs when probe fails.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1bdc67e..29dbbd7 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1112,6 +1112,7 @@ static int soc_probe_platform(struct snd_soc_card *card,
 	return 0;
 
 err_probe:
+	soc_cleanup_platform_debugfs(platform);
 	module_put(platform->dev->driver->owner);
 
 	return ret;
-- 
1.7.5.4
