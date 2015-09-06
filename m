From: Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH] ASoC: au1x: psc-i2s: Fix unused variable
	'ret' warning
Date: Sun, 6 Sep 2015 11:37:37 +0200
Message-ID: <CAOLZvyH9m1AwJvz6g3WKMnCcdf55BhAHic3AFeAHcRH-_h9sHg@mail.gmail.com>
References: <1441090215.22437.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f48.google.com (mail-la0-f48.google.com
 [209.85.215.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D3B92606E2
 for <alsa-devel@alsa-project.org>; Sun,  6 Sep 2015 11:38:17 +0200 (CEST)
Received: by lanb10 with SMTP id b10so36194721lan.3
 for <alsa-devel@alsa-project.org>; Sun, 06 Sep 2015 02:38:17 -0700 (PDT)
In-Reply-To: <1441090215.22437.0.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 1, 2015 at 8:50 AM, Axel Lin <axel.lin@ingics.com> wrote:
> Fix below build warning:
> sound/soc/au1x/psc-i2s.c: In function 'au1xpsc_i2s_drvprobe':
> sound/soc/au1x/psc-i2s.c:299:6: warning: unused variable 'ret' [-Wunused-variable]
>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  sound/soc/au1x/psc-i2s.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/sound/soc/au1x/psc-i2s.c b/sound/soc/au1x/psc-i2s.c
> index 38e853a..0bf9d62 100644
> --- a/sound/soc/au1x/psc-i2s.c
> +++ b/sound/soc/au1x/psc-i2s.c
> @@ -296,7 +296,6 @@ static int au1xpsc_i2s_drvprobe(struct platform_device *pdev)
>  {
>         struct resource *iores, *dmares;
>         unsigned long sel;
> -       int ret;
>         struct au1xpsc_audio_data *wd;
>
>         wd = devm_kzalloc(&pdev->dev, sizeof(struct au1xpsc_audio_data),
> --


Acked-by: Manuel Lauss <manuel.lauss@gmail.com>
