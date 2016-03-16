From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: [PATCH] ASoC: nau8825: support different clock
	source for FLL function
Date: Wed, 16 Mar 2016 16:06:35 -0700
Message-ID: <CAOMFOmXH-0cZ-VON3Ozttpaouuu+QWMTpdmB_fbELd+BhOUEaw@mail.gmail.com>
References: <1458014901-28049-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f181.google.com (mail-io0-f181.google.com
 [209.85.223.181])
 by alsa0.perex.cz (Postfix) with ESMTP id D79E22661BF
 for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2016 00:06:36 +0100 (CET)
Received: by mail-io0-f181.google.com with SMTP id n190so78372797iof.0
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 16:06:36 -0700 (PDT)
In-Reply-To: <1458014901-28049-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, YHCHuang@nuvoton.com, Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>, Mark Brown <broonie@kernel.org>, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, Yong Zhi <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi

On Mon, Mar 14, 2016 at 9:08 PM, John Hsu <KCHSU0@nuvoton.com> wrote:
> Extend FLL clock source selection. The source can be from MCLK, BCLK or FS.
>
> Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
> ---
>  sound/soc/codecs/nau8825.c | 82 +++++++++++++++++++++++++++++++++-------------
>  sound/soc/codecs/nau8825.h |  8 +++++
>  2 files changed, 67 insertions(+), 23 deletions(-)
>
> diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
> index 1c87299..ac264ec 100644
> --- a/sound/soc/codecs/nau8825.c
> +++ b/sound/soc/codecs/nau8825.c
> @@ -1053,6 +1053,37 @@ static int nau8825_set_pll(struct snd_soc_codec *codec, int pll_id, int source,
>         return 0;
>  }
>
> +static int nau8825_mclk_prepare(struct nau8825 *nau8825, unsigned int freq)
> +{
> +       int ret = 0;
> +
> +       nau8825->mclk = devm_clk_get(nau8825->dev, "mclk");
> +       if (IS_ERR(nau8825->mclk)) {

Is it possible that clock system is not ready at this point and the
method returns -EPROBE_DEFER? If so it matches IS_ERR() but not a real
error and the nua8825 driver should backoff and wait a little before
clocks are ready.

> +               dev_info(nau8825->dev, "No 'mclk' clock found, assume MCLK is managed externally");
> +               return 0;
> +       }
> +
> +       if (!nau8825->mclk_freq) {
> +               ret = clk_prepare_enable(nau8825->mclk);
> +               if (ret) {
> +                       dev_err(nau8825->dev, "Unable to prepare codec mclk\n");
> +                       return ret;
> +               }
> +       }
> +
