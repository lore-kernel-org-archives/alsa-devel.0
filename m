From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: fix PM=n build
Date: Tue, 17 Jun 2008 19:19:34 +0100
Message-ID: <12137267743172-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8393424634
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Jun 2008 20:19:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix sound/soc build failure when CONFIG_PM=n:

linux-next-20080617/sound/soc/soc-core.c:829: error: 'soc_resume_deferred' undeclared (first use in this function)
soc3.out:make[3]: *** [sound/soc/soc-core.o] Error 1

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b931039..bdbbc6a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -825,8 +825,10 @@ static int soc_probe(struct platform_device *pdev)
 
 	/* DAPM stream work */
 	INIT_DELAYED_WORK(&socdev->delayed_work, close_delayed_work);
+#ifdef CONFIG_PM
 	/* deferred resume work */
 	INIT_WORK(&socdev->deferred_resume_work, soc_resume_deferred);
+#endif
 
 	return 0;
 
-- 
1.5.2.5
