From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH v2] alsa/Au1xxx-PSC: use resource_size
Date: Fri, 28 May 2010 07:52:19 +0200
Message-ID: <AANLkTikn3BHn1D3uVQWO6Xuiv4vkk8pMe96F7uUUSAmM@mail.gmail.com>
References: <4BFF33B3.1040506@gmail.com>
	<AANLkTil1hKb8QdsKEfHseOyPdw8uIY6d5mVEUwZ68T-p@mail.gmail.com>
	<AANLkTimQD4TihG2yGsPLGmCmWV968fdoDtZ1nDcW5A-h@mail.gmail.com>
	<4BFF5838.8050403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 77043103AD6
	for <alsa-devel@alsa-project.org>;
	Fri, 28 May 2010 07:52:20 +0200 (CEST)
Received: by yxd5 with SMTP id 5so52784yxd.38
	for <alsa-devel@alsa-project.org>; Thu, 27 May 2010 22:52:19 -0700 (PDT)
In-Reply-To: <4BFF5838.8050403@gmail.com>
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

On Fri, May 28, 2010 at 7:44 AM, Wan ZongShun <mcuos.com@gmail.com> wrote:
> Dear Manuel & Mark,
>
> Fix it again.

> Signed-off-by:Wan ZongShun<mcuos.com@gmail.com>
>
> From 389d787f06d2ac0b4c8cac2705385295b0d7c112 Mon Sep 17 00:00:00 2001
> From: zswan <zswan@zswan-marvell.(none)>
> Date: Fri, 28 May 2010 13:39:12 +0800
> Subject: [PATCH 4/4] -fix-some-issues-of-aux01 v1

Please write a proper log entry.


> --- a/sound/soc/au1x/psc-i2s.c
> +++ b/sound/soc/au1x/psc-i2s.c
[snip]
> @@ -372,6 +371,7 @@ out0:
> =A0static int __devexit au1xpsc_i2s_drvremove(struct platform_device *pde=
v)
> =A0{
> =A0 =A0 =A0 =A0struct au1xpsc_audio_data *wd =3D platform_get_drvdata(pde=
v);
> + =A0 =A0 =A0 struct resource *r =3D platform_get_resource(pdev, IORESOUR=
CE_MEM, 0);
>
> =A0 =A0 =A0 =A0if (wd->dmapd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0au1xpsc_pcm_destroy(wd->dmapd);
> @@ -384,7 +384,7 @@ static int __devexit au1xpsc_i2s_drvremove(struct
> platform_device *pdev)
> =A0 =A0 =A0 =A0au_sync();
>
> =A0 =A0 =A0 =A0iounmap(wd->mmio);
> - =A0 =A0 =A0 release_resource(wd->ioarea);
> + =A0 =A0 =A0 release_mem_region(r->start, resource_size(r));
> =A0 =A0 =A0 =A0kfree(wd->ioarea);

This kfree() needs to go too.  (Sidenote:  I wrote the code this way to avo=
id
the platform_get_resource() you inserted above).

> =A0 =A0 =A0 =A0kfree(wd);

I'll run it on real hardware just to be sure.

       Manuel
