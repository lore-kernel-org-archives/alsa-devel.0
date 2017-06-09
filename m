From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 6/7] ASoC: mediatek: Constify hw_constraints
Date: Fri, 9 Jun 2017 09:39:07 +0200
Message-ID: <c9433149-34b5-b5e3-68d3-fde35bc8f18b@gmail.com>
References: <20170608213725.5378-1-tiwai@suse.de>
 <20170608213725.5378-7-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id A7B54266CB8
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 09:39:09 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id d17so5622197wme.3
 for <alsa-devel@alsa-project.org>; Fri, 09 Jun 2017 00:39:09 -0700 (PDT)
In-Reply-To: <20170608213725.5378-7-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Brian Austin <brian.austin@cirrus.com>, Krzysztof Kozlowski <krzk@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org



On 08/06/17 23:37, Takashi Iwai wrote:
> snd_pcm_hw_constraint_list(), *_ratnums() and *_ratdens() receive the
> const pointers.  Constify the corresponding static objects for better
> hardening.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/soc/mediatek/mt2701/mt2701-cs42448.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/mediatek/mt2701/mt2701-cs42448.c b/sound/soc/mediatek/mt2701/mt2701-cs42448.c
> index aa5b31b121e3..70f61d53fe05 100644
> --- a/sound/soc/mediatek/mt2701/mt2701-cs42448.c
> +++ b/sound/soc/mediatek/mt2701/mt2701-cs42448.c
> @@ -107,7 +107,7 @@ static const struct snd_kcontrol_new mt2701_cs42448_controls[] = {
>   
>   static const unsigned int mt2701_cs42448_sampling_rates[] = {48000};
>   
> -static struct snd_pcm_hw_constraint_list mt2701_cs42448_constraints_rates = {
> +static const struct snd_pcm_hw_constraint_list mt2701_cs42448_constraints_rates = {
>   		.count = ARRAY_SIZE(mt2701_cs42448_sampling_rates),
>   		.list = mt2701_cs42448_sampling_rates,
>   		.mask = 0,
> 

Acked-By: Matthias Brugger <matthias.bgg@gmail.com>
