From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] Uninitialized id returned by
	saffirepro_both_clk_src_get.
Date: Mon, 27 Oct 2014 21:55:48 +0900
Message-ID: <544E40D4.4090705@sakamocchi.jp>
References: <1414237241-18984-1-git-send-email-vogelchr@vogel.cx>
 <1414237241-18984-2-git-send-email-vogelchr@vogel.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 73574261171
 for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2014 13:55:56 +0100 (CET)
In-Reply-To: <1414237241-18984-2-git-send-email-vogelchr@vogel.cx>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "iwai >> Takashi Iwai" <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Christian Vogel <vogelchr@vogel.cx>
List-Id: alsa-devel@alsa-project.org

Iwai-san,

On Oct 25 2014 20:40, Christian Vogel wrote:
> snd_bebob_stream_check_internal_clock() may get an id from
> saffirepro_both_clk_src_get (via clk_src->get()) that was uninitialized.
> 
> a) make logic in saffirepro_both_clk_src_get explicit
> b) test if id used in snd_bebob_stream_check_internal_clock matches array size
> 
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Signed-off-by: Christian Vogel <vogelchr@vogel.cx>
> ---
>  sound/firewire/bebob/bebob_focusrite.c | 62 ++++++++++++++++++++++++++--------
>  sound/firewire/bebob/bebob_stream.c    | 18 ++++++++--
>  2 files changed, 63 insertions(+), 17 deletions(-)

[alsa-devel] [PATCH] Uninitialized id returned by
saffirepro_both_clk_src_get.
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-October/082810.html

Would you please apply this patch to 'for-linus' branch and C.C.ed to
Linux stable branch, as a bug fix?

The subject should be with a prefix 'ALSA: bebob: ', and I hope to add
'Reviewed-by' instead of 'Signed-off-by' for myself.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp

> diff --git a/sound/firewire/bebob/bebob_focusrite.c b/sound/firewire/bebob/bebob_focusrite.c
> index 45a0eed..7b18e84 100644
> --- a/sound/firewire/bebob/bebob_focusrite.c
> +++ b/sound/firewire/bebob/bebob_focusrite.c
> @@ -27,12 +27,14 @@
>  #define SAFFIRE_CLOCK_SOURCE_INTERNAL		0
>  #define SAFFIRE_CLOCK_SOURCE_SPDIF		1
>  
> -/* '1' is absent, why... */
> +/* clock sources as returned from register of Saffire Pro 10 and 26 */
>  #define SAFFIREPRO_CLOCK_SOURCE_INTERNAL	0
> +#define SAFFIREPRO_CLOCK_SOURCE_SKIP		1 /* never used on hardware */
>  #define SAFFIREPRO_CLOCK_SOURCE_SPDIF		2
> -#define SAFFIREPRO_CLOCK_SOURCE_ADAT1		3
> -#define SAFFIREPRO_CLOCK_SOURCE_ADAT2		4
> +#define SAFFIREPRO_CLOCK_SOURCE_ADAT1		3 /* not used on s.pro. 10 */
> +#define SAFFIREPRO_CLOCK_SOURCE_ADAT2		4 /* not used on s.pro. 10 */
>  #define SAFFIREPRO_CLOCK_SOURCE_WORDCLOCK	5
> +#define SAFFIREPRO_CLOCK_SOURCE_COUNT		6
>  
>  /* S/PDIF, ADAT1, ADAT2 is enabled or not. three quadlets */
>  #define SAFFIREPRO_ENABLE_DIG_IFACES		0x01a4
> @@ -101,13 +103,34 @@ saffire_write_quad(struct snd_bebob *bebob, u64 offset, u32 value)
>  				  &data, sizeof(__be32), 0);
>  }
>  
> +static char *const saffirepro_10_clk_src_labels[] = {
> +	SND_BEBOB_CLOCK_INTERNAL, "S/PDIF", "Word Clock"
> +};
>  static char *const saffirepro_26_clk_src_labels[] = {
>  	SND_BEBOB_CLOCK_INTERNAL, "S/PDIF", "ADAT1", "ADAT2", "Word Clock"
>  };
> -
> -static char *const saffirepro_10_clk_src_labels[] = {
> -	SND_BEBOB_CLOCK_INTERNAL, "S/PDIF", "Word Clock"
> +/* Value maps between registers and labels for SaffirePro 10/26. */
> +static const char saffirepro_clk_maps[][SAFFIREPRO_CLOCK_SOURCE_COUNT] = {
> +	/* SaffirePro 10 */
> +	[0] = {
> +		[SAFFIREPRO_CLOCK_SOURCE_INTERNAL]  =  0,
> +		[SAFFIREPRO_CLOCK_SOURCE_SKIP]      = -1, /* not supported */
> +		[SAFFIREPRO_CLOCK_SOURCE_SPDIF]     =  1,
> +		[SAFFIREPRO_CLOCK_SOURCE_ADAT1]     = -1, /* not supported */
> +		[SAFFIREPRO_CLOCK_SOURCE_ADAT2]     = -1, /* not supported */
> +		[SAFFIREPRO_CLOCK_SOURCE_WORDCLOCK] =  2,
> +	},
> +	/* SaffirePro 26 */
> +	[1] = {
> +		[SAFFIREPRO_CLOCK_SOURCE_INTERNAL]  =  0,
> +		[SAFFIREPRO_CLOCK_SOURCE_SKIP]      = -1, /* not supported */
> +		[SAFFIREPRO_CLOCK_SOURCE_SPDIF]     =  1,
> +		[SAFFIREPRO_CLOCK_SOURCE_ADAT1]     =  2,
> +		[SAFFIREPRO_CLOCK_SOURCE_ADAT2]     =  3,
> +		[SAFFIREPRO_CLOCK_SOURCE_WORDCLOCK] =  4,
> +	}
>  };
> +
>  static int
>  saffirepro_both_clk_freq_get(struct snd_bebob *bebob, unsigned int *rate)
>  {
> @@ -138,24 +161,35 @@ saffirepro_both_clk_freq_set(struct snd_bebob *bebob, unsigned int rate)
>  
>  	return saffire_write_quad(bebob, SAFFIREPRO_RATE_NOREBOOT, id);
>  }
> +
> +/*
> + * query hardware for current clock source, return our internally
> + * used clock index in *id, depending on hardware.
> + */
>  static int
>  saffirepro_both_clk_src_get(struct snd_bebob *bebob, unsigned int *id)
>  {
>  	int err;
> -	u32 value;
> +	u32 value;       /* clock source read from hw register */
> +	const char *map;
>  
>  	err = saffire_read_quad(bebob, SAFFIREPRO_OFFSET_CLOCK_SOURCE, &value);
>  	if (err < 0)
>  		goto end;
>  
> -	if (bebob->spec->clock->labels == saffirepro_10_clk_src_labels) {
> -		if (value == SAFFIREPRO_CLOCK_SOURCE_WORDCLOCK)
> -			*id = 2;
> -		else if (value == SAFFIREPRO_CLOCK_SOURCE_SPDIF)
> -			*id = 1;
> -	} else if (value > 1) {
> -		*id = value - 1;
> +	/* depending on hardware, use a different mapping */
> +	if (bebob->spec->clock->labels == saffirepro_10_clk_src_labels)
> +		map = saffirepro_clk_maps[0];
> +	else
> +		map = saffirepro_clk_maps[1];
> +
> +	/* In a case that this driver cannot handle the value of register. */
> +	if (value >= SAFFIREPRO_CLOCK_SOURCE_COUNT || map[value] < 0) {
> +		err = -EIO;
> +		goto end;
>  	}
> +
> +	*id = (unsigned int)map[value];
>  end:
>  	return err;
>  }
> diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
> index ef4d0c9..1aab0a3 100644
> --- a/sound/firewire/bebob/bebob_stream.c
> +++ b/sound/firewire/bebob/bebob_stream.c
> @@ -129,12 +129,24 @@ snd_bebob_stream_check_internal_clock(struct snd_bebob *bebob, bool *internal)
>  	/* 1.The device has its own operation to switch source of clock */
>  	if (clk_spec) {
>  		err = clk_spec->get(bebob, &id);
> -		if (err < 0)
> +		if (err < 0) {
>  			dev_err(&bebob->unit->device,
>  				"fail to get clock source: %d\n", err);
> -		else if (strncmp(clk_spec->labels[id], SND_BEBOB_CLOCK_INTERNAL,
> -				 strlen(SND_BEBOB_CLOCK_INTERNAL)) == 0)
> +			goto end;
> +		}
> +
> +		if (id >= clk_spec->num) {
> +			dev_err(&bebob->unit->device,
> +				"clock source %d out of range 0..%d\n",
> +				id, clk_spec->num - 1);
> +			err = -EIO;
> +			goto end;
> +		}
> +
> +		if (strncmp(clk_spec->labels[id], SND_BEBOB_CLOCK_INTERNAL,
> +			    strlen(SND_BEBOB_CLOCK_INTERNAL)) == 0)
>  			*internal = true;
> +
>  		goto end;
>  	}
>  
> 
