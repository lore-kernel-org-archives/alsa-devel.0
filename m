From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 2/2] ALSA: compress: Reduce the scope for two variables
 in snd_compr_set_params()
Date: Sun, 21 Aug 2016 12:51:34 -0700
Message-ID: <1471809094.3746.17.camel@perches.com>
References: <566ABCD9.1060404@users.sourceforge.net>
         <7233eb00-a941-4935-dce2-7cb907272d41@users.sourceforge.net>
         <03eac1fe-ff33-1759-9c2a-7914f1c6de45@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <03eac1fe-ff33-1759-9c2a-7914f1c6de45@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: alsa-devel@alsa-project.org

On Sun, 2016-08-21 at 21:45 +0200, SF Markus Elfring wrote:
> Reduce the scope for the local variables to an if branch.
[]
> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
[]
> @@ -545,14 +545,14 @@ static int snd_compress_check_input(struct snd_compr_params *params)
>  static int
>  snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
>  {
> -	struct snd_compr_params *params;
> -	int retval;
> -
>  	if (stream->runtime->state == SNDRV_PCM_STATE_OPEN) {

Likely better not reducing variable scope but changing:

 	if (stream->runtime->state == SNDRV_PCM_STATE_OPEN)

to

	if (stream->runtime->state != SNDRV_PCM_STATE_OPEN)
		return -EPERM;

and unindenting the remainder of the code one level instead.
