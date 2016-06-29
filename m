From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: [PATCH] ASoC: nau8825: jack connection decision
 with different insertion logic
Date: Tue, 28 Jun 2016 20:45:53 -0700
Message-ID: <CAOMFOmUhvWrm6ivTs4Ujp2_A8o81A12L0gPUDay0Bv9PVAkbug@mail.gmail.com>
References: <1467170438-5157-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f193.google.com (mail-ob0-f193.google.com
 [209.85.214.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E2952605D3
 for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2016 05:45:55 +0200 (CEST)
Received: by mail-ob0-f193.google.com with SMTP id s7so981940obo.1
 for <alsa-devel@alsa-project.org>; Tue, 28 Jun 2016 20:45:55 -0700 (PDT)
In-Reply-To: <1467170438-5157-1-git-send-email-KCHSU0@nuvoton.com>
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

On Tue, Jun 28, 2016 at 8:20 PM, John Hsu <KCHSU0@nuvoton.com> wrote:
> The original design only covers the jack insertion logic is active low.
> Add more condition to cover no matter the logic is active low and high.
>
> Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
> ---
>  sound/soc/codecs/nau8825.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
> index 3f30e6e..a2f0d03 100644
> --- a/sound/soc/codecs/nau8825.c
> +++ b/sound/soc/codecs/nau8825.c
> @@ -1345,10 +1345,18 @@ EXPORT_SYMBOL_GPL(nau8825_enable_jack_detect);
>
>  static bool nau8825_is_jack_inserted(struct regmap *regmap)
>  {
> -       int status;
> +       int status, jkdet, res;
>
>         regmap_read(regmap, NAU8825_REG_I2C_DEVICE_ID, &status);
> -       return !(status & NAU8825_GPIO2JD1);
> +       regmap_read(regmap, NAU8825_REG_JACK_DET_CTRL, &jkdet);
> +
> +       /* return jack connection status according to jack insertion logic
> +        * active high or active low.
> +        */
> +       res = !(status & NAU8825_GPIO2JD1) * !(jkdet & NAU8825_JACK_POLARITY) +
> +               (status & NAU8825_GPIO2JD1) * (jkdet & NAU8825_JACK_POLARITY);

It makes more sense to use a more boolean-like expression. Something like

      return !!(status & NAU8825_GPIO2JD1) == !!(jkdet & NAU8825_JACK_POLARITY);
(hope I translated expression above correctly)

or even better to introduce readable bool flags:
      bool active_high = !!(jkdet & NAU8825_JACK_POLARITY);
      bool is_high = !!(status & NAU8825_GPIO2JD1);
      return active_high == is_high;



> +
> +       return res ? true : false;
>  }
>
>  static void nau8825_restart_jack_detection(struct regmap *regmap)
> --
> 2.6.4
>
