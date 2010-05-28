From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH v2] alsa/Au1xxx-PSC: use resource_size
Date: Fri, 28 May 2010 13:44:24 +0800
Message-ID: <4BFF5838.8050403@gmail.com>
References: <4BFF33B3.1040506@gmail.com>	<AANLkTil1hKb8QdsKEfHseOyPdw8uIY6d5mVEUwZ68T-p@mail.gmail.com>
	<AANLkTimQD4TihG2yGsPLGmCmWV968fdoDtZ1nDcW5A-h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f193.google.com (mail-pz0-f193.google.com
	[209.85.222.193])
	by alsa0.perex.cz (Postfix) with ESMTP id BEEA0103AC1
	for <alsa-devel@alsa-project.org>;
	Fri, 28 May 2010 07:44:37 +0200 (CEST)
Received: by pzk31 with SMTP id 31so478472pzk.16
	for <alsa-devel@alsa-project.org>; Thu, 27 May 2010 22:44:36 -0700 (PDT)
In-Reply-To: <AANLkTimQD4TihG2yGsPLGmCmWV968fdoDtZ1nDcW5A-h@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <manuel.lauss@googlemail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: manuel.lauss@gmail.com, alsa-devel <alsa-devel@alsa-project.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

Dear Manuel & Mark,

Fix it again.

Signed-off-by:Wan ZongShun<mcuos.com@gmail.com>

 From 389d787f06d2ac0b4c8cac2705385295b0d7c112 Mon Sep 17 00:00:00 2001
From: zswan <zswan@zswan-marvell.(none)>
Date: Fri, 28 May 2010 13:39:12 +0800
Subject: [PATCH 4/4] -fix-some-issues-of-aux01 v1

---
  sound/soc/au1x/psc-ac97.c |   13 ++++++-------
  sound/soc/au1x/psc-i2s.c  |   12 ++++++------
  2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
index a61ccd2..55e1d15 100644
--- a/sound/soc/au1x/psc-ac97.c
+++ b/sound/soc/au1x/psc-ac97.c
@@ -375,12 +375,12 @@ static int __devinit au1xpsc_ac97_drvprobe(struct 
platform_device *pdev)
  	}

  	ret = -EBUSY;
-	wd->ioarea = request_mem_region(r->start, r->end - r->start + 1,
-					"au1xpsc_ac97");
+	wd->ioarea = request_mem_region(r->start, resource_size(r),
+					pdev->name);
  	if (!wd->ioarea)
  		goto out0;

-	wd->mmio = ioremap(r->start, 0xffff);
+	wd->mmio = ioremap(r->start, resource_size(r));
  	if (!wd->mmio)
  		goto out1;

@@ -410,8 +410,7 @@ static int __devinit au1xpsc_ac97_drvprobe(struct 
platform_device *pdev)

  	snd_soc_unregister_dai(&au1xpsc_ac97_dai);
  out1:
-	release_resource(wd->ioarea);
-	kfree(wd->ioarea);
+	release_mem_region(r->start, resource_size(r));
  out0:
  	kfree(wd);
  	return ret;
@@ -420,6 +419,7 @@ out0:
  static int __devexit au1xpsc_ac97_drvremove(struct platform_device *pdev)
  {
  	struct au1xpsc_audio_data *wd = platform_get_drvdata(pdev);
+	struct resource *r = platform_get_resource(pdev, IORESOURCE_MEM, 0);

  	if (wd->dmapd)
  		au1xpsc_pcm_destroy(wd->dmapd);
@@ -433,8 +433,7 @@ static int __devexit au1xpsc_ac97_drvremove(struct 
platform_device *pdev)
  	au_sync();

  	iounmap(wd->mmio);
-	release_resource(wd->ioarea);
-	kfree(wd->ioarea);
+	release_mem_region(r->start, resource_size(r));
  	kfree(wd);

  	au1xpsc_ac97_workdata = NULL;	/* MDEV */
diff --git a/sound/soc/au1x/psc-i2s.c b/sound/soc/au1x/psc-i2s.c
index 495be6e..d529283 100644
--- a/sound/soc/au1x/psc-i2s.c
+++ b/sound/soc/au1x/psc-i2s.c
@@ -321,12 +321,12 @@ static int __init au1xpsc_i2s_drvprobe(struct 
platform_device *pdev)
  	}

  	ret = -EBUSY;
-	wd->ioarea = request_mem_region(r->start, r->end - r->start + 1,
-					"au1xpsc_i2s");
+	wd->ioarea = request_mem_region(r->start, resource_size(r),
+					pdev->name);
  	if (!wd->ioarea)
  		goto out0;

-	wd->mmio = ioremap(r->start, 0xffff);
+	wd->mmio = ioremap(r->start, resource_size(r));
  	if (!wd->mmio)
  		goto out1;

@@ -362,8 +362,7 @@ static int __init au1xpsc_i2s_drvprobe(struct 
platform_device *pdev)

  	snd_soc_unregister_dai(&au1xpsc_i2s_dai);
  out1:
-	release_resource(wd->ioarea);
-	kfree(wd->ioarea);
+	release_mem_region(r->start, resource_size(r));
  out0:
  	kfree(wd);
  	return ret;
@@ -372,6 +371,7 @@ out0:
  static int __devexit au1xpsc_i2s_drvremove(struct platform_device *pdev)
  {
  	struct au1xpsc_audio_data *wd = platform_get_drvdata(pdev);
+	struct resource *r = platform_get_resource(pdev, IORESOURCE_MEM, 0);

  	if (wd->dmapd)
  		au1xpsc_pcm_destroy(wd->dmapd);
@@ -384,7 +384,7 @@ static int __devexit au1xpsc_i2s_drvremove(struct 
platform_device *pdev)
  	au_sync();

  	iounmap(wd->mmio);
-	release_resource(wd->ioarea);
+	release_mem_region(r->start, resource_size(r));
  	kfree(wd->ioarea);
  	kfree(wd);

-- 
1.6.3.3
