From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: [PATCH] US-122L Driver, v0
Date: Thu, 08 Nov 2007 08:24:49 +0100
Message-ID: <1194506689.14959.1220188671@webmail.messagingengine.com>
References: <200711071641.28551.fzu@wemgehoertderstaat.de>
	<200711071955.16686.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 23A9E247D4
	for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2007 08:24:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200711071955.16686.fzu@wemgehoertderstaat.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Karsten Wiese <fzu@wemgehoertderstaat.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Karsten Wiese wrote:
> attached patches implement a simple driver for the tascam us-122l.

>  	QUIRK_AUDIO_EDIROL_UA700_UA25,
>  	QUIRK_AUDIO_EDIROL_UA1000,
>  	QUIRK_AUDIO_EDIROL_UA101,
> -
> +	QUIRK_MIDI_US122L,
>  	QUIRK_TYPE_COUNT
>  };
 
Why not put it together with the other QUIRK_MIDI_ symbols?

>  		break;
> +	case QUIRK_MIDI_US122L:
> +		umidi->usb_protocol_ops = &snd_usbmidi_122l_ops;
>  	case QUIRK_MIDI_FIXED_ENDPOINT:
>  		memcpy(&endpoints[0], quirk->data,
>  		       sizeof(struct snd_usb_midi_endpoint_info));

Aaargh!  If you really want to do it this way, at least add a
"/* fall through */" so that it's obvious that this is not a mistake.


Regards,
Clemens
