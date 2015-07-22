From: Zeng Zhaoming <zengzm.kernel@gmail.com>
Subject: Re: [PATCH RFT] ASoC: sgtl5000: Fix up define for
	SGTL5000_SMALL_POP
Date: Wed, 22 Jul 2015 18:15:48 +0800
Message-ID: <CAN9UC2FPzvVXz8w5haDB2RKh9Eo7hXvYv=zh_PWb3vfSi4gGCA@mail.gmail.com>
References: <1437535665.17780.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f193.google.com (mail-pd0-f193.google.com
 [209.85.192.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B0C632606A7
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2015 12:15:49 +0200 (CEST)
Received: by pdav4 with SMTP id v4so15683052pda.1
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2015 03:15:48 -0700 (PDT)
In-Reply-To: <1437535665.17780.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Filip Brozovic <fbrozovic@gmail.com>, Alexander Stein <alexander.stein@systec-electronic.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 22, 2015 at 11:27 AM, Axel Lin <axel.lin@ingics.com> wrote:
> Currently, below code actually does not update any bit because
> SGTL5000_SMALL_POP is 0.
>
> snd_soc_update_bits(codec, SGTL5000_CHIP_REF_CTRL, SGTL5000_SMALL_POP, 1);
>
> The SGTL5000_SMALL_POP should be BIT(0) rather than 0, fix it.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> Hi,
> I don't have h/w and datasheet, but the code looks obvious does not make
> sense. Can someone help to confirm and test if this patch?
> Thanks,
> Axel
>  sound/soc/codecs/sgtl5000.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/sgtl5000.h b/sound/soc/codecs/sgtl5000.h
> index bd7a344..1c317de 100644
> --- a/sound/soc/codecs/sgtl5000.h
> +++ b/sound/soc/codecs/sgtl5000.h
> @@ -275,7 +275,7 @@
>  #define SGTL5000_BIAS_CTRL_MASK                        0x000e
>  #define SGTL5000_BIAS_CTRL_SHIFT               1
>  #define SGTL5000_BIAS_CTRL_WIDTH               3
> -#define SGTL5000_SMALL_POP                     0
> +#define SGTL5000_SMALL_POP                     1
>
>  /*
>   * SGTL5000_CHIP_MIC_CTRL
> --
> 2.1.0
>
>
>

Thanks for your report, seems your are right. I have no board to test it.

The code introduced by c251ea7bd7a04f1f2575467e0de76e803cf59149.
Fabio, can you verify it on mx28evk?

Thanks

-- 
Best Regards
    Zeng Zhaoming
