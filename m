From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] ASoC: pcm: Use the power efficient
	workqueue for delayed powerdown
Date: Thu, 18 Jul 2013 16:26:53 +0530
Message-ID: <CAKohpokYFSNGTzWv5_FOpMwaJ0WZ-3fQum5fjfd9uYE7CHN7kQ@mail.gmail.com>
References: <1374144867-25675-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qe0-f54.google.com (mail-qe0-f54.google.com
 [209.85.128.54])
 by alsa0.perex.cz (Postfix) with ESMTP id D35222655B3
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2013 12:56:53 +0200 (CEST)
Received: by mail-qe0-f54.google.com with SMTP id ne12so1712899qeb.27
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2013 03:56:53 -0700 (PDT)
In-Reply-To: <1374144867-25675-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 18 July 2013 16:24, Mark Brown <broonie@kernel.org> wrote:
> From: Mark Brown <broonie@linaro.org>
>
> There is no need to use a normal per-CPU workqueue for delayed power downs
> as they're not timing or performance critical and waking up a core for them
> would defeat some of the point.
>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  sound/soc/soc-pcm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index b6c6403..f4f68cb 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -411,8 +411,9 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
>                 } else {
>                         /* start delayed pop wq here for playback streams */
>                         rtd->pop_wait = 1;
> -                       schedule_delayed_work(&rtd->delayed_work,
> -                               msecs_to_jiffies(rtd->pmdown_time));
> +                       queue_delayed_work(system_power_efficient_wq,
> +                                          &rtd->delayed_work,
> +                                          msecs_to_jiffies(rtd->pmdown_time));
>                 }
>         } else {
>                 /* capture streams can be powered down now */

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
