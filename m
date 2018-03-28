From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: rsnd: mark PM functions __maybe_unused
Date: Wed, 28 Mar 2018 16:53:10 +0200
Message-ID: <20180328145318.10136-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by alsa0.perex.cz (Postfix) with ESMTP id A3078266F93
 for <alsa-devel@alsa-project.org>; Wed, 28 Mar 2018 16:54:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

The suspend/resume callbacks are now optional, leading to a warning
when they are unused:

sound/soc/sh/rcar/core.c:1548:12: error: 'rsnd_resume' defined but not used [-Werror=unused-function]
 static int rsnd_resume(struct device *dev)
            ^~~~~~~~~~~
sound/soc/sh/rcar/core.c:1539:12: error: 'rsnd_suspend' defined but not used [-Werror=unused-function]
 static int rsnd_suspend(struct device *dev)

This marks the as __maybe_unused to avoid the warning.

Fixes: f8a9a29c4fe9 ("ASoC: rsnd: set pm_ops in hibernate-compatible way")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/sh/rcar/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 6a76688a8ba9..94f081b93258 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1536,7 +1536,7 @@ static int rsnd_remove(struct platform_device *pdev)
 	return ret;
 }
 
-static int rsnd_suspend(struct device *dev)
+static int __maybe_unused rsnd_suspend(struct device *dev)
 {
 	struct rsnd_priv *priv = dev_get_drvdata(dev);
 
@@ -1545,7 +1545,7 @@ static int rsnd_suspend(struct device *dev)
 	return 0;
 }
 
-static int rsnd_resume(struct device *dev)
+static int __maybe_unused rsnd_resume(struct device *dev)
 {
 	struct rsnd_priv *priv = dev_get_drvdata(dev);
 
-- 
2.9.0
