From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: soc-dapm: Fix breakage with
	incorrect codec pointer
Date: Fri, 17 Jun 2011 16:50:02 +0100
Message-ID: <4DFB77AA.8060803@ti.com>
References: <1308322347-13512-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 05DF5245ED
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jun 2011 17:50:09 +0200 (CEST)
In-Reply-To: <1308322347-13512-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 17/06/11 15:52, Dimitris Papastamos wrote:
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-dapm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index 605c225..a877dc6 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -922,7 +922,7 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
>  			"pop test : Applying 0x%x/0x%x to %x in %dms\n",
>  			value, mask, reg, card->pop_time);
>  		pop_wait(card->pop_time);
> -		soc_widget_update_bits(w, reg, mask, value);
> +		snd_soc_update_bits(dapm->codec, reg, mask, value);
>  	}
>  
>  	list_for_each_entry(w, pending, power_list) {

Acked-by: Liam Girdwood <lrg@ti.com>
