From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [PATCH] pcm: 2nd round of pcm_misc DSD fixes
Date: Fri, 15 Aug 2014 15:02:35 +0600
Message-ID: <53EDCCAB.3050206@gmail.com>
References: <1408085019-5277-1-git-send-email-gtmkramer@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f41.google.com (mail-la0-f41.google.com
 [209.85.215.41])
 by alsa0.perex.cz (Postfix) with ESMTP id C832E2656E4
 for <alsa-devel@alsa-project.org>; Fri, 15 Aug 2014 11:01:26 +0200 (CEST)
Received: by mail-la0-f41.google.com with SMTP id s18so2113437lam.14
 for <alsa-devel@alsa-project.org>; Fri, 15 Aug 2014 02:01:23 -0700 (PDT)
In-Reply-To: <1408085019-5277-1-git-send-email-gtmkramer@xs4all.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: gtmkramer@xs4all.nl
List-Id: alsa-devel@alsa-project.org

15.08.2014 12:43, Jurgen Kramer wrote:
> Functions 'snd_pcm_format_silence_64' and 'snd_pcm_format_size' also need to be
> able to handle the DSD formats.

0 is not a DSD silence value. It is the most negative value, similar to 
-32768 for S16 samples. We need something that will average to zero.

ffmpeg uses a repeating pattern of 0x69 here, with this comment:

         /* 0x69 = 01101001
          * This pattern "on repeat" makes a low energy 352.8 kHz tone
          * and a high energy 1.0584 MHz tone which should be filtered
          * out completely by any playback system --> silence
          */

https://ffmpeg.org/pipermail/ffmpeg-cvslog/2014-April/076427.html

>
> Signed-off-by: Jurgen Kramer <gtmkramer@xs4all.nl>
> ---
>   src/pcm/pcm_misc.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/src/pcm/pcm_misc.c b/src/pcm/pcm_misc.c
> index 24d52f9..c52e7bf 100644
> --- a/src/pcm/pcm_misc.c
> +++ b/src/pcm/pcm_misc.c
> @@ -317,11 +317,13 @@ ssize_t snd_pcm_format_size(snd_pcm_format_t format, size_t samples)
>   	switch (format) {
>   	case SNDRV_PCM_FORMAT_S8:
>   	case SNDRV_PCM_FORMAT_U8:
> +	case SNDRV_PCM_FORMAT_DSD_U8:
>   		return samples;
>   	case SNDRV_PCM_FORMAT_S16_LE:
>   	case SNDRV_PCM_FORMAT_S16_BE:
>   	case SNDRV_PCM_FORMAT_U16_LE:
>   	case SNDRV_PCM_FORMAT_U16_BE:
> +	case SNDRV_PCM_FORMAT_DSD_U16_LE:
>   		return samples * 2;
>   	case SNDRV_PCM_FORMAT_S18_3LE:
>   	case SNDRV_PCM_FORMAT_S18_3BE:
> @@ -387,6 +389,8 @@ u_int64_t snd_pcm_format_silence_64(snd_pcm_format_t format)
>   	case SNDRV_PCM_FORMAT_S20_3BE:
>   	case SNDRV_PCM_FORMAT_S18_3LE:
>   	case SNDRV_PCM_FORMAT_S18_3BE:
> +	case SNDRV_PCM_FORMAT_DSD_U8:
> +	case SNDRV_PCM_FORMAT_DSD_U16_LE:
>   		return 0;
>   	case SNDRV_PCM_FORMAT_U8:
>   		return 0x8080808080808080ULL;
>


-- 
Alexander E. Patrakov
