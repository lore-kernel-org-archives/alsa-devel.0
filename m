From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: + es1968-fix-jitter-on-some-maestro-cards.patch
 added to -mm tree
Date: Thu, 03 Apr 2008 22:37:26 +0200
Message-ID: <47F54006.1050907@keyaccess.nl>
References: <200804031854.m33Is3V1017135@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 45AC3103834
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Apr 2008 22:35:31 +0200 (CEST)
In-Reply-To: <200804031854.m33Is3V1017135@imap1.linux-foundation.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: akpm@linux-foundation.org
Cc: tiwai@suse.de, andreas@stapelspeicher.org, ALSA devel <alsa-devel@alsa-project.org>, mm-commits@vger.kernel.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On 03-04-08 20:54, akpm@linux-foundation.org wrote:

> The patch titled
>      es1968: fix jitter on some maestro cards
> has been added to the -mm tree.  Its filename is
>      es1968-fix-jitter-on-some-maestro-cards.patch

[ ... ]

> Subject: es1968: fix jitter on some maestro cards
> From: Andreas Mueller <andreas@stapelspeicher.org>
> 
> This patch suppresses jitter on several Maestro cards in stereo mode (ALSA of
> course).
> 
> The patch is also incorporated in the *BSD drivers where I "ported" it from. 
> 
> Without this patch most of the stereo audio gets out of sync and really
> distorted (oss-emulation with mplayer at 48000khz worked somehow).
> 
> Cc: Rene Herman <rene.herman@keyaccess.nl>
> Cc: Jaroslav Kysela <perex@suse.cz>
> Cc: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---

Tested-By: Rene Herman <rene.herman@gmail.com>

on a TerraTec DMX (ESS Canyon3D, ES1970MS-3D) which doesn't need this but 
doesn't seem to be suffering from it either. No idea about this otherwise.

>  sound/pci/es1968.c |   22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff -puN sound/pci/es1968.c~es1968-fix-jitter-on-some-maestro-cards sound/pci/es1968.c
> --- a/sound/pci/es1968.c~es1968-fix-jitter-on-some-maestro-cards
> +++ a/sound/pci/es1968.c
> @@ -1815,6 +1815,23 @@ snd_es1968_pcm(struct es1968 *chip, int 
>  
>  	return 0;
>  }
> +/*
> + * suppress jitter on some maestros when playing stereo
> + */
> +static void snd_es1968_suppress_jitter(struct es1968 *chip, struct esschan *es)
> +{
> +	unsigned int cp1;
> +	unsigned int cp2;
> +	unsigned int diff;
> +
> +	cp1 = __apu_get_register(chip, 0, 5);
> +	cp2 = __apu_get_register(chip, 1, 5);
> +	diff = (cp1 > cp2 ? cp1 - cp2 : cp2 - cp1);
> +
> +	if (diff > 1) {
> +		__maestro_write(chip, IDR0_DATA_PORT, cp1);
> +	}
> +}
>  
>  /*
>   * update pointer
> @@ -1936,8 +1953,11 @@ static irqreturn_t snd_es1968_interrupt(
>  		struct esschan *es;
>  		spin_lock(&chip->substream_lock);
>  		list_for_each_entry(es, &chip->substream_list, list) {
> -			if (es->running)
> +			if (es->running) {
>  				snd_es1968_update_pcm(chip, es);
> +				if (es->fmt & ESS_FMT_STEREO)
> +					snd_es1968_suppress_jitter(chip, es);
> +			}
>  		}
>  		spin_unlock(&chip->substream_lock);
>  		if (chip->in_measurement) {

Rene.
