From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH] ASoC: Intel: fix a compiling issue
Date: Mon, 13 Apr 2015 06:50:17 +0200
Message-ID: <CAOf5uwnLucwnHgfeaqopcky3Vsbf=RTL_BKT+fr9jNei_bYN2A@mail.gmail.com>
References: <1428893250-21092-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f180.google.com (mail-ig0-f180.google.com
 [209.85.213.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FFF226153F
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 06:50:19 +0200 (CEST)
Received: by igbqf9 with SMTP id qf9so35579738igb.1
 for <alsa-devel@alsa-project.org>; Sun, 12 Apr 2015 21:50:18 -0700 (PDT)
In-Reply-To: <1428893250-21092-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Hi

On Apr 13, 2015 4:44 AM, "Jie Yang" <yang.jie@intel.com> wrote:
>
> Fix the compiling issue that we don't have snd_soc_suspend/resume()
> when CONFIG_PM_SLEEP is not defined.
>
> Signed-off-by: Jie Yang <yang.jie@intel.com>
> ---
>  sound/soc/intel/haswell/sst-haswell-pcm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/intel/haswell/sst-haswell-pcm.c
b/sound/soc/intel/haswell/sst-haswell-pcm.c
> index 23ae040..f84eb14 100644
> --- a/sound/soc/intel/haswell/sst-haswell-pcm.c
> +++ b/sound/soc/intel/haswell/sst-haswell-pcm.c
> @@ -1313,8 +1313,9 @@ static void hsw_pcm_complete(struct device *dev)
>                         dev_err(dev, "failed to restore context for PCM
%d\n", i);
>         }
>
> +#ifdef CONFIG_PM_SLEEP
>         snd_soc_resume(pdata->soc_card->dev);
> -
> +#endif

I think it's better to include an empy version for this configuration

Michael

>         err = sst_hsw_dsp_runtime_resume(hsw);
>         if (err < 0)
>                 return;
> @@ -1367,7 +1368,9 @@ static int hsw_pcm_prepare(struct device *dev)
>                 sst_hsw_dsp_runtime_sleep(hsw);
>         }
>
> +#ifdef CONFIG_PM_SLEEP
>         snd_soc_suspend(pdata->soc_card->dev);
> +#endif
>         snd_soc_poweroff(pdata->soc_card->dev);
>
>         pdata->pm_state = HSW_PM_STATE_D3;
> --
> 1.9.1
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
