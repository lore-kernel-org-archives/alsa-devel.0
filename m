From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: Re: TASCAM US-1641
Date: Thu, 25 Mar 2010 11:03:09 +0100
Message-ID: <201003251103.09261.fzu@wemgehoertderstaat.de>
References: <1269394483.6635.11.camel@eviltwin>
	<20100324055626.GH30801@buzzloop.caiaq.de>
	<1269468166.7429.7.camel@eviltwin>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout0.freenet.de (mout0.freenet.de [195.4.92.90])
	by alsa0.perex.cz (Postfix) with ESMTP id 0930D2456C
	for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2010 11:03:13 +0100 (CET)
In-Reply-To: <1269468166.7429.7.camel@eviltwin>
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
Cc: Jan Depner <eviltwin69@cableone.net>
List-Id: alsa-devel@alsa-project.org

Am Mittwoch 24 M=E4rz 2010 schrieb Jan Depner:
> =

> =

> > I suggest adding some printk()s to the driver and see what it actually
> > does and which values it passes around. Most probably there is more
> > differences in the data format, and descriptors and/or message blocks
> > have different meanings for this hardware model.
> > =

> =

>     I did as suggested and got back reasonable appearing numbers for
> rate, use_packsize, and period_frames of 44100, 36, and 256 respectively
> but am not sure how to relate this to my interface.

I heard the US-1641 uses bulk and/or iso packets, while US-122L uses iso on=
ly.
so snd_usb_us122l would need some deep tweaking.
also all the incantation stuff looks propably different.

> Is there some
> documentation somewhere that would explain the output of lsusb -v with
> respect to variable names in us122l.c.

erm, no. there are the interface and endpoint numbers.

> My problem here is that I don't
> know what would actually be reasonable for this interface nor how to
> find out.

usbsnoop and/or the developers at http://usbaudio.com.
> =

> =

>     Many thanks for your help with this.  Karsten had asked me to get
> back with him if I got one of these but my email to him must have gone
> to the spam filter as I haven't heard anything.

no spam filters, just work and short hollidays.

looking back at developing snd_usb_us122l, i'm unsure if I spent my time wi=
sely:
the actual hardware one can buy now doesn't talk to the driver anymore. and=
 i'm
busy caring for real life, which i've been omitting a tad too much that tim=
e.

If in doubt, don't bother hacking on the tascam, enjoy spring instead!


regards,
Karsten
