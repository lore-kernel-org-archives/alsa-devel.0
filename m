From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
 cards, especially Aureon 5.1 MkII
Date: Fri, 19 Feb 2010 16:13:28 +0100
Message-ID: <20100219151328.GC25873@tango.0pointer.de>
References: <20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
	<20100216233825.GB23623@sirena.org.uk>
	<20100216235658.GA6766@tango.0pointer.de>
	<4f3252891002171748tdcaa87n4d11d9880c0043e3@mail.gmail.com>
	<20100218023742.GC23637@tango.0pointer.de>
	<4f3252891002172215j7b85313ci3626a1bdad5c040c@mail.gmail.com>
	<20100218181322.GB5606@tango.0pointer.de>
	<alpine.LNX.2.00.1002190916410.28127@eeebox2.perex-int.cz>
	<4f3252891002190257u608073c3l48f2251d8a6458ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id BBBE3103958
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 16:13:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4f3252891002190257u608073c3l48f2251d8a6458ee@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 19.02.10 18:57, Raymond Yau (superquad.vortex2@gmail.com) wrote:

> PA assume every sound card can only record from one capture source at the
> same time (like those AC97 card )

That is true. PA does not try to cover the complete functionality of
the hardware. We limit ourselves to what we think is common on the
desktop or in a mobile environment, and I don't think recording from
mic and line-in at the same time would be useful in more than
exceptional cases.

> Is HDA_SUBDEV_NID_FLAG or any API for the application to find the correct
> mixer control for these kind of capturing subdevices  ? ( simple mixer api
> is not able to know the subdevice number )

There is currently no API at all to figure out the relation between PCM
devices and mixer controls in ALSA. PA hences bases this all on
assumptions and expectes in this acse that the first mixer control is
also the first PCM device, if you understand what I mean by that.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
