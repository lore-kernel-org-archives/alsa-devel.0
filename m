From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: damp: Reset dapm wcache after
 freeing damp widgets
Date: Tue, 10 Nov 2015 12:31:44 +0100
Message-ID: <5641D5A0.60606@metafoo.de>
References: <1447075826-641-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-188.synserver.de (smtp-out-220.synserver.de
 [212.40.185.220])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F7082625ED
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 12:31:47 +0100 (CET)
In-Reply-To: <1447075826-641-1-git-send-email-jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 11/09/2015 02:30 PM, Jyri Sarha wrote:
[...]
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index ff8bda4..d78db59 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -2286,6 +2286,9 @@ static void dapm_free_widgets(struct snd_soc_dapm_context *dapm)
>  			continue;
>  		snd_soc_dapm_free_widget(w);
>  	}
> +
> +	dapm->path_sink_cache.widget = NULL;
> +	dapm->path_source_cache.widget = NULL;
>  }

Looks good, but this is not the only place where we free widgets. Can you
add a helper function snd_soc_dapm_reset_cache() (or similar) and then call
this from dapm_free_widgets() as well as snd_soc_tplg_widget_remove_all().

- Lars
