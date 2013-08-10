From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Remove unused soc_pm_waitq
Date: Sat, 10 Aug 2013 09:53:14 +0200
Message-ID: <1376121194-21269-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-035.synserver.de (smtp-out-035.synserver.de
 [212.40.185.35])
 by alsa0.perex.cz (Postfix) with ESMTP id 213762610C4
 for <alsa-devel@alsa-project.org>; Sat, 10 Aug 2013 09:52:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The soc_pm_waitq waitqueue has been around as long as the ASoC framework
existed, but has never been used so far, so remove it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1d5e84a..fdddc45 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -47,8 +47,6 @@
 
 #define NAME_SIZE	32
 
-static DECLARE_WAIT_QUEUE_HEAD(soc_pm_waitq);
-
 #ifdef CONFIG_DEBUG_FS
 struct dentry *snd_soc_debugfs_root;
 EXPORT_SYMBOL_GPL(snd_soc_debugfs_root);
-- 
1.8.0
