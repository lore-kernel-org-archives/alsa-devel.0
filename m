From: Maurizio Berti <maurizio.berti@gmail.com>
Subject: Re: Range of pitchbend MIDI events
Date: Wed, 24 Aug 2016 13:18:25 +0200
Message-ID: <CAPn+-XRFqXU11229d2WXMwqOLZx=jyGqDJB=khAiFX9uRS2FBg@mail.gmail.com>
References: <CAPn+-XSsDEe3ruu7vYmdNgneLpK13VxYVm860JAt4cwFe86soQ@mail.gmail.com>
 <alpine.DEB.2.02.1608241139580.6821@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yb0-f181.google.com (mail-yb0-f181.google.com
 [209.85.213.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 07DF62672B6
 for <Alsa-devel@alsa-project.org>; Wed, 24 Aug 2016 13:18:27 +0200 (CEST)
Received: by mail-yb0-f181.google.com with SMTP id a7so3149941ybi.0
 for <Alsa-devel@alsa-project.org>; Wed, 24 Aug 2016 04:18:26 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1608241139580.6821@lnxricardw1.se.axis.com>
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
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Actually, no, after the first three bytes (status byte and two data
> bytes), running status is employed, so that if the third byte received is
> not a status byte, it will be regarded as the first data byte of a
> subsequent pitch bend message.
>
> e.g. for channel 1:
>
> 0xE0 0x00 0x40 is a complete pitch bend message, if two subsequent bytes
> 0x12 0x40 are received, they are interpreted as another pitch bend value,
> the 0xE0 being implicit since no new status byte has been given. If the
> bytes are sent in quick succession, the first bend value (0x00 0x40 in
> this case) might not have any audible effect, and the impression one gets
> as a listener is that it's the last two bytes which are the only ones
> received or acted on.

That's what I thought it was happening, and I don't know how to intercept
the incoming byte data, but it looks to me that this does not involve the
implicit status byte: what aseqdump actually prints (and I get from
alsaseq) is a single pitchbend event using a value out of range, as I
mentioned vkeybd too is able to send and get accepted a 8192 pitchbend.
Correct me if I'm wrong, but looks like a single 3 bytes message (or a 4
byte one, maybe). If that's not the case, I think I should see two
pitchbend event, being the first equal 0, and the second 127.

> I don't know anything about pyalsa, but if it creates more bytes than
> specified in the protocol because higher values than allowed are requested
> I'd say it's buggy.

I think that it's "allowed" for performance reasons, provided that the
programmer shouldn't send out of range events, still, the conversion can
generate confusion, if there is no consistence with other 2 bytes limited
events from alsa.

Maurizio
