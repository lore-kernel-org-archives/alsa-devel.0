From: John Rigg <aldev2@jrigg.co.uk>
Subject: Re: Cannot combine audio devices with more than
	64	channels
Date: Tue, 31 Jan 2017 17:58:05 +0000
Message-ID: <20170131175805.GA16643@localhost.localdomain>
References: <CAKw=HF0hbhxJ1YGjukjFr72xtEh2FjtH6k0Bh+rFcMwejgwcUg@mail.gmail.com>
 <1cdef19b-a458-7441-2ede-2ba8984ec7cd@ladisch.de>
 <s5hh94khiao.wl-tiwai@suse.de>
 <CAKw=HF1kZ12YOUuBX0MmiyYsPqQ68kafP-cVmWA8FP0dHOAuDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vm2962.vps.tagadab.com (vm2962.vps.tagadab.com [95.172.24.202])
 by alsa0.perex.cz (Postfix) with ESMTP id B14F12667EE
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 19:28:01 +0100 (CET)
Received: from m0 by vm2962.vps.tagadab.com with local (Exim 4.69)
 (envelope-from <noreply@jrigg.co.uk>) id 1cYcgv-0004L0-76
 for alsa-devel@alsa-project.org; Tue, 31 Jan 2017 17:58:05 +0000
Content-Disposition: inline
In-Reply-To: <CAKw=HF1kZ12YOUuBX0MmiyYsPqQ68kafP-cVmWA8FP0dHOAuDw@mail.gmail.com>
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

On Tue, Jan 31, 2017 at 06:18:48PM +0100, J=F6rg M=FCller wrote:
> I applied the patch to my system and it fixed the error!
> =

> However, I get the following error which seems to be caused by a code
> not being able to handle more than 256 channels:
> > wfs@wfs16:~$ jackd -R -d alsa -C madifx_record_all -P madifx_playback_a=
ll
> > jackdmp 1.9.10
> > Copyright 2001-2005 Paul Davis and others.
> > Copyright 2004-2014 Grame.
> > jackdmp comes with ABSOLUTELY NO WARRANTY
> > This is free software, and you are welcome to redistribute it
> > under certain conditions; see the file COPYING for details
> > no message buffer overruns
> > no message buffer overruns
> > no message buffer overruns
> > JACK server starting in realtime mode with priority 10
> > self-connect-mode is "Don't restrict self connect requests"
> > audio_reservation_init
> > Acquire audio card Audio0
> > creating alsa driver ... madifx_playback_all|madifx_record_all|1024|2|4=
8000|0|0|nomon|swmeter|-|32bit
> > configuring for 48000Hz, period =3D 1024 frames (21.3 ms), buffer =3D 2=
 periods
> > ALSA: final selected sample format for capture: 32bit float little-endi=
an
> > ALSA: use 8 periods for capture
> > ALSA: final selected sample format for playback: 32bit float little-end=
ian
> > ALSA: use 8 periods for playback
> > jackd: ../linux/alsa/JackAlsaDriver.cpp:122: virtual int Jack::JackAlsa=
Driver::Attach(): Assertion `fCaptureChannels < 256' failed.
> > Aborted (core dumped)
> =

> What could be the problem here?

jackd only allows 256 ports maximum by default. Try using -p option
to increase it, eg. to 512:

jackd -R -p512 -d alsa....etc

BTW you don't need to specify -R on recent jackd versions as it's
realtime by default (use -r if you don't want realtime).

John
