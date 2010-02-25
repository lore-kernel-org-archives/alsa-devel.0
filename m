From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Thu, 25 Feb 2010 11:51:24 +0800
Message-ID: <4f3252891002241951v10260aebyb53f86d46e3fea8a@mail.gmail.com>
References: <20100216143200.GB25489@tango.0pointer.de>
	<20100216154015.GA612@tango.0pointer.de>
	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
	<20100216210703.GA18109@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
	<20100216233825.GB23623@sirena.org.uk>
	<20100216235658.GA6766@tango.0pointer.de>
	<4f3252891002171748tdcaa87n4d11d9880c0043e3@mail.gmail.com>
	<20100218023742.GC23637@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f192.google.com (mail-pz0-f192.google.com
	[209.85.222.192])
	by alsa0.perex.cz (Postfix) with ESMTP id 08472103959
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 04:51:26 +0100 (CET)
Received: by pzk30 with SMTP id 30so1170467pzk.23
	for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2010 19:51:25 -0800 (PST)
In-Reply-To: <20100218023742.GC23637@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010/2/18 Lennart Poettering <mznyfn@0pointer.de>

> On Thu, 18.02.10 09:48, Raymond Yau (superquad.vortex2@gmail.com) wrote:
>
> > From the viewpoint of user, they only care how easy to find the point
> which
> > is no software gain or software auttentation  since software gain lead to
> > clipping
>
> We decided to expose software amplification in the UI, since it is
> actually a much requested feature, and I have used myself a couple of
> times.
>
> The primary use case is when you play a DVD (which very often has
> audio normalized to a very low volume) on weak speakers, such as
> laptop speakers.
>
> Lennart
>
> --
>
There are many mixer switch need to export to the mixer control

some are hardware specific and some are AC 97 standard feature which affect
the dB volume

e.g. ac97 standard external amplifier

    control.52 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 1
        iface MIXER
        name 'External Amplifier'
        value true
    }
}

and codec specifc

Sigmatel Surround Playback Volume which change the ratio of  volume of
"front" and "rear" channels

so the overall dB in the front speaker is also affected by this volume
control


    control.20 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 31'
        comment.dbmin -4650
        comment.dbmax 0
        iface MIXER
        name 'Sigmatel Surround Playback Volume'
        value.0 0
        value.1 0

    control.50 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 1
        iface MIXER
        name 'Sigmatel 4-Speaker Stereo Playback Switch'
        value false
    }

    control.49 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 1
        iface MIXER
        name 'Sigmatel Output Bias Switch'
        value false
    }

    control.51 {
        comment.access 'read write'
        comment.type BOOLEAN
        comment.count 1
        iface MIXER
        name 'Sigmatel Surround Phase Inversion Playback '
        value true
    }
