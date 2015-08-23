From: Vaishali Thakkar <vthakkar1994@gmail.com>
Subject: Re: [PATCH] ASoC: tegra: Fix unused variable 'spdif'
	warning
Date: Sun, 23 Aug 2015 08:45:33 +0530
Message-ID: <CAK-LDbKwt6NstwK1DOvnJJX7g1+Dov4G1bwLvq8kwz0BYLPGMA@mail.gmail.com>
References: <1440295633.12294.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f174.google.com (mail-yk0-f174.google.com
 [209.85.160.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C31F260470
 for <alsa-devel@alsa-project.org>; Sun, 23 Aug 2015 05:15:34 +0200 (CEST)
Received: by ykdt205 with SMTP id t205so106060405ykd.1
 for <alsa-devel@alsa-project.org>; Sat, 22 Aug 2015 20:15:33 -0700 (PDT)
In-Reply-To: <1440295633.12294.0.camel@ingics.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 23, 2015 at 7:37 AM, Axel Lin <axel.lin@ingics.com> wrote:
> Fix below build warning:
>   CC [M]  sound/soc/tegra/tegra20_spdif.o
> sound/soc/tegra/tegra20_spdif.c: In function 'tegra20_spdif_platform_remove':
> sound/soc/tegra/tegra20_spdif.c:361:24: warning: unused variable 'spdif' [-Wunused-variable]
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Reviewed-by: Vaishali Thakkar <vthakkar1994@gmail.com>

> ---
>  sound/soc/tegra/tegra20_spdif.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_spdif.c
> index 66237bc..0809b1e 100644
> --- a/sound/soc/tegra/tegra20_spdif.c
> +++ b/sound/soc/tegra/tegra20_spdif.c
> @@ -358,8 +358,6 @@ err_pm_disable:
>
>  static int tegra20_spdif_platform_remove(struct platform_device *pdev)
>  {
> -       struct tegra20_spdif *spdif = dev_get_drvdata(&pdev->dev);
> -
>         pm_runtime_disable(&pdev->dev);
>         if (!pm_runtime_status_suspended(&pdev->dev))
>                 tegra20_spdif_runtime_suspend(&pdev->dev);
> --
> 2.1.0
>

Thanks for sending this patch.

>



-- 
Vaishali
