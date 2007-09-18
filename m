From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: E-MU 0404/0202 USB implementation
Date: Tue, 18 Sep 2007 09:40:42 +0200
Message-ID: <1190101242.19934.1211206975@webmail.messagingengine.com>
References: <46EEF2F1.7030404@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 96A2424474
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 09:40:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46EEF2F1.7030404@superbug.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <James@superbug.co.uk>, ALSA development <alsa-devel@alsa-project.org>
Cc: Aleksander <aleksander@krediidiinfo.ee>
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> I am looking to implement support for the E-Mu USB cards.
> The card is basically following a mix of USB 1.0 and USB 2.0 descriptors.
> 
> The bInterfaceClass field of the standard interface descriptors for the
> Audio Control, Audio Streaming, and MIDI Streaming interfaces are set to
> 0xFF (vendor-specific) instead of 0x01 (USB Audio).
> 
> Can I put in a quirk into the snd-usb-audio driver to handle this?

There are no class-specific descriptors, so you cannot simply use an
AUDIO_STANDARD_INTERFACE quirk.

It would be possible to hardcode a specfifc sample format with an
AUDIO_FIXED_ENDPOINT quirk, but this doesn't work when there is more
than one alternate setting.

I think you have to manually add several sample formats, like in the
UA-1000 quirk, but calling add_audio_endpoint() several times.

The asynchronous feedback of the output endpoints should work; it does
with the SB Audigy 2 NX in high speed mode.

Please note that the descriptors may be different in full speed mode.

QUIRK_MIDI_FIXED_ENDPOINT should work for interface 3.

> The card also has customised controls. Can one add those to
> snd-usb-audio, or would it be better to add those to a totally new
> driver?

usbmixer.c currently doesn't have a mechanism to add mixer controls that
are not listed in the descriptors, but it should be possible to create
the data structures to describe those.

A totally new driver might be a good idea if the core part of usbaudio.c
were in a library.  I always planned to do that when I'd find some time.


Regards,
Clemens
