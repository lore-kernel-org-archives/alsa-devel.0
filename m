From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [PATCH v2 1/2] ALSA: usb-audio: more tolerant
        packetsize
Date: Tue, 6 Dec 2016 13:11:13 +0100
Message-ID: <8ec36827-450e-ff5a-5183-75b31ec95dc3@ladisch.de>
References: <20161206054615.29187-1-jiada_wang@mentor.com>
        <20161206054615.29187-2-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161206054615.29187-2-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.com
Cc: Jiada Wang <jiada_wang@mentor.com>, perex@perex.cz, o-takashi@sakamocchi.jp, alsa-devel@alsa-project.org, apape@de.adit-jv.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Jiada Wang wrote:
> since commit 57e6dae1087b ("ALSA: usb-audio: do not trust too-big
> wMaxPacketSize values"), the expected packetsize is always limited
> to nominal + 25%. It was discovered, that some devices

Android audio accessory

> have a much
> higher jitter in used packetsizes than 25% which would result in BABBLE
> condition and dropping of packets.
> A better solution is so assume the jitter to be the nominal packetsize:
> -one nearly empty packet followed by a almost 150% sized one.
>
> V2: changed to assume max frequency is +50 of nominal packetsize.
>
> Signed-off-by: Andreas Pape <apape@de.adit-jv.com>
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>

Acked-by: Clemens Ladisch <clemens@ladisch.de>

> --- a/sound/usb/endpoint.c
> +++ b/sound/usb/endpoint.c
> @@ -632,8 +632,8 @@ static int data_ep_set_params(struct snd_usb_endpoint *ep,
>  	ep->stride = frame_bits >> 3;
>  	ep->silence_value = pcm_format == SNDRV_PCM_FORMAT_U8 ? 0x80 : 0;
>
> -	/* assume max. frequency is 25% higher than nominal */
> -	ep->freqmax = ep->freqn + (ep->freqn >> 2);
> +	/* assume max. frequency is 50% higher than nominal */
> +	ep->freqmax = ep->freqn + (ep->freqn >> 1);
>  	/* Round up freqmax to nearest integer in order to calculate maximum
>  	 * packet size, which must represent a whole number of frames.
>  	 * This is accomplished by adding 0x0.ffff before converting the
