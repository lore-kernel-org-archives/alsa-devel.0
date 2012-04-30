From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: core: Fix dai_link dereference.
Date: Mon, 30 Apr 2012 11:05:30 +0100
Message-ID: <1335780330-1157-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog110.obsmtp.com (na3sys009aog110.obsmtp.com
	[74.125.149.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 43DB2243BF
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Apr 2012 12:05:41 +0200 (CEST)
Received: by werg1 with SMTP id g1so1717060wer.38
	for <alsa-devel@alsa-project.org>; Mon, 30 Apr 2012 03:05:39 -0700 (PDT)
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

We should check dailess before dereferencing.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 9bdfef4..7f1e012 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1218,7 +1218,7 @@ static int soc_post_component_init(struct snd_soc_card *card,
 
 #ifdef CONFIG_DEBUG_FS
 	/* add DPCM sysfs entries */
-	if (!dai_link->dynamic)
+	if (!dailess && !dai_link->dynamic)
 		goto out;
 
 	ret = soc_dpcm_debugfs_add(rtd);
-- 
1.7.9.5
