From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: pcm: Introduce protocol version
 field to sw_params
Date: Thu, 17 Jul 2014 21:48:02 +0200
Message-ID: <53C82872.3040101@perex.cz>
References: <1405526041-18437-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 487A126507D
 for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2014 21:48:20 +0200 (CEST)
In-Reply-To: <1405526041-18437-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Date 16.7.2014 17:54, Takashi Iwai wrote:
> For controlling the new fields more strictly, add sw_params.proto
> field indicating the protocol version of the user-space.  User-space
> should fill the SNDRV_PCM_VERSION value it's built with, then kernel
> can know whether the new fields should be evaluated or not.
> 
> And now tstamp_type field is evaluated only when the valid value is
> set there.  This avoids the wrong override of tstamp_type to zero,
> which is SNDRV_PCM_TSTAMP_TYPE_GETTIMEOFDAY.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  include/uapi/sound/asound.h | 4 ++--
>  sound/core/pcm_native.c     | 6 ++++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
> index a7e062f91f39..c9fd199b9330 100644
> --- a/include/uapi/sound/asound.h
> +++ b/include/uapi/sound/asound.h
> @@ -391,8 +391,8 @@ struct snd_pcm_sw_params {
>  	snd_pcm_uframes_t silence_threshold;	/* min distance from noise for silence filling */
>  	snd_pcm_uframes_t silence_size;		/* silence block size */
>  	snd_pcm_uframes_t boundary;		/* pointers wrap point */
> -	unsigned int tstamp_type;		/* timestamp type */
> -	int pads;				/* alignment, reserved */
> +	unsigned int tstamp_type;		/* timestamp type (req. proto >= 2.0.12) */
> +	unsigned int proto;			/* protocol version */

I would switch the positions of tstamp_type and proto... It seems
logical that all new member added after proto are dependent on this value.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
