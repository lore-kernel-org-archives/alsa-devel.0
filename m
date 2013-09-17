From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] ASoC: SPEAr spdif_out: Use
	devm_snd_soc_register_component
Date: Tue, 17 Sep 2013 11:04:18 +0530
Message-ID: <CAOh2x==NRbyPmYv-jBde2rrYm9b4Yz_Wok08szuxmt6EzEA4Og@mail.gmail.com>
References: <1379394697-19810-1-git-send-email-sachin.kamat@linaro.org>
 <1379394697-19810-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f169.google.com (mail-ve0-f169.google.com
 [209.85.128.169])
 by alsa0.perex.cz (Postfix) with ESMTP id F41472650B4
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2013 07:34:18 +0200 (CEST)
Received: by mail-ve0-f169.google.com with SMTP id db12so3944424veb.0
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2013 22:34:18 -0700 (PDT)
In-Reply-To: <1379394697-19810-2-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: "vipin.kumar" <vipin.kumar@st.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 17, 2013 at 10:41 AM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> devm_snd_soc_register_component makes code simpler.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  sound/soc/spear/spdif_out.c |   12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/sound/soc/spear/spdif_out.c b/sound/soc/spear/spdif_out.c
> index 2fdf68c..70fc4d6 100644
> --- a/sound/soc/spear/spdif_out.c
> +++ b/sound/soc/spear/spdif_out.c
> @@ -307,18 +307,11 @@ static int spdif_out_probe(struct platform_device *pdev)
>
>         dev_set_drvdata(&pdev->dev, host);
>
> -       ret = snd_soc_register_component(&pdev->dev, &spdif_out_component,
> -                                        &spdif_out_dai, 1);
> +       ret = devm_snd_soc_register_component(&pdev->dev, &spdif_out_component,
> +                                             &spdif_out_dai, 1);
>         return ret;
>  }
>

What about doing return devm_snd_soc_register_component(***) here?
And same for the other patch?

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
