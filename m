From: =?ISO-8859-1?Q?Fl=E1vio_Martins?= <xhaker@gmail.com>
Subject: Re: Laggy mixer with Xonar DX snd_virtuoso
Date: Wed, 14 Apr 2010 02:07:59 +0100
Message-ID: <w2z9374ce781004131807ofee2f8efi223e6ef6773b7dbf@mail.gmail.com>
References: <x2t9374ce781004101749lede8799foaa7b92ae40034c5@mail.gmail.com>
	<4BC43311.3070402@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f220.google.com (mail-bw0-f220.google.com
	[209.85.218.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B3E224436
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 03:08:01 +0200 (CEST)
Received: by bwz20 with SMTP id 20so9899645bwz.32
	for <alsa-devel@alsa-project.org>; Tue, 13 Apr 2010 18:07:59 -0700 (PDT)
In-Reply-To: <4BC43311.3070402@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010/4/13 Clemens Ladisch <clemens@ladisch.de>:
> Fl=E1vio Martins wrote:
>> I have a Xonar DX with a laggy volume control, you might have guessed al=
ready.
>> Sound will interrupt if the volume change is big like from 100% to
>> 50%, it will only
>> skip a bit if the volume change is smaller. The interruptions/silence
>> last more than
>> 5 seconds easily. I can actually see the mixer slider going up and
>> down on its own.
>
> Does this also happen with alsamixer?

Controlling the volume with alsamixer works well, the sound does not break.
If i change the volume with the gnome-applet/pulseaudio i can see the slide=
rs
in alsamixer getting affected by my changes with some stuttering and the so=
und
does break as described initially.

>
>> Here goes the alsa-info.sh output, some weird things going on in dmesg
>> http://www.alsa-project.org/db/?f=3Dee911fe73baa60aac51c62ff787ab8b8bd85=
65e8
>
> The only message from the snd-virtuoso driver is at time 7.696764; some
> are from a USB audio device and most from the onboard HDA device.
>

The onboard actually works well with the pulseaudio volume applet.
Sorry if it filled the log with crap, i use it for microphone input.

>
> Regards,
> Clemens
>

Regards,
Fl=E1vio
