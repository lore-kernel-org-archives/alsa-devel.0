From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH] ASoC: RX1950: Enable Mic Jack during glue
	driver init
Date: Thu,  6 Jan 2011 22:15:49 +0200
Message-ID: <1294344949-30670-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 53BDA24532
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 21:18:01 +0100 (CET)
Received: by eyg24 with SMTP id 24so6978580eyg.38
	for <alsa-devel@alsa-project.org>; Thu, 06 Jan 2011 12:18:00 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
List-Id: alsa-devel@alsa-project.org

Enable Mic Jack during glue driver init, otherwise capture will not work.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/soc/samsung/rx1950_uda1380.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/samsung/rx1950_uda1380.c b/sound/soc/samsung/rx1950_uda1380.c
index 5a4587e..f400274 100644
--- a/sound/soc/samsung/rx1950_uda1380.c
+++ b/sound/soc/samsung/rx1950_uda1380.c
@@ -246,6 +246,7 @@ static int rx1950_uda1380_init(struct snd_soc_pcm_runtime *rtd)
 
 	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
 	snd_soc_dapm_enable_pin(dapm, "Speaker");
+	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
 
 	snd_soc_dapm_sync(dapm);
 
-- 
1.7.3.2
