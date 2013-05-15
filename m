From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH 03/11] ASoC: spear: spdif_in: Staticize non
	exported struct
Date: Wed, 15 May 2013 09:18:11 +0530
Message-ID: <5193057B.7030501@st.com>
References: <1368562797-10440-1-git-send-email-lars@metafoo.de>
 <1368562797-10440-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog106.obsmtp.com (eu1sys200aog106.obsmtp.com
 [207.126.144.121])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CB07261096
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 05:48:15 +0200 (CEST)
In-Reply-To: <1368562797-10440-3-git-send-email-lars@metafoo.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 5/15/2013 1:49 AM, Lars-Peter Clausen wrote:
> The spdif_in_dai struct is not used outside of spdif_in.c, so make it static.
>
> Cc: Rajeev Kumar<rajeev-dlh.kumar@st.com>
> Signed-off-by: Lars-Peter Clausen<lars@metafoo.de>
> ---
>   sound/soc/spear/spdif_in.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/spear/spdif_in.c b/sound/soc/spear/spdif_in.c
> index 643ada6..f0071dd 100644
> --- a/sound/soc/spear/spdif_in.c
> +++ b/sound/soc/spear/spdif_in.c
> @@ -152,7 +152,7 @@ static struct snd_soc_dai_ops spdif_in_dai_ops = {
>   	.hw_params	= spdif_in_hw_params,
>   };
>
> -struct snd_soc_dai_driver spdif_in_dai = {
> +static struct snd_soc_dai_driver spdif_in_dai = {
>   	.probe = spdif_in_dai_probe,
>   	.capture = {
>   		.channels_min = 2,

Acked-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
