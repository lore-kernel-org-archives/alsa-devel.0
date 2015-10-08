From: Felipe Tonello <eu@felipetonello.com>
Subject: Re: USB audio device startup question
Date: Thu, 8 Oct 2015 16:53:50 +0100
Message-ID: <CAGrhNMys5hD5vJyyvPOzUYN0iT_+Ls6xDPrjnH0tk4RoSX8cFg@mail.gmail.com>
References: <alpine.DEB.2.02.1510040630150.25833@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f173.google.com (mail-lb0-f173.google.com
 [209.85.217.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 0467B264F03
 for <alsa-devel@alsa-project.org>; Thu,  8 Oct 2015 17:53:52 +0200 (CEST)
Received: by lbos8 with SMTP id s8so51570350lbo.0
 for <alsa-devel@alsa-project.org>; Thu, 08 Oct 2015 08:53:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1510040630150.25833@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Ricard,

On Sun, Oct 4, 2015 at 5:45 AM, Ricard Wanderlof
<ricard.wanderlof@axis.com> wrote:
>
> (This is in reference to getting the Zoom R16 to work, but the main query
> in this post is of a more general nature).
>
> In trying to get a Zoom R16 in audio interface mode to work in Linux I'm
> trying to understand how the USB-audio (snd-usb-audio module) subsystem
> works in Linux. I've looked in the USB audio version 1 and 2 documents, as
> well as the USB 2.0 standard, but there are some things that don't seem to
> be well defined there, like exactly how the audio data is packaged in the
> isochronous transfer packets.
>
> I've been using Wireshark to visualize the USB communication, and also
> comparing with the corresponding transfers on a Windows box by dumping the
> traffic with USBPcap.
>
> The only other USB audio interface I have access to here is an Edirol
> UA-5. I've noted that when plugging in the UA-5, there's period of about
> 15 seconds during which capture and playback are set up and audio data
> transferred, after which the interface is shut down again. When enabling
> the R16, during the corresponding initial period I see playback data but
> no capture data during this phase. I don't know if that is significant or
> not, for instance, if the lack of capture data during this phase is
> because the playback is not working as it should.
>
> My question is: what governs this startup phase, can someone point to a
> specific part of the code or some documentation describing what is
> supposed to go on here? Is it some sort of device test period to determine
> that the device actually works?

sound/usb/quirks-table.h and sound/usb/quirks.c

The probe functions basically calls snd_usb_create_quirk() on each of
the snd_usb_audio_quirk.data item of the array. Make sure that the
quirk structure is correct for the ZOOM R16.

>
> The problem with the R16 is that although capture works fine, playback
> doesn't result in any audio. With the correct quirk set up (most
> importantly, using a 24 bit format), aplay appears to work fine with no
> errors, neither are there any complaints from dmesg, and looking at the
> communication I can see outgoing isochronous data from the host being
> transferred fine.
>
> More work needs to be done, but I've looked at the startup of the Windows
> driver which is deceptively simple: it basically just sets the
> appropriate capture and playback interfaces, together with sending off
> some sample rate USB control commands, the isochronous link comes up and
> that seems to be it. I've tried to emulate the specific USB control
> commands in Linux, as well as add some delays that there appear to be in
> the Windows driver, but so far it hasn't made a difference.

Can you copy your dmesg output here? Check the /proc/asound/cards and
see if your card is there. If it is, check the
/proc/asound/cardN/XX/info if it is correct.

Felipe
