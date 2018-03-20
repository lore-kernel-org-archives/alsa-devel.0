From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] ASoC: rsnd: set pm_ops in hibernate-compatible
	way
Date: Tue, 20 Mar 2018 11:41:15 +0300
Message-ID: <20180320084115.23880-1-nikita.yoush@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f65.google.com (mail-lf0-f65.google.com
 [209.85.215.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E33526718B
 for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2018 09:41:25 +0100 (CET)
Received: by mail-lf0-f65.google.com with SMTP id z143-v6so1237880lff.3
 for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2018 01:41:25 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Bhumika Goyal <bhumirks@gmail.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Use SET_SYSTEM_SLEEP_PM_OPS() macro instead of direct assignment to
.suspend and .resume fields.

This makes driver working after restore from hibernation.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 sound/soc/sh/rcar/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 64d5ecb86528..dabf9a35c25c 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1560,8 +1560,7 @@ static int rsnd_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops rsnd_pm_ops = {
-	.suspend		= rsnd_suspend,
-	.resume			= rsnd_resume,
+	SET_SYSTEM_SLEEP_PM_OPS(rsnd_suspend, rsnd_resume)
 };
 
 static struct platform_driver rsnd_driver = {
-- 
2.11.0
