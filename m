From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH] ASoC: ad1980: Return proper error if
	vendor id mismatch
Date: Thu, 8 Sep 2011 22:14:20 +0100
Message-ID: <CABS+qY3qrk37kGvcaqw5OEuCuaijZBbXb_=0O_hQkc8Q0GGnUA@mail.gmail.com>
References: <1315276668.9619.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id B54BB24D5A
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Sep 2011 23:14:22 +0200 (CEST)
Received: by mail-qy0-f169.google.com with SMTP id 27so640513qyk.7
	for <alsa-devel@alsa-project.org>; Thu, 08 Sep 2011 14:14:21 -0700 (PDT)
In-Reply-To: <1315276668.9619.1.camel@phoenix>
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
Cc: Roy Huang <roy.huang@analog.com>, Cliff Cai <cliff.cai@analog.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6 September 2011 03:37, Axel Lin <axel.lin@gmail.com> wrote:

> Return -ENODEV instead of 0 if vendor id mismatch.
>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/soc/codecs/ad1980.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
> index 923b364..4c0fc30 100644
> --- a/sound/soc/codecs/ad1980.c
> +++ b/sound/soc/codecs/ad1980.c
> @@ -200,18 +200,22 @@ static int ad1980_soc_probe(struct snd_soc_codec
> *codec)
>        }
>
>        /* Read out vendor ID to make sure it is ad1980 */
> -       if (ac97_read(codec, AC97_VENDOR_ID1) != 0x4144)
> +       if (ac97_read(codec, AC97_VENDOR_ID1) != 0x4144) {
> +               ret = -ENODEV;
>                goto reset_err;
> +       }
>
>        vendor_id2 = ac97_read(codec, AC97_VENDOR_ID2);
>
>        if (vendor_id2 != 0x5370) {
> -               if (vendor_id2 != 0x5374)
> +               if (vendor_id2 != 0x5374) {
> +                       ret = -ENODEV;
>                        goto reset_err;
> -               else
> +               } else {
>                        printk(KERN_WARNING "ad1980: "
>                                "Found AD1981 - only 2/2 IN/OUT Channels "
>                                "supported\n");
> +               }
>        }
>
>        /* unmute captures and playbacks volume */
> --
> 1.7.4.1
>
>
>
>
Acked-by Liam Girdwood <lrg@ti.com>
