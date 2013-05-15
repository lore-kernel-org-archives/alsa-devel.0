From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH 04/11] ASoC: spear: spdif_out: Staticize
	unexported function
Date: Wed, 15 May 2013 09:17:55 +0530
Message-ID: <5193056B.4050107@st.com>
References: <1368562797-10440-1-git-send-email-lars@metafoo.de>
 <1368562797-10440-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog115.obsmtp.com (eu1sys200aog115.obsmtp.com
 [207.126.144.139])
 by alsa0.perex.cz (Postfix) with ESMTP id AC1C9261096
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 05:48:02 +0200 (CEST)
In-Reply-To: <1368562797-10440-4-git-send-email-lars@metafoo.de>
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
> The spdif_soc_dai_probe function is only used in spdif_out.c, so make it static.
>
> Cc: Rajeev Kumar<rajeev-dlh.kumar@st.com>
> Signed-off-by: Lars-Peter Clausen<lars@metafoo.de>
> ---
>   sound/soc/spear/spdif_out.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/spear/spdif_out.c b/sound/soc/spear/spdif_out.c
> index fd25cc5..4bde512 100644
> --- a/sound/soc/spear/spdif_out.c
> +++ b/sound/soc/spear/spdif_out.c
> @@ -240,7 +240,7 @@ static const struct snd_kcontrol_new spdif_out_controls[] = {
>   			spdif_mute_get, spdif_mute_put),
>   };
>
> -int spdif_soc_dai_probe(struct snd_soc_dai *dai)
> +static int spdif_soc_dai_probe(struct snd_soc_dai *dai)
>   {
>   	struct spdif_out_dev *host = snd_soc_dai_get_drvdata(dai);
>

Acked-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
