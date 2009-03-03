From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH 3/4] ASoC: Remove version display from the
	UDA1380 driver
Date: Tue,  3 Mar 2009 16:10:53 +0100
Message-ID: <1236093054-1952-3-git-send-email-philipp.zabel@gmail.com>
References: <1236093054-1952-1-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f177.google.com (mail-fx0-f177.google.com
	[209.85.220.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C25110384A
	for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2009 16:11:02 +0100 (CET)
Received: by mail-fx0-f177.google.com with SMTP id 25so2677141fxm.32
	for <alsa-devel@alsa-project.org>; Tue, 03 Mar 2009 07:11:02 -0800 (PST)
In-Reply-To: <1236093054-1952-1-git-send-email-philipp.zabel@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 sound/soc/codecs/uda1380.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 1e3769d..a6987d7 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -35,8 +35,6 @@
 
 #include "uda1380.h"
 
-#define UDA1380_VERSION "0.6"
-
 /*
  * uda1380 register cache
  */
@@ -831,8 +829,6 @@ static int uda1380_probe(struct platform_device *pdev)
 	struct snd_soc_codec *codec;
 	int ret;
 
-	pr_info("UDA1380 Audio Codec %s", UDA1380_VERSION);
-
 	setup = socdev->codec_data;
 	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
 	if (codec == NULL)
-- 
1.6.1.3
