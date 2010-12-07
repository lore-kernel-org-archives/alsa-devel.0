From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH] ALSA: hda - Reset sample sizes and
 max	bitrates when reading ELD
Date: Tue, 07 Dec 2010 22:21:57 +0200
Message-ID: <4CFE9765.40108@iki.fi>
References: <1291749563-6942-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from saarni.dnainternet.net (saarni.dnainternet.net [83.102.40.136])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C00B103A26
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 21:22:01 +0100 (CET)
In-Reply-To: <1291749563-6942-1-git-send-email-anssi.hannula@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 07.12.2010 21:19, Anssi Hannula wrote:
> When a new HDMI/DP device is plugged in, hdmi_update_short_audio_desc()
> is called for every SAD (Short Audio Descriptor) in the ELD data. For
> LPCM coding type SAD defines the supported sample sizes. For several
> other coding types (such as AC-3), a maximum bitrate is defined.
> 
> The maximum bitrate and sample size fields are not always cleared.
> Therefore, if a device is unplugged and a different one is plugged in,
> and the coding types of some SAD positions differ between the devices,
> the old max_bitrate or sample_bits values will persist if the new SADs
> do not define those values.
> 
> The leftover max_bitrate and sample_bits do not cause any issues other
> than wrongly showing up in eld#X.Y procfs file and kernel log.

Actually, only max_bitrate will be shown there, the coding type seems to
be checked for LPCM before outputting sample_bits into eld#X.Y or log.

It is still probably better to clear that value as well, though.

> Fix that by always clearing sample_bits and max_bitrate when reading
> SADs.
> 
> Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
> ---
>  sound/pci/hda/hda_eld.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
> index 009031f..4a66347 100644
> --- a/sound/pci/hda/hda_eld.c
> +++ b/sound/pci/hda/hda_eld.c
> @@ -189,6 +189,9 @@ static void hdmi_update_short_audio_desc(struct cea_sad *a,
>  	a->channels = GRAB_BITS(buf, 0, 0, 3);
>  	a->channels++;
>  
> +	a->sample_bits = 0;
> +	a->max_bitrate = 0;
> +
>  	a->format = GRAB_BITS(buf, 0, 3, 4);
>  	switch (a->format) {
>  	case AUDIO_CODING_TYPE_REF_STREAM_HEADER:
> @@ -198,7 +201,6 @@ static void hdmi_update_short_audio_desc(struct cea_sad *a,
>  
>  	case AUDIO_CODING_TYPE_LPCM:
>  		val = GRAB_BITS(buf, 2, 0, 3);
> -		a->sample_bits = 0;
>  		for (i = 0; i < 3; i++)
>  			if (val & (1 << i))
>  				a->sample_bits |= cea_sample_sizes[i + 1];


-- 
Anssi Hannula
