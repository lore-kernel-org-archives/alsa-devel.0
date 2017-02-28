From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] ASoC: ux500: drop platform DAI assignments
Date: Tue, 28 Feb 2017 15:43:43 +0100
Message-ID: <20170228144343.10721-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f45.google.com (mail-lf0-f45.google.com
 [209.85.215.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 24376265142
 for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2017 15:43:51 +0100 (CET)
Received: by mail-lf0-f45.google.com with SMTP id z127so6485625lfa.2
 for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2017 06:43:51 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: alsa-devel@alsa-project.org

This platform is completely probed by device tree nowadays, so
we need to do a bigger cleanup removing all the non-DT codepaths.
This cleanup must however go in as a fix since it fixes a
regression.

Currently when Ux500 audio is enabled, dmesg complains like
this:

entry->name == "prealloc"
entry->name == "prealloc_max"
entry->name == "prealloc"
------------[ cut here ]------------
WARNING: CPU: 0 PID: 95 at ../fs/proc/generic.c:346
proc_register+0xf0/0x110
proc_dir_entry 'sub0/prealloc' already registered
(...)
entry->name == "prealloc_max"
------------[ cut here ]------------
WARNING: CPU: 0 PID: 95 at ../fs/proc/generic.c:346
proc_register+0xf0/0x110
proc_dir_entry 'sub0/prealloc_max' already registered
(...)
snd-soc-mop500 soc:sound: ab8500-codec-dai.0 <->
80124000.msp mapping ok
entry->name == "prealloc"
entry->name == "prealloc_max"
entry->name == "prealloc"
------------[ cut here ]------------
WARNING: CPU: 0 PID: 95 at ../fs/proc/generic.c:346
proc_register+0xf0/0x110
proc_dir_entry 'sub0/prealloc' already registered
(...)
entry->name == "prealloc_max"
------------[ cut here ]------------
WARNING: CPU: 0 PID: 95 at ../fs/proc/generic.c:346
proc_register+0xf0/0x110
proc_dir_entry 'sub0/prealloc_max' already registered
snd-soc-mop500 soc:sound: ab8500-codec-dai.1 <->
80125000.msp mapping ok

This is because PCMs are created twice for the same hardware,
and this happens because both "platform" and "CPU" DAI links
are specified.

But platform/CPU is an either/or pair, not a both/and pair.
This has maybe worked in the past, but it is causing trouble
now, so let us begin the cleanups by removing the platform
assignment and silencing the boot noise, and make a proper DT
cleanup for the next kernel cycle.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 sound/soc/ux500/mop500.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
index ba9fc099cf67..b50f68a439ce 100644
--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -33,7 +33,6 @@ static struct snd_soc_dai_link mop500_dai_links[] = {
 		.stream_name = "ab8500_0",
 		.cpu_dai_name = "ux500-msp-i2s.1",
 		.codec_dai_name = "ab8500-codec-dai.0",
-		.platform_name = "ux500-msp-i2s.1",
 		.codec_name = "ab8500-codec.0",
 		.init = mop500_ab8500_machine_init,
 		.ops = mop500_ab8500_ops,
@@ -43,7 +42,6 @@ static struct snd_soc_dai_link mop500_dai_links[] = {
 		.stream_name = "ab8500_1",
 		.cpu_dai_name = "ux500-msp-i2s.3",
 		.codec_dai_name = "ab8500-codec-dai.1",
-		.platform_name = "ux500-msp-i2s.3",
 		.codec_name = "ab8500-codec.0",
 		.init = NULL,
 		.ops = mop500_ab8500_ops,
@@ -87,8 +85,6 @@ static int mop500_of_probe(struct platform_device *pdev,
 	for (i = 0; i < 2; i++) {
 		mop500_dai_links[i].cpu_of_node = msp_np[i];
 		mop500_dai_links[i].cpu_dai_name = NULL;
-		mop500_dai_links[i].platform_of_node = msp_np[i];
-		mop500_dai_links[i].platform_name = NULL;
 		mop500_dai_links[i].codec_of_node = codec_np;
 		mop500_dai_links[i].codec_name = NULL;
 	}
-- 
2.9.3
