From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Display the error code when we fail
	to add a DAPM control
Date: Tue, 6 Sep 2011 01:40:31 +0100
Message-ID: <CABS+qY33LyOyDzGgDOofY5ujzmzMsgP36PsegYEqnmUN+EqsPg@mail.gmail.com>
References: <1315245103-23207-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog106.obsmtp.com (na3sys009aob106.obsmtp.com
	[74.125.149.76]) by alsa0.perex.cz (Postfix) with ESMTP id 4DD9F245AE
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Sep 2011 02:40:32 +0200 (CEST)
Received: by mail-qy0-f172.google.com with SMTP id 34so190031qyk.17
	for <alsa-devel@alsa-project.org>; Mon, 05 Sep 2011 17:40:31 -0700 (PDT)
In-Reply-To: <1315245103-23207-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On 5 September 2011 18:51, Mark Brown
<broonie@opensource.wolfsonmicro.com>wrote:

> Useful for diagnostics.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-dapm.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index 170c4ff..681afc5 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -584,8 +584,8 @@ static int dapm_new_mux(struct snd_soc_dapm_widget *w)
>                                        name + prefix_len, prefix);
>                ret = snd_ctl_add(card, kcontrol);
>                if (ret < 0) {
> -                       dev_err(dapm->dev,
> -                               "asoc: failed to add kcontrol %s\n",
> w->name);
> +                       dev_err(dapm->dev, "failed to add kcontrol %s:
> %d\n",
> +                               w->name, ret);
>                        kfree(wlist);
>                        return ret;
>                }
> --
> 1.7.5.4
>
> Acked-by: Liam Girdwood <lrg@ti.com>
