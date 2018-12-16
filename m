From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/1] ALSA: virtuoso: add de-emphasis control
Date: Sun, 16 Dec 2018 17:37:45 +0100
Message-ID: <6b7d5f70-5e5a-59b4-9daf-315937a49639@ladisch.de>
References: <5c151073.1c69fb81.8fd52.ea81@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.184])
 by alsa0.perex.cz (Postfix) with ESMTP id E557C2677E4
 for <alsa-devel@alsa-project.org>; Sun, 16 Dec 2018 17:38:10 +0100 (CET)
In-Reply-To: <5c151073.1c69fb81.8fd52.ea81@mx.google.com>
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
To: tom.ty89@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

tom.ty89@gmail.com wrote:
> +	switch (data->current_rate) {
> +	case 32000:
> +	case 64000:
> +		reg |= PCM1796_DMF_32;
> +		break;
> +	case 44100:
> +	case 88200:
> +	case 176400:
> +		reg |= PCM1796_DMF_441;
> +		break;
> +	case 48000:
> +	case 96000:
> +	case 192000:
> +		reg |= PCM1796_DMF_48;
> +		break;

The DAC does not have filters for frequencies higher than 48 kHz.

> +static const struct snd_kcontrol_new deemph_control = {
> +	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> +	.name = "De-emphasis Switch",

This should be called "De-emphasis Playback Switch".
(But I see that other drivers are quite inconsistent about this.)


Regards,
Clemens
