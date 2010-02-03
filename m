From: John Graham <johngavingraham@googlemail.com>
Subject: Re: Access to bytes from the raw audio stream? (AC'97)
Date: Wed, 3 Feb 2010 16:27:05 +0000
Message-ID: <94cf76f1002030827p6b420c17wae026b19cd077e60@mail.gmail.com>
References: <94cf76f1002030808t1d54dc08oab179673e814f016@mail.gmail.com>
	<20100203161737.GC12034@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f221.google.com (mail-bw0-f221.google.com
	[209.85.218.221])
	by alsa0.perex.cz (Postfix) with ESMTP id 8AD3A24404
	for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2010 17:27:07 +0100 (CET)
Received: by bwz21 with SMTP id 21so1192953bwz.4
	for <alsa-devel@alsa-project.org>; Wed, 03 Feb 2010 08:27:06 -0800 (PST)
In-Reply-To: <20100203161737.GC12034@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> With a lot of AC97 controllers the hardware won't allow you direct
> access to the cooked wire data, you'll only be able to see decoded audio
> streams. =A0What is it that you're actually trying to do?

Basically, we've got a problem where we think our processor is
bit-shifting the sample for some reason, and I was going to see if I
could either (i) un-bit-shift it (it looks like we're not actually
losing any data, the sound's just being multiplied by 2^4), or (ii)
reproduce the problem we see by bit-shifting the samples on a
known-good platform.


> For embedded platforms you mostly want to look under sound/soc though
> there are a few platforms outside of there.

I know the drivers for our particular setup (UBC1400 codec/i.MX25
processor) are under sound/arm, but I'm not sure if there's anything
in there that actually sees the samples as they come through.


Would I be able to access samples quite early on in the generic AC'97
code (I don't know where that is, either, but it would be interesting
to see, at least :p)

Thanks,

John G
