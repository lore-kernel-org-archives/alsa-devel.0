From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH] ASoC: sn95031: Fix the logic to find free
	channel
Date: Sat, 3 Sep 2011 17:14:06 +0100
Message-ID: <CABS+qY2oOCpusNzRngTWmmcHv=jAkv-3N2rWH=mA8G6CSfYc7g@mail.gmail.com>
References: <1315028507.2268.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog111.obsmtp.com (na3sys009aog111.obsmtp.com
	[74.125.149.205])
	by alsa0.perex.cz (Postfix) with ESMTP id D7A0824632
	for <alsa-devel@alsa-project.org>;
	Sat,  3 Sep 2011 18:14:07 +0200 (CEST)
Received: by mail-qw0-f44.google.com with SMTP id 2so2800705qwg.17
	for <alsa-devel@alsa-project.org>; Sat, 03 Sep 2011 09:14:06 -0700 (PDT)
In-Reply-To: <1315028507.2268.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Harsha Priya <priya.harsha@intel.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 3 September 2011 06:41, Axel Lin <axel.lin@gmail.com> wrote:

> In the case of no free channel available,
> current implementation returns 0 instead of negative errno.
>
> This patch fixes the logic to return -EINVAL if no free channel available.
>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/soc/codecs/sn95031.c |    8 +++-----
>  1 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
> index 84ffdeb..b4f1cb4 100644
> --- a/sound/soc/codecs/sn95031.c
> +++ b/sound/soc/codecs/sn95031.c
> @@ -79,7 +79,7 @@ static void configure_adc(struct snd_soc_codec
> *sn95031_codec, int val)
>  */
>  static int find_free_channel(struct snd_soc_codec *sn95031_codec)
>  {
> -       int ret = 0, i, value;
> +       int i, value;
>
>        /* check whether ADC is enabled */
>        value = snd_soc_read(sn95031_codec, SN95031_ADC1CNTL1);
> @@ -91,12 +91,10 @@ static int find_free_channel(struct snd_soc_codec
> *sn95031_codec)
>        for (i = 0; i < SN95031_ADC_CHANLS_MAX; i++) {
>                value = snd_soc_read(sn95031_codec,
>                                SN95031_ADC_CHNL_START_ADDR + i);
> -               if (value & SN95031_STOPBIT_MASK) {
> -                       ret = i;
> +               if (value & SN95031_STOPBIT_MASK)
>                        break;
> -               }
>        }
> -       return (ret > SN95031_ADC_LOOP_MAX) ? (-EINVAL) : ret;
> +       return (i == SN95031_ADC_CHANLS_MAX) ? (-EINVAL) : i;
>  }
>
>  /* Initialize the ADC for reading micbias values. Can sleep. */
> --
> 1.7.4.1
>
>
>
>
Acked-by: Liam Girdwood <lrg@ti.com>

Btw, this should be posted to alsa-devel.
