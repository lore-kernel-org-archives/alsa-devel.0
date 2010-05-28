From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH v2] alsa/Au1xxx-PSC: use resource_size
Date: Fri, 28 May 2010 08:53:32 +0200
Message-ID: <AANLkTim9C08G5iOuKE9XOtFRlS616c6yk-7LNLddbVCl@mail.gmail.com>
References: <4BFF33B3.1040506@gmail.com>
	<AANLkTil1hKb8QdsKEfHseOyPdw8uIY6d5mVEUwZ68T-p@mail.gmail.com>
	<AANLkTimQD4TihG2yGsPLGmCmWV968fdoDtZ1nDcW5A-h@mail.gmail.com>
	<4BFF5838.8050403@gmail.com>
	<AANLkTikn3BHn1D3uVQWO6Xuiv4vkk8pMe96F7uUUSAmM@mail.gmail.com>
	<4BFF633B.7030101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 574D6103AD5
	for <alsa-devel@alsa-project.org>;
	Fri, 28 May 2010 08:53:34 +0200 (CEST)
Received: by yxd5 with SMTP id 5so54615yxd.38
	for <alsa-devel@alsa-project.org>; Thu, 27 May 2010 23:53:33 -0700 (PDT)
In-Reply-To: <4BFF633B.7030101@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: manuel.lauss@gmail.com, alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

On Fri, May 28, 2010 at 8:31 AM, Wan ZongShun <mcuos.com@gmail.com> wrote:
> Dear Manuel,
>
> For insteading of using the 'platform_get_resource' in remove function,
> I think it better to put 'struct resource *r' into 'wd' structure.
>
> I have re-organized the patch and submit to you.
>
> Of course, I must get your approval if I do above. :)
>
> Signed-off-by:Wan ZongShun<mcuos.com@gmail.com>

The patch doesn't apply at all to latest linus-git.

How about something much simpler, like this for example:

diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
index a61ccd2..a18e924 100644
--- a/sound/soc/au1x/psc-ac97.c
+++ b/sound/soc/au1x/psc-ac97.c
@@ -375,7 +375,7 @@ static int __devinit au1xpsc_ac97_drvprobe(struct
platform_device *pdev)
        }

        ret = -EBUSY;
-       wd->ioarea = request_mem_region(r->start, r->end - r->start + 1,
+       wd->ioarea = request_mem_region(r->start, resource_size(r),
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
-       wd->ioarea = request_mem_region(r->start, r->end - r->start + 1,
+       wd->ioarea = request_mem_region(r->start, resource_size(r),
                                        "au1xpsc_i2s");
        if (!wd->ioarea)
                goto out0;

Manuel
