From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ASoC: Remove extra rtd->dev.init_name
	assignment in soc_probe_dai_link
Date: Tue, 21 Sep 2010 15:36:49 +0300
Message-ID: <1285072609-22191-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id D5A4C2463A
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Sep 2010 14:36:29 +0200 (CEST)
Received: by ewy21 with SMTP id 21so2057622ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2010 05:36:29 -0700 (PDT)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

rtd->dev.init_name is set twice in soc_probe_dai_link. I removed the first
assignement from dai_link->stream_name since then there won't be sysfs name
changes and usually dai_link->name seems to fit anyway better for a sysfs
directory name.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/soc-core.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6001b7f..c8d1596 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1451,7 +1451,6 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 	snd_soc_dapm_sync(codec);
 
 	/* register the rtd device */
-	rtd->dev.init_name = rtd->dai_link->stream_name;
 	rtd->dev.release = rtd_release;
 	rtd->dev.init_name = dai_link->name;
 	ret = device_register(&rtd->dev);
-- 
1.7.1
