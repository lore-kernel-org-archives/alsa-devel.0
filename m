From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [alsa-devel] [PATCH v3 2/4] ASoC: simple-card: dynamically allocate
 the DAI link and properties
Date: Mon, 17 Mar 2014 11:29:42 +0200
Message-ID: <5326C086.6080609@ti.com>
References: <cover.1394883134.git.moinejf@free.fr> <1cf50fea2306bcb05987533042dbf1495b2c6f07.1394883134.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1cf50fea2306bcb05987533042dbf1495b2c6f07.1394883134.git.moinejf@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, linux-kernel@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On 03/15/2014 01:09 PM, Jean-Francois Moine wrote:
> The DAI link array and the properties (fmt, sysclk slots) are
> hard-coded for a single CPU / CODEC link.
>
> This patch dynamically allocates the DAI link array and the
> properties with the aim of supporting many DAI links.
>
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>   sound/soc/generic/simple-card.c | 49 +++++++++++++++++++++++++----------------
>   1 file changed, 30 insertions(+), 19 deletions(-)
>
> diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
> index ca7e63e..a55dc46 100644
> --- a/sound/soc/generic/simple-card.c
> +++ b/sound/soc/generic/simple-card.c
> @@ -20,9 +20,11 @@
>
>   struct simple_card_data {
>   	struct snd_soc_card snd_card;
> -	struct asoc_simple_dai cpu_dai;
> -	struct asoc_simple_dai codec_dai;
> -	struct snd_soc_dai_link snd_link;
> +	struct simple_dais {
> +		struct asoc_simple_dai cpu_dai;
> +		struct asoc_simple_dai codec_dai;
> +	} *dais;
> +	struct snd_soc_dai_link dai_link[];	/* dynamically allocated */
>   };
>

This is only an implementation detail, but wouldn't it produce a cleaner 
implementation if you would write the above structure like this:

   struct simple_card_data {
   	struct snd_soc_card snd_card;
	struct simple_dai_links {
		struct snd_soc_dai_link dai_link;
		struct asoc_simple_dai cpu_dai;
		struct asoc_simple_dai codec_dai;
	} *dai_links;
   };

or even

   struct simple_card_data {
   	struct snd_soc_card snd_card;
	struct simple_dai_links {
		struct snd_soc_dai_link dai_link;
		struct asoc_simple_dai cpu_dai;
		struct asoc_simple_dai codec_dai;
	} dai_links[]; /* dynamically allocated */
   };

But, as said this only an implementation detail.

Best regards,
Jyri
