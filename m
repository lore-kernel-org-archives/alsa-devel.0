From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ASoC: topology: Fix error return code in
	soc_tplg_dapm_widget_create()
Date: Wed, 10 Aug 2016 13:43:12 +0000
Message-ID: <1470836592-11679-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BBC72666D4
 for <alsa-devel@alsa-project.org>; Wed, 10 Aug 2016 15:43:20 +0200 (CEST)
Received: by mail-pf0-f195.google.com with SMTP id y134so2892140pfg.3
 for <alsa-devel@alsa-project.org>; Wed, 10 Aug 2016 06:43:20 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Wei Yongjun <weiyj.lk@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Fix to return error code -ENOMEM instead of 0 when failed to create
widget, as done elsewhere in this function.

Fixes: 8a9782346dcc ("ASoC: topology: Add topology core")
Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 sound/soc/soc-topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 05a18f6..a9e83a2 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1476,6 +1476,7 @@ widget:
 	if (widget == NULL) {
 		dev_err(tplg->dev, "ASoC: failed to create widget %s controls\n",
 			w->name);
+		ret = -ENOMEM;
 		goto hdr_err;
 	}
