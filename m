From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Sun, 21 Feb 2010 12:01:20 +0800
Message-ID: <4f3252891002202001gb6df8cg6c023c52e7d8394a@mail.gmail.com>
References: <20100216223938.GA23623@sirena.org.uk>
	<20100216233825.GB23623@sirena.org.uk>
	<20100216235658.GA6766@tango.0pointer.de>
	<4f3252891002171748tdcaa87n4d11d9880c0043e3@mail.gmail.com>
	<20100218023742.GC23637@tango.0pointer.de>
	<4f3252891002172215j7b85313ci3626a1bdad5c040c@mail.gmail.com>
	<20100218181322.GB5606@tango.0pointer.de>
	<alpine.LNX.2.00.1002190916410.28127@eeebox2.perex-int.cz>
	<4f3252891002190257u608073c3l48f2251d8a6458ee@mail.gmail.com>
	<20100219151328.GC25873@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 31431103807
	for <alsa-devel@alsa-project.org>; Sun, 21 Feb 2010 05:01:22 +0100 (CET)
Received: by pvc22 with SMTP id 22so29115pvc.38
	for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2010 20:01:20 -0800 (PST)
In-Reply-To: <20100219151328.GC25873@tango.0pointer.de>
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

2010/2/19 Lennart Poettering <mznyfn@0pointer.de>

>
>
> > Is HDA_SUBDEV_NID_FLAG or any API for the application to find the correct
> > mixer control for these kind of capturing subdevices  ? ( simple mixer
> api
> > is not able to know the subdevice number )
>
> There is currently no API at all to figure out the relation between PCM
> devices and mixer controls in ALSA. PA hences bases this all on
> assumptions and expectes in this acse that the first mixer control is
> also the first PCM device, if you understand what I mean by that.
>
> Lennart
>
>
No, there is API which allow PA to find out the correct mixer control

However Simple Mixer API cannot know the subdevice number , you have to use
control API ( the lower level API used by Simple Mixer API )
