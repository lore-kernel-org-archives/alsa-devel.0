From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [alsa-lib][PATCH 2/4] pcm: add and describe
 SND_PCM_FORMAT_{S, U}20
Date: Tue, 5 Dec 2017 20:02:14 +0900
Message-ID: <dfb62521-bf3b-04c0-e6ca-56ab0dafb997@sakamocchi.jp>
References: <0f990d18-d21b-d5c6-b7e2-2e353223c2ef@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id E3105266A74
 for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2017 12:02:19 +0100 (CET)
In-Reply-To: <0f990d18-d21b-d5c6-b7e2-2e353223c2ef@maciej.szmigiero.name>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I found some nitpickings for this patch.

On Nov 30 2017 07:16, Maciej S. Szmigiero wrote:
> This patch adds and describes in various functions that query format
> properties SND_PCM_FORMAT_{S,U}20 formats that were recently added to the
> kernel as SNDRV_PCM_FORMAT_{S,U}20.
> 
> These formats are similar to existing 20-bit PCM formats
> SND_PCM_FORMAT_{S,U}20_3, however they occupy 4 bytes instead of 3.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
>   include/pcm.h       | 20 ++++++++++++++++++--
>   src/pcm/pcm.c       | 10 ++++++++++
>   src/pcm/pcm_local.h |  4 ++++
>   src/pcm/pcm_misc.c  | 41 ++++++++++++++++++++++++++++++++++++++---
>   4 files changed, 70 insertions(+), 5 deletions(-)
> 
> diff --git a/include/pcm.h b/include/pcm.h
> index e05777a7c221..5939c1dab37d 100644
> --- a/include/pcm.h
> +++ b/include/pcm.h
>
> ...
>
> @@ -239,7 +247,11 @@ typedef enum _snd_pcm_format {
>   	/** Float 64 bit CPU endian */
>   	SND_PCM_FORMAT_FLOAT64 = SND_PCM_FORMAT_FLOAT64_LE,
>   	/** IEC-958 CPU Endian */
> -	SND_PCM_FORMAT_IEC958_SUBFRAME = SND_PCM_FORMAT_IEC958_SUBFRAME_LE
> +	SND_PCM_FORMAT_IEC958_SUBFRAME = SND_PCM_FORMAT_IEC958_SUBFRAME_LE,
> +	/** Signed 20bit in 4bytes format, LSB justified, CPU Endian */
> +	SND_PCM_FORMAT_S20 = SND_PCM_FORMAT_S20_LE,
> +	/** Unsigned 20bit in 4bytes format, LSB justified, CPU Endian */
> +	SND_PCM_FORMAT_U20 = SND_PCM_FORMAT_U20_LE

A comma in the end of the last entry will help us to keep line-diffs
readable when new PCM formats will be added for future.

>   #elif __BYTE_ORDER == __BIG_ENDIAN
>   	/** Signed 16 bit CPU endian */
>   	SND_PCM_FORMAT_S16 = SND_PCM_FORMAT_S16_BE,
> @@ -258,7 +270,11 @@ typedef enum _snd_pcm_format {
>   	/** Float 64 bit CPU endian */
>   	SND_PCM_FORMAT_FLOAT64 = SND_PCM_FORMAT_FLOAT64_BE,
>   	/** IEC-958 CPU Endian */
> -	SND_PCM_FORMAT_IEC958_SUBFRAME = SND_PCM_FORMAT_IEC958_SUBFRAME_BE
> +	SND_PCM_FORMAT_IEC958_SUBFRAME = SND_PCM_FORMAT_IEC958_SUBFRAME_BE,
> +	/** Signed 20bit in 4bytes format, LSB justified, CPU Endian */
> +	SND_PCM_FORMAT_S20 = SND_PCM_FORMAT_S20_BE,
> +	/** Unsigned 20bit in 4bytes format, LSB justified, CPU Endian */
> +	SND_PCM_FORMAT_U20 = SND_PCM_FORMAT_U20_BE

Ditto.

>   #else
>   #error "Unknown endian"
>   #endif

I'm waiting for your next version ;)


Thanks

Takashi Sakamoto
