From: Jean-Philippe Guillemin <h1p8r10n@gmail.com>
Subject: Fwd: Adding support for CMEDIA USB2.0 High-Speed True
	HD Audio
Date: Tue, 6 Feb 2018 11:03:10 +0100
Message-ID: <CAOuaOFvCMr2ADmZ5J9ssgz-_Yp4wCOiUPZBHcVYBHuB3pZcjnw@mail.gmail.com>
References: <CAOuaOFuAa0jd9ZAENcnaJci1JmCw+dzAwQqT9bhv2t=i=ndWSA@mail.gmail.com>
 <CAOuaOFshdK1ZsXrJhC340yR=v4PMspq-G_B=9DxM4dEnfTk_vg@mail.gmail.com>
 <dea3694c-64aa-29b3-a2a1-2c104a44e596@ladisch.de>
 <CAOuaOFt8ZMnDNQqAbAfT8vo1FsJNwYZ6Q=rwxetVBtVCBB6L+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f195.google.com (mail-ot0-f195.google.com
 [74.125.82.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E53426722C
 for <alsa-devel@alsa-project.org>; Tue,  6 Feb 2018 11:03:42 +0100 (CET)
Received: by mail-ot0-f195.google.com with SMTP id e64so1197430ote.4
 for <alsa-devel@alsa-project.org>; Tue, 06 Feb 2018 02:03:42 -0800 (PST)
In-Reply-To: <CAOuaOFt8ZMnDNQqAbAfT8vo1FsJNwYZ6Q=rwxetVBtVCBB6L+Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

---------- Forwarded message ----------
From: Jean-Philippe Guillemin <h1p8r10n@gmail.com>
Date: 2018-02-06 10:57 GMT+01:00
Subject: Re: [alsa-devel] Adding support for CMEDIA USB2.0 High-Speed True
HD Audio
To: Clemens Ladisch <clemens@ladisch.de>




2018-02-06 10:33 GMT+01:00 Clemens Ladisch <clemens@ladisch.de>:

> (please don't top-post)
>
> Jean-Philippe Guillemin wrote:
> > # aplay -l
> > card 0: Audio [USB2.0 High-Speed True HD Audio], device 0: USB Audio
> [USB Audio]
> > card 0: Audio [USB2.0 High-Speed True HD Audio], device 1: USB Audio
> [USB Audio #1]
> > card 0: Audio [USB2.0 High-Speed True HD Audio], device 2: USB Audio
> [USB Audio #2]
>
> So "aplay -D plughw:0,2 something.wav" works correctly?
>

Yes, indeed, I've got sound through the SPDIF output interface


>
> >> I'm trying to create a mapping in USB-Audio.conf :
> >>  # If a device does not use the first PCM device for digital data, the
> device
> >>   # number for the iec958 device can be changed here.
> >>   USB-Audio.pcm.iec958_device {
> >>      # "NoiseBlaster 3000" 42
> >>      "USB Sound Blaster HD" 1
> >>      "USB2.0 High-Speed True HD Audio" 2
> >>   ...
> >>
> >> But I never got a match on "USB2.0 High-Speed True HD Audio".
>
> What exactly happens when you try "aplay -D iec958 something.wav"?
>

 No sound through SPDIF output interface :

aplay -D iec958 foo.wav
Playing WAVE 'foo.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo




>
> Regards,
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
