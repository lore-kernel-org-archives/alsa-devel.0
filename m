From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: bebob: constify snd_bebob_rate_spec
	structures
Date: Sun, 11 Oct 2015 00:36:44 +0900
Message-ID: <5619308C.7000601@sakamocchi.jp>
References: <1444484390-22158-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 3281E26046A
 for <alsa-devel@alsa-project.org>; Sat, 10 Oct 2015 17:36:58 +0200 (CEST)
In-Reply-To: <1444484390-22158-1-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <Julia.Lawall@lip6.fr>, Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Oct 10 2015 22:39, Julia Lawall wrote:
> The snd_bebob_rate_spec structure type contains only function pointers.  In
> all instances of this structure type, the functions are provided statically
> and are never changed subsequently.  Add a const annotation on all
> initializations and uses.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  sound/firewire/bebob/bebob.c           |    2 +-
>  sound/firewire/bebob/bebob.h           |    2 +-
>  sound/firewire/bebob/bebob_focusrite.c |    4 ++--
>  sound/firewire/bebob/bebob_maudio.c    |    4 ++--
>  sound/firewire/bebob/bebob_pcm.c       |    2 +-
>  sound/firewire/bebob/bebob_proc.c      |    2 +-
>  sound/firewire/bebob/bebob_stream.c    |    2 +-
>  sound/firewire/bebob/bebob_terratec.c  |    2 +-
>  sound/firewire/bebob/bebob_yamaha.c    |    2 +-
>  9 files changed, 11 insertions(+), 11 deletions(-)

Thanks. This patch, itself, is OK to me, while I wonder why this patch
doesn't change the other members like rate and meter.


Regards

Takashi Sakamoto

> diff --git a/sound/firewire/bebob/bebob_yamaha.c b/sound/firewire/bebob/bebob_yamaha.c
> index 5810170..2a9ffdb 100644
> --- a/sound/firewire/bebob/bebob_yamaha.c
> +++ b/sound/firewire/bebob/bebob_yamaha.c
> @@ -51,7 +51,7 @@ static struct snd_bebob_clock_spec clock_spec = {
>  	.types	= clk_src_types,
>  	.get	= &clk_src_get,
>  };
> -static struct snd_bebob_rate_spec rate_spec = {
> +static const struct snd_bebob_rate_spec rate_spec = {
>  	.get	= &snd_bebob_stream_get_rate,
>  	.set	= &snd_bebob_stream_set_rate,
>  };
> diff --git a/sound/firewire/bebob/bebob_focusrite.c b/sound/firewire/bebob/bebob_focusrite.c
> index a1a3949..e62923e 100644
> --- a/sound/firewire/bebob/bebob_focusrite.c
> +++ b/sound/firewire/bebob/bebob_focusrite.c
> @@ -260,7 +260,7 @@ saffire_meter_get(struct snd_bebob *bebob, u32 *buf, unsigned int size)
>  	return err;
>  }
>  
> -static struct snd_bebob_rate_spec saffirepro_both_rate_spec = {
> +static const struct snd_bebob_rate_spec saffirepro_both_rate_spec = {
>  	.get	= &saffirepro_both_clk_freq_get,
>  	.set	= &saffirepro_both_clk_freq_set,
>  };
> @@ -287,7 +287,7 @@ struct snd_bebob_spec saffirepro_10_spec = {
>  	.meter	= NULL
>  };
>  
> -static struct snd_bebob_rate_spec saffire_both_rate_spec = {
> +static const struct snd_bebob_rate_spec saffire_both_rate_spec = {
>  	.get	= &snd_bebob_stream_get_rate,
>  	.set	= &snd_bebob_stream_set_rate,
>  };
> diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
> index 0ed5e5f..091290d 100644
> --- a/sound/firewire/bebob/bebob.c
> +++ b/sound/firewire/bebob/bebob.c
> @@ -335,7 +335,7 @@ static void bebob_remove(struct fw_unit *unit)
>  	snd_card_free_when_closed(bebob->card);
>  }
>  
> -static struct snd_bebob_rate_spec normal_rate_spec = {
> +static const struct snd_bebob_rate_spec normal_rate_spec = {
>  	.get	= &snd_bebob_stream_get_rate,
>  	.set	= &snd_bebob_stream_set_rate
>  };
> diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
> index d3c9d8d..aff9da3 100644
> --- a/sound/firewire/bebob/bebob.h
> +++ b/sound/firewire/bebob/bebob.h
> @@ -71,7 +71,7 @@ struct snd_bebob_meter_spec {
>  };
>  struct snd_bebob_spec {
>  	struct snd_bebob_clock_spec *clock;
> -	struct snd_bebob_rate_spec *rate;
> +	const struct snd_bebob_rate_spec *rate;
>  	struct snd_bebob_meter_spec *meter;
>  };
>  
> diff --git a/sound/firewire/bebob/bebob_terratec.c b/sound/firewire/bebob/bebob_terratec.c
> index 9242e33..470d526 100644
> --- a/sound/firewire/bebob/bebob_terratec.c
> +++ b/sound/firewire/bebob/bebob_terratec.c
> @@ -55,7 +55,7 @@ phase24_series_clk_src_get(struct snd_bebob *bebob, unsigned int *id)
>  	return 0;
>  }
>  
> -static struct snd_bebob_rate_spec phase_series_rate_spec = {
> +static const struct snd_bebob_rate_spec phase_series_rate_spec = {
>  	.get	= &snd_bebob_stream_get_rate,
>  	.set	= &snd_bebob_stream_set_rate,
>  };
> diff --git a/sound/firewire/bebob/bebob_pcm.c b/sound/firewire/bebob/bebob_pcm.c
> index 2fdc1f1..ef224d6 100644
> --- a/sound/firewire/bebob/bebob_pcm.c
> +++ b/sound/firewire/bebob/bebob_pcm.c
> @@ -155,7 +155,7 @@ static int
>  pcm_open(struct snd_pcm_substream *substream)
>  {
>  	struct snd_bebob *bebob = substream->private_data;
> -	struct snd_bebob_rate_spec *spec = bebob->spec->rate;
> +	const struct snd_bebob_rate_spec *spec = bebob->spec->rate;
>  	unsigned int sampling_rate;
>  	enum snd_bebob_clock_type src;
>  	int err;
> diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
> index a2baa47..fc7a66d 100644
> --- a/sound/firewire/bebob/bebob_stream.c
> +++ b/sound/firewire/bebob/bebob_stream.c
> @@ -580,7 +580,7 @@ end:
>  
>  int snd_bebob_stream_start_duplex(struct snd_bebob *bebob, unsigned int rate)
>  {
> -	struct snd_bebob_rate_spec *rate_spec = bebob->spec->rate;
> +	const struct snd_bebob_rate_spec *rate_spec = bebob->spec->rate;
>  	struct amdtp_stream *master, *slave;
>  	enum cip_flags sync_mode;
>  	unsigned int curr_rate;
> diff --git a/sound/firewire/bebob/bebob_maudio.c b/sound/firewire/bebob/bebob_maudio.c
> index 057495d..dc9cd0c 100644
> --- a/sound/firewire/bebob/bebob_maudio.c
> +++ b/sound/firewire/bebob/bebob_maudio.c
> @@ -712,7 +712,7 @@ end:
>  }
>  
>  /* for special customized devices */
> -static struct snd_bebob_rate_spec special_rate_spec = {
> +static const struct snd_bebob_rate_spec special_rate_spec = {
>  	.get	= &special_get_rate,
>  	.set	= &special_set_rate,
>  };
> @@ -733,7 +733,7 @@ struct snd_bebob_spec maudio_special_spec = {
>  };
>  
>  /* Firewire 410 specification */
> -static struct snd_bebob_rate_spec usual_rate_spec = {
> +static const struct snd_bebob_rate_spec usual_rate_spec = {
>  	.get	= &snd_bebob_stream_get_rate,
>  	.set	= &snd_bebob_stream_set_rate,
>  };
> diff --git a/sound/firewire/bebob/bebob_proc.c b/sound/firewire/bebob/bebob_proc.c
> index 301cc6a..0f3b2ca 100644
> --- a/sound/firewire/bebob/bebob_proc.c
> +++ b/sound/firewire/bebob/bebob_proc.c
> @@ -138,7 +138,7 @@ proc_read_clock(struct snd_info_entry *entry,
>  		"SYT-Match",
>  	};
>  	struct snd_bebob *bebob = entry->private_data;
> -	struct snd_bebob_rate_spec *rate_spec = bebob->spec->rate;
> +	const struct snd_bebob_rate_spec *rate_spec = bebob->spec->rate;
>  	struct snd_bebob_clock_spec *clk_spec = bebob->spec->clock;
>  	enum snd_bebob_clock_type src;
>  	unsigned int rate;
