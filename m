From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: [PATCH 2/5] ASoC: fix pxa2xx-pcm.h path
Date: Fri, 13 Aug 2010 21:55:27 +0800
Message-ID: <AANLkTi=_BX_z68p3SGhr08K5JOmudaNRvZMVUAvSGfZV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8345A1038D9
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 15:55:27 +0200 (CEST)
Received: by mail-ww0-f51.google.com with SMTP id 17so768715wwi.20
	for <alsa-devel@alsa-project.org>; Fri, 13 Aug 2010 06:55:27 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>From b761e3bb374e630011f22ce54963877310a0baca Mon Sep 17 00:00:00 2001
From: Haojian Zhuang <haojian.zhuang@marvell.com>
Date: Fri, 13 Aug 2010 21:14:52 +0800
Subject: [PATCH 2/5] ASoC: fix pxa2xx-pcm.h path

Since pxa2xx-pcm.h is removed from sound/soc/pxa, we need to update the
path in related files.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 sound/soc/pxa/pxa-ssp.c    |    2 +-
 sound/soc/pxa/pxa2xx-pcm.c |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 99d80e8..c4f480d 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -35,7 +35,7 @@
 #include <mach/audio.h>
 #include <plat/ssp.h>

-#include "pxa2xx-pcm.h"
+#include "../../arm/pxa2xx-pcm.h"
 #include "pxa-ssp.h"

 /*
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index 5127044..02fb664 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -16,7 +16,6 @@
 #include <sound/soc.h>
 #include <sound/pxa2xx-lib.h>

-#include "pxa2xx-pcm.h"
 #include "../../arm/pxa2xx-pcm.h"

 static int pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
-- 
1.5.6.5
