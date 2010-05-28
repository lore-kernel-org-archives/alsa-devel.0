From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH v2] alsa/Au1xxx-PSC: use resource_size
Date: Fri, 28 May 2010 17:07:40 +0800
Message-ID: <4BFF87DC.4010300@gmail.com>
References: <4BFF33B3.1040506@gmail.com>	<AANLkTil1hKb8QdsKEfHseOyPdw8uIY6d5mVEUwZ68T-p@mail.gmail.com>	<AANLkTimQD4TihG2yGsPLGmCmWV968fdoDtZ1nDcW5A-h@mail.gmail.com>	<4BFF5838.8050403@gmail.com>	<AANLkTikn3BHn1D3uVQWO6Xuiv4vkk8pMe96F7uUUSAmM@mail.gmail.com>	<4BFF633B.7030101@gmail.com>
	<AANLkTim9C08G5iOuKE9XOtFRlS616c6yk-7LNLddbVCl@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f189.google.com (mail-pz0-f189.google.com
	[209.85.222.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D25C24374
	for <alsa-devel@alsa-project.org>;
	Fri, 28 May 2010 11:07:50 +0200 (CEST)
Received: by pzk27 with SMTP id 27so703472pzk.2
	for <alsa-devel@alsa-project.org>; Fri, 28 May 2010 02:07:50 -0700 (PDT)
In-Reply-To: <AANLkTim9C08G5iOuKE9XOtFRlS616c6yk-7LNLddbVCl@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Manuel Lauss <manuel.lauss@googlemail.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dear Mark & Liam,

alsa Au1xxx-PSC use resource_size.

Manuel has agreed this following version patch, now, can it be merged?


Signed-off-by: Wan ZongShun<mcuos.com@gmail.com>
---
  sound/soc/au1x/psc-ac97.c |    2 +-
  sound/soc/au1x/psc-i2s.c  |    2 +-
  2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
index a61ccd2..a18e924 100644
--- a/sound/soc/au1x/psc-ac97.c
+++ b/sound/soc/au1x/psc-ac97.c
@@ -375,7 +375,7 @@ static int __devinit au1xpsc_ac97_drvprobe(struct 
platform_device *pdev)
  	}

  	ret = -EBUSY;
-	wd->ioarea = request_mem_region(r->start, r->end - r->start + 1,
+	wd->ioarea = request_mem_region(r->start, resource_size(r),
  					"au1xpsc_ac97");
  	if (!wd->ioarea)
  		goto out0;
diff --git a/sound/soc/au1x/psc-i2s.c b/sound/soc/au1x/psc-i2s.c
index 495be6e..76e848f 100644
--- a/sound/soc/au1x/psc-i2s.c
+++ b/sound/soc/au1x/psc-i2s.c
@@ -321,7 +321,7 @@ static int __init au1xpsc_i2s_drvprobe(struct 
platform_device *pdev)
  	}

  	ret = -EBUSY;
-	wd->ioarea = request_mem_region(r->start, r->end - r->start + 1,
+	wd->ioarea = request_mem_region(r->start, resource_size(r),
  					"au1xpsc_i2s");
  	if (!wd->ioarea)
  		goto out0;
-- 
1.6.3.3
