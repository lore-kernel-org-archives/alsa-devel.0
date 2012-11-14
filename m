From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [patch] ALSA: es1968: precedence bug in snd_es1968_tea575x_get_pins()
Date: Wed, 14 Nov 2012 22:24:18 +0100
Message-ID: <201211142224.19938.linux@rainbow-software.org>
References: <20121113074454.GB13198@elgon.mountain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121113074454.GB13198@elgon.mountain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Mauro Carvalho Chehab <mchehab@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tuesday 13 November 2012 08:44:54 Dan Carpenter wrote:
> I don't think this works as intended.  '|' higher precedence than ?: so
> the bitwize OR "0 | (val & STR_MOST)" is a no-op.
>
> I have re-written it to be more clear.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> I don't have a way to test this.

Thanks for the patch. I tested it and it works.

The same way as without the patch...weird. DATA pin reading works because 
that's required for the chip detection. Stereo indication (MOST pin) works 
too.

>
> diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
> index 50169bc..7266020 100644
> --- a/sound/pci/es1968.c
> +++ b/sound/pci/es1968.c
> @@ -2581,9 +2581,14 @@ static u8 snd_es1968_tea575x_get_pins(struct
> snd_tea575x *tea) struct es1968 *chip = tea->private_data;
>  	unsigned long io = chip->io_port + GPIO_DATA;
>  	u16 val = inw(io);
> -
> -	return  (val & STR_DATA) ? TEA575X_DATA : 0 |
> -		(val & STR_MOST) ? TEA575X_MOST : 0;
> +	u8 ret;
> +
> +	ret = 0;
> +	if (val & STR_DATA)
> +		ret |= TEA575X_DATA;
> +	if (val & STR_MOST)
> +		ret |= TEA575X_MOST;
> +	return ret;
>  }
>
>  static void snd_es1968_tea575x_set_direction(struct snd_tea575x *tea, bool
> output) --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Ondrej Zary
