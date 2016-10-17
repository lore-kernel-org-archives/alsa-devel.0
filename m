From: Keyon Jie <yang.jie@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 1/7] ASoC: intel: broadwell: constify
 snd_soc_ops structures
Date: Mon, 17 Oct 2016 10:22:06 +0800
Message-ID: <580435CE.4010909@linux.intel.com>
References: <1476543351-17858-1-git-send-email-Julia.Lawall@lip6.fr>
 <1476543351-17858-2-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1476543351-17858-2-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org


On 2016年10月15日 22:55, Julia Lawall wrote:
> Check for snd_soc_ops structures that are only stored in the ops field of a
> snd_soc_dai_link structure.  This field is declared const, so snd_soc_ops
> structures that have this property can be declared as const also.
>
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
>
> // <smpl>
> @r disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct snd_soc_ops i@p = { ... };
>
> @ok1@
> identifier r.i;
> struct snd_soc_dai_link e;
> position p;
> @@
> e.ops = &i@p;
>
> @ok2@
> identifier r.i, e;
> position p;
> @@
> struct snd_soc_dai_link e[] = { ..., { .ops = &i@p, }, ..., };
>
> @bad@
> position p != {r.p,ok1.p,ok2.p};
> identifier r.i;
> struct snd_soc_ops e;
> @@
> e@i@p
>
> @depends on !bad disable optional_qualifier@
> identifier r.i;
> @@
> static
> +const
>   struct snd_soc_ops i = { ... };
> // </smpl>
>
> The effect on the layout of the .o file is shown by the following output of
> the size command, first before then after the transformation:
>
>     text    data     bss     dec     hex filename
>     3865    2784     384    7033    1b79 sound/soc/intel/boards/broadwell.o
>     3929    2720     384    7033    1b79 sound/soc/intel/boards/broadwell.o
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Thanks. That works for me.

Acked-by: Jie Yang <yang.jie@intel.com>

thanks,
~Keyon

>
> ---
>   sound/soc/intel/boards/broadwell.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff -u -p a/sound/soc/intel/boards/broadwell.c b/sound/soc/intel/boards/broadwell.c
> --- a/sound/soc/intel/boards/broadwell.c
> +++ b/sound/soc/intel/boards/broadwell.c
> @@ -126,7 +126,7 @@ static int broadwell_rt286_hw_params(str
>   	return ret;
>   }
>
> -static struct snd_soc_ops broadwell_rt286_ops = {
> +static const struct snd_soc_ops broadwell_rt286_ops = {
>   	.hw_params = broadwell_rt286_hw_params,
>   };
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
