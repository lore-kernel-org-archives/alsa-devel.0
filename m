From: Joe Perches <joe@perches.com>
Subject: Re: [patch] ALSA: es1968: precedence bug in
 snd_es1968_tea575x_get_pins()
Date: Tue, 13 Nov 2012 00:03:10 -0800
Message-ID: <1352793790.24230.18.camel@joe-AO722>
References: <20121113074454.GB13198@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121113074454.GB13198@elgon.mountain>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Mauro Carvalho Chehab <mchehab@redhat.com>, Ondrej Zary <linux@rainbow-software.org>, Hans de Goede <hdegoede@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2012-11-13 at 10:44 +0300, Dan Carpenter wrote:
> I don't think this works as intended.  '|' higher precedence than ?: so
> the bitwize OR "0 | (val & STR_MOST)" is a no-op.
> 
> I have re-written it to be more clear.
[]
> diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
[]
> @@ -2581,9 +2581,14 @@ static u8 snd_es1968_tea575x_get_pins(struct snd_tea575x *tea)
>  	struct es1968 *chip = tea->private_data;
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

Cute.  smatch I presume?  Tools are useful.

Moving the close parentheses is a pretty common style too

	return  (val & STR_DATA ? TEA575X_DATA : 0) |
		(val & STR_MOST ? TEA575X_MOST : 0);
