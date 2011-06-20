From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Fix DAPM sequence run for per-widget
	I/O methods
Date: Mon, 20 Jun 2011 06:33:53 +0100
Message-ID: <4DFEDBC1.9080806@ti.com>
References: <1308487790-13071-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 00FBE10381A
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 07:34:01 +0200 (CEST)
In-Reply-To: <1308487790-13071-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 19/06/11 13:49, Mark Brown wrote:
> Previously we were using the DAPM context rather than a widget as the
> argument for update_bits() so we didn't need to care that our list walk
> of widgets left us one beyond the end of the list. Now we're using them
> for the register update we need to make sure we're pointing at an actual
> widget not the list_head.
> 
> Fix originally suggested by Liam on IM.
> 

Thanks, was planning to send this yesterday but ended up being delayed at several airports yesterday.

> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-dapm.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index 605c225..ceb2ba4 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -918,6 +918,12 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
>  	}
>  
>  	if (reg >= 0) {
> +		/* Any widget will do, they should all be updating the
> +		 * same register.
> +		 */
> +		w = list_first_entry(pending, struct snd_soc_dapm_widget,
> +				     power_list);
> +
>  		pop_dbg(dapm->dev, card->pop_time,
>  			"pop test : Applying 0x%x/0x%x to %x in %dms\n",
>  			value, mask, reg, card->pop_time);

Acked-by: Liam Girdwood <lrg@ti.com>
