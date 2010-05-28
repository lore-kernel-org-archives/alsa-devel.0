From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH v2] alsa/Au1xxx-PSC: use resource_size
Date: Fri, 28 May 2010 14:31:23 +0800
Message-ID: <4BFF633B.7030101@gmail.com>
References: <4BFF33B3.1040506@gmail.com>	<AANLkTil1hKb8QdsKEfHseOyPdw8uIY6d5mVEUwZ68T-p@mail.gmail.com>	<AANLkTimQD4TihG2yGsPLGmCmWV968fdoDtZ1nDcW5A-h@mail.gmail.com>	<4BFF5838.8050403@gmail.com>
	<AANLkTikn3BHn1D3uVQWO6Xuiv4vkk8pMe96F7uUUSAmM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6168E103AC5
	for <alsa-devel@alsa-project.org>;
	Fri, 28 May 2010 08:31:38 +0200 (CEST)
Received: by pwj9 with SMTP id 9so454783pwj.38
	for <alsa-devel@alsa-project.org>; Thu, 27 May 2010 23:31:37 -0700 (PDT)
In-Reply-To: <AANLkTikn3BHn1D3uVQWO6Xuiv4vkk8pMe96F7uUUSAmM@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: manuel.lauss@gmail.com, alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

Dear Manuel,

For insteading of using the 'platform_get_resource' in remove function,
I think it better to put 'struct resource *r' into 'wd' structure.

I have re-organized the patch and submit to you.

Of course, I must get your approval if I do above. :)

Signed-off-by:Wan ZongShun<mcuos.com@gmail.com>

---
  sound/soc/au1x/psc-ac97.c |   17 ++++++-----------
  sound/soc/au1x/psc-i2s.c  |   17 ++++++-----------
  sound/soc/au1x/psc.h      |    2 +-
  3 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
index a61ccd2..6bd7376 100644
--- a/sound/soc/au1x/psc-ac97.c
+++ b/sound/soc/au1x/psc-ac97.c
@@ -355,7 +355,6 @@ EXPORT_SYMBOL_GPL(au1xpsc_ac97_dai);
  static int __devinit au1xpsc_ac97_drvprobe(struct platform_device *pdev)
  {
  	int ret;
-	struct resource *r;
  	unsigned long sel;
  	struct au1xpsc_audio_data *wd;

@@ -368,19 +367,17 @@ static int __devinit au1xpsc_ac97_drvprobe(struct 
platform_device *pdev)

  	mutex_init(&wd->lock);

-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r) {
+	wd->r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!wd->r) {
  		ret = -ENODEV;
  		goto out0;
  	}

  	ret = -EBUSY;
-	wd->ioarea = request_mem_region(r->start, r->end - r->start + 1,
-					"au1xpsc_ac97");
-	if (!wd->ioarea)
+	if (!request_mem_region(wd->r->start, resource_size(wd->r), pdev->name))
  		goto out0;

-	wd->mmio = ioremap(r->start, 0xffff);
+	wd->mmio = ioremap(wd->r->start, resource_size(wd->r));
  	if (!wd->mmio)
  		goto out1;

@@ -410,8 +407,7 @@ static int __devinit au1xpsc_ac97_drvprobe(struct 
platform_device *pdev)

  	snd_soc_unregister_dai(&au1xpsc_ac97_dai);
  out1:
-	release_resource(wd->ioarea);
-	kfree(wd->ioarea);
+	release_mem_region(wd->r->start, resource_size(wd->r));
  out0:
  	kfree(wd);
  	return ret;
@@ -433,8 +429,7 @@ static int __devexit au1xpsc_ac97_drvremove(struct 
platform_device *pdev)
  	au_sync();

  	iounmap(wd->mmio);
-	release_resource(wd->ioarea);
-	kfree(wd->ioarea);
+	release_mem_region(wd->r->start, resource_size(wd->r));
  	kfree(wd);

  	au1xpsc_ac97_workdata = NULL;	/* MDEV */
diff --git a/sound/soc/au1x/psc-i2s.c b/sound/soc/au1x/psc-i2s.c
index 495be6e..9fb3eed 100644
--- a/sound/soc/au1x/psc-i2s.c
+++ b/sound/soc/au1x/psc-i2s.c
@@ -302,7 +302,6 @@ EXPORT_SYMBOL(au1xpsc_i2s_dai);

  static int __init au1xpsc_i2s_drvprobe(struct platform_device *pdev)
  {
-	struct resource *r;
  	unsigned long sel;
  	int ret;
  	struct au1xpsc_audio_data *wd;
@@ -314,19 +313,17 @@ static int __init au1xpsc_i2s_drvprobe(struct 
platform_device *pdev)
  	if (!wd)
  		return -ENOMEM;

-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r) {
+	wd->r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!wd->r) {
  		ret = -ENODEV;
  		goto out0;
  	}

  	ret = -EBUSY;
-	wd->ioarea = request_mem_region(r->start, r->end - r->start + 1,
-					"au1xpsc_i2s");
-	if (!wd->ioarea)
+	if (!request_mem_region(wd->r->start, resource_size(wd->r), pdev->name))
  		goto out0;

-	wd->mmio = ioremap(r->start, 0xffff);
+	wd->mmio = ioremap(wd->r->start, resource_size(wd->r));
  	if (!wd->mmio)
  		goto out1;

@@ -362,8 +359,7 @@ static int __init au1xpsc_i2s_drvprobe(struct 
platform_device *pdev)

  	snd_soc_unregister_dai(&au1xpsc_i2s_dai);
  out1:
-	release_resource(wd->ioarea);
-	kfree(wd->ioarea);
+	release_mem_region(wd->r->start, resource_size(wd->r));
  out0:
  	kfree(wd);
  	return ret;
@@ -384,8 +380,7 @@ static int __devexit au1xpsc_i2s_drvremove(struct 
platform_device *pdev)
  	au_sync();

  	iounmap(wd->mmio);
-	release_resource(wd->ioarea);
-	kfree(wd->ioarea);
+	release_mem_region(wd->r->start, resource_size(wd->r));
  	kfree(wd);

  	au1xpsc_i2s_workdata = NULL;	/* MDEV */
diff --git a/sound/soc/au1x/psc.h b/sound/soc/au1x/psc.h
index 32d3807..4680a53 100644
--- a/sound/soc/au1x/psc.h
+++ b/sound/soc/au1x/psc.h
@@ -32,7 +32,7 @@ struct au1xpsc_audio_data {
  	unsigned long rate;

  	unsigned long pm[2];
-	struct resource *ioarea;
+	struct resource *r;
  	struct mutex lock;
  	struct platform_device *dmapd;
  };
-- 
1.6.3.3
