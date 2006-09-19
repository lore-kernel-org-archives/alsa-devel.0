From: Pablo Yaggi <pyaggi@alsurdelsur.com>
Subject: Re: C-Media / usb device bug ?
Date: Tue, 19 Sep 2006 04:17:50 -0300
Message-ID: <200609190417.50321.pyaggi@alsurdelsur.com>
References: <200609181921.10510.pyaggi@alsurdelsur.com>
	<1158647803.13410.271265867@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1158647803.13410.271265867@webmail.messagingengine.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On Tuesday 19 September 2006 03:36, Clemens Ladisch wrote:
> Pablo Yaggi wrote:
> >  I'm working in a multi-capture application with alsa and i discovered
> > if i attach two "c-media usb headphone set" adapters to an usb hub which
> > is attached to my computer when i try to read from the two devices the
> > first one read (also open) errors with (-77) bad file descriptor status
> > and the other one keep working. When i attach the two devices directly =
to
> > the usb connectors (without hub) all works fine, the two devices can be
> > read at the same time.
> =

> What kernel version are you using?
> =

> The EHCI transaction translator code (which is responsible for moving
> audio data through an high speed hub) got a bugfix in 2.6.17, but still
> artificially limits the bandwidth.  It will be rewritten in 2.6.18.
> =

> =

> HTH
> Clemens
> =


I tested it on 2.6.15, 2.6.16 and 2.6.17,
so you think the problem is EHCI ? =A0is there anyway to check it ?
is it yet in rewriting process ? =

Thank's
Pablo

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
