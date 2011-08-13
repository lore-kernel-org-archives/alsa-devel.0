From: Daniel =?iso-8859-1?Q?Gl=F6ckner?= <daniel-gl@gmx.net>
Subject: Re: [PATCH] ASoC: s6000-pcm: remove unused variable 'dai'
Date: Sat, 13 Aug 2011 11:44:40 +0200
Message-ID: <20110813094440.GA28577@minime.bse>
References: <1313206376.29596.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1313206376.29596.2.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 13, 2011 at 11:32:56AM +0800, Axel Lin wrote:
>  static int s6000_pcm_new(struct snd_soc_pcm_runtime *runtime)
>  {
>  	struct snd_card *card =3D runtime->card->snd_card;
> -	struct snd_soc_dai *dai =3D runtime->cpu_dai;
>  	struct snd_pcm *pcm =3D runtime->pcm;
>  	struct s6000_pcm_dma_params *params;
>  	int res;

Acked-by: Daniel Gl=F6ckner <dg@emlix.com>
