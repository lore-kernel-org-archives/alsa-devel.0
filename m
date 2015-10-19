From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [patch v2] ALSA: firewire-tascam: off by one in identify_model()
Date: Mon, 19 Oct 2015 20:54:08 +0900
Message-ID: <5624D9E0.40602@sakamocchi.jp>
References: <20151019112927.GA31691@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20151019112927.GA31691@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Clemens Ladisch <clemens@ladisch.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Oct 19 2015 20:29, Dan Carpenter wrote:
> Let's leave space for the NUL char otherwise the static checkers
> complain that we go beyond the end of the array.
> 
> Fixes: 53b3ffee7885 ('ALSA: firewire-tascam: change device probing processing') 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


Thank you to fix it.

Takashi Sakamoto

> ---
> v2: I truncated the last char in v1 instead of making the buffer larger
> 
> diff --git a/sound/firewire/tascam/tascam.c b/sound/firewire/tascam/tascam.c
> index c6747a4..79cb9e9 100644
> --- a/sound/firewire/tascam/tascam.c
> +++ b/sound/firewire/tascam/tascam.c
> @@ -40,7 +40,7 @@ static int identify_model(struct snd_tscm *tscm)
>  {
>  	struct fw_device *fw_dev = fw_parent_device(tscm->unit);
>  	const u32 *config_rom = fw_dev->config_rom;
> -	char model[8];
> +	char model[9];
>  	unsigned int i;
>  	u8 c;
>  
> 

