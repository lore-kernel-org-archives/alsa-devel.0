From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] ASoC: compress: Correct handling of
	compressed ops
Date: Thu, 25 Jan 2018 09:47:45 +0000
Message-ID: <20180125094745.rxboofyab5ey5nux@localhost.localdomain>
References: <20180124135525.5633-1-ckeepax@opensource.cirrus.com>
 <87wp06lotn.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B81D266A74
 for <alsa-devel@alsa-project.org>; Thu, 25 Jan 2018 10:47:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87wp06lotn.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 25, 2018 at 01:18:37AM +0000, Kuninori Morimoto wrote:
> soc_compr_get_component() searches 1st component which have compr_ops,
> but it doesn't check compr_ops->xxx, In above case, compr_ops->open.
> Is it OK ?
> 
> For me, it looks like we can solve it by using "break" and "goto".
> "goto" is quick hack for now.
> For example like below (not tested).
> If we can use rtd->platform, use it, and skip rtdcom loop by using "goto".
> If we use rtdcom, call "break" after calling 1st callback.
> soc_rtdcom_xxx() in soc-pcm.c is doing similar things.
> I don't know this is good idea, or not.
> 
> ---------------
> diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
> index 81232f4..a147a03 100644
> --- a/sound/soc/soc-compress.c
> +++ b/sound/soc/soc-compress.c
> @@ -53,6 +53,7 @@ static int soc_compr_open(struct snd_compr_stream *cstream)
>  				platform->component.name);
>  			goto plat_err;
>  		}
> +		goto rtdcom_skip:
>  	}
>  
>  	for_each_rtdcom(rtd, rtdcom) {
> @@ -72,10 +73,13 @@ static int soc_compr_open(struct snd_compr_stream *cstream)
>  			       component->name);
>  			ret = __ret;
>  		}
> +		break;
>  	}
>  	if (ret < 0)
>  		goto machine_err;
>  
> +rtdcom_skip:
> +
>  	if (rtd->dai_link->compr_ops && rtd->dai_link->compr_ops->startup) {
>  		ret = rtd->dai_link->compr_ops->startup(cstream);
>  		if (ret < 0) {
> ---------------

Yes I had considered adding in breaks as an initial fix, however,
two things drove me in this direction.

Firstly, it didn't feel like it made sense to be calling
different compr_ops on different components. Not sure if anyone
feels there might be use-cases for that?

And what should happen if two components had the same
callback? Which do we call, should we call both as the current
code does, but then what to do with the results? In short I
felt there is significantly more work to be done to support
systems where we have multiple components providing compressed
functionality on a single runtime, so better to not look like we
support it at the moment.

Secondly it feels like a lot of code duplication having those
almost identical loops in every callback and this solution keeps
things much neater.

I will have a look through the soc-pcm stuff as well and have a
think if there are any issues there as well, although that does
all seem to work on my system.

Thanks,
Charles
