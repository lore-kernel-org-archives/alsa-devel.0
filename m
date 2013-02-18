From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/5] ASoC: max98090: Make struct dev_pm_ops
	const
Date: Mon, 18 Feb 2013 17:02:12 +0530
Message-ID: <1361187134-7525-3-git-send-email-sachin.kamat@linaro.org>
References: <1361187134-7525-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 by alsa0.perex.cz (Postfix) with ESMTP id A6464264F07
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2013 12:42:15 +0100 (CET)
Received: by mail-pa0-f42.google.com with SMTP id kq12so2774597pab.1
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2013 03:42:14 -0800 (PST)
In-Reply-To: <1361187134-7525-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, sachin.kamat@linaro.org, broonie@opensource.wolfsonmicro.com, jerry.wong@maximintegrated.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

Silences the following checkpatch warning:
WARNING: struct dev_pm_ops should normally be const.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/codecs/max98090.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index fef370e..1cf017f 100755
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2362,7 +2362,7 @@ static int max98090_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static struct dev_pm_ops max98090_pm = {
+static const struct dev_pm_ops max98090_pm = {
 	SET_RUNTIME_PM_OPS(max98090_runtime_suspend,
 		max98090_runtime_resume, NULL)
 };
-- 
1.7.4.1
