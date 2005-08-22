From: Chow Raymond <usher_raymond82@yahoo.com>
Subject: Re: Compulab sound device
Date: Mon, 22 Aug 2005 00:06:53 -0700 (PDT)
Message-ID: <20050822070653.21964.qmail@web54605.mail.yahoo.com>
References: <1124460631.2861.259.camel@cearnarfon>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1124460631.2861.259.camel@cearnarfon>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I also wish to port from 2.6.7 to 2.6.12. However,
Compulab only supports till 2.6.7. I can't build
2.6.12 kernel to run on Compulab's board.

Raymond

--- Liam Girdwood <liam.girdwood@wolfsonmicro.com>
wrote:

> On Fri, 2005-08-19 at 06:51 -0700, Chow Raymond
> wrote:
>=20
> >=20
> > > This means that snd-pxa2xx-pcm.ko has not been
> > > inserted. It's built from
> > > pxa2xx-pcm.c
> >=20
> > I cant even insmod snd-pxa2xx-pcm. It gives me the
> > following error.=20
> >=20
> > [root@ARMCore sound1]$ insmod snd-pxa2xx-pcm.ko
> > snd_pxa2xx_pcm: Unknown symbol
> dma_mmap_writecombine
> > insmod: error inserting 'snd-pxa2xx-pcm.ko': -1
> > Unknown symbol in module
> > =20
>=20
> It looks like your arch/arm and include/asm/ also
> has to be back ported
> from 2.6.12. I've now read Clemens reply and also
> believe it's better to
> port your machine from 2.6.7 to 2.6.12.
>=20
> Liam
>=20
>=20
>=20
>=20
>
-------------------------------------------------------
> SF.Net email is Sponsored by the Better Software
> Conference & EXPO
> September 19-22, 2005 * San Francisco, CA *
> Development Lifecycle Practices
> Agile & Plan-Driven Development * Managing Projects
> & Teams * Testing & QA
> Security * Process Improvement & Measurement *
> http://www.sqe.com/bsce5sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/alsa-devel
>=20



	=09
____________________________________________________
Start your day with Yahoo! - make it your home page=20
http://www.yahoo.com/r/hs=20
=20


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
