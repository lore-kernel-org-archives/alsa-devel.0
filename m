From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: Re: [PATCH] US-122L Driver, v0
Date: Thu, 8 Nov 2007 13:37:05 +0100
Message-ID: <200711081337.05417.fzu@wemgehoertderstaat.de>
References: <200711071641.28551.fzu@wemgehoertderstaat.de>
	<200711071955.16686.fzu@wemgehoertderstaat.de>
	<1194506689.14959.1220188671@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout2.freenet.de (mout2.freenet.de [195.4.92.92])
	by alsa0.perex.cz (Postfix) with ESMTP id B3B0C248A6
	for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2007 13:37:08 +0100 (CET)
In-Reply-To: <1194506689.14959.1220188671@webmail.messagingengine.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am Donnerstag, 8. November 2007 schrieb Clemens Ladisch:
>  
> Why not put it together with the other QUIRK_MIDI_ symbols?
> 
> >  		break;
> > +	case QUIRK_MIDI_US122L:
> > +		umidi->usb_protocol_ops = &snd_usbmidi_122l_ops;
> >  	case QUIRK_MIDI_FIXED_ENDPOINT:
> >  		memcpy(&endpoints[0], quirk->data,
> >  		       sizeof(struct snd_usb_midi_endpoint_info));
> 
> Aaargh!  If you really want to do it this way, at least add a
> "/* fall through */" so that it's obvious that this is not a mistake.

Done here, will post again.

I'd like you to try the
  "ehci-hcd: complete iso urbs ASAP for number_of_packets != (n * 8) also"
  http://marc.info/?l=linux-usb-devel&m=119444869917392&w=2
with snd-usb-audio.

snd-usb-audio uses number_of_packets equalling multiples of 8 currently
when transfering over USB 2.0, no?
If so, with above patch that "multiples of 8"-thing could go away and
snd-usb-audio could achieve up to 8 times less userspace-activation-jitter
in low latency setups like 128 frames/period, 2 periods.

thanks,
      Karsten
