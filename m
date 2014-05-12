From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 5/5] ASoC: dapm:
	Simplify	snd_soc_dapm_link_dai_widgets()
Date: Mon, 12 May 2014 15:37:43 +0100
Message-ID: <20140512143743.GI25203@opensource.wolfsonmicro.com>
References: <1399472428-11034-1-git-send-email-lars@metafoo.de>
 <1399472428-11034-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 03EC3265050
 for <alsa-devel@alsa-project.org>; Mon, 12 May 2014 16:37:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1399472428-11034-5-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Songhee Baek <sbaek@nvidia.com>, Arun Shamanna Lakshmi <aruns@nvidia.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 07, 2014 at 04:20:28PM +0200, Lars-Peter Clausen wrote:
> If we find a widget who's stream name matches the name of a DAI widget then
> thats the one it should be connected to. Based on the widget id we can say in
> which direction the path should be. No need to go back to the DAI and check the
> stream names.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  sound/soc/soc-dapm.c | 27 +++++++++------------------
>  1 file changed, 9 insertions(+), 18 deletions(-)
> 
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index d7958f4..bed17a3 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -3334,6 +3334,7 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
>  int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
>  {
>  	struct snd_soc_dapm_widget *dai_w, *w;
> +	struct snd_soc_dapm_widget *src, *sink;
>  	struct snd_soc_dai *dai;

I think you have removed all the uses of this variable (dai) so you can
remove this as well.

Thanks,
Charles
