From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 2/2] ASoC: PXA: Z2: Fix codec pin name
Date: Fri, 11 Mar 2011 11:05:38 +0200
Message-ID: <1299834338-9185-2-git-send-email-anarsoul@gmail.com>
References: <1299834338-9185-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 669752413F
	for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2011 10:06:25 +0100 (CET)
Received: by mail-bw0-f51.google.com with SMTP id 10so2467540bwz.38
	for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2011 01:06:25 -0800 (PST)
In-Reply-To: <1299834338-9185-1-git-send-email-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Marek Vasut <marek.vasut@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
List-Id: alsa-devel@alsa-project.org

MONO was renamed to MONO1.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/soc/pxa/z2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/pxa/z2.c b/sound/soc/pxa/z2.c
index b0b6c8d..d69d9fc 100644
--- a/sound/soc/pxa/z2.c
+++ b/sound/soc/pxa/z2.c
@@ -152,7 +152,7 @@ static int z2_wm8750_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_disable_pin(dapm, "LINPUT3");
 	snd_soc_dapm_disable_pin(dapm, "RINPUT3");
 	snd_soc_dapm_disable_pin(dapm, "OUT3");
-	snd_soc_dapm_disable_pin(dapm, "MONO");
+	snd_soc_dapm_disable_pin(dapm, "MONO1");
 
 	/* Add z2 specific widgets */
 	snd_soc_dapm_new_controls(dapm, wm8750_dapm_widgets,
-- 
1.7.4.1
