From: Mark Brown <broonie@kernel.org>
Subject: Re: simle-card DT style for DPCM
Date: Tue, 9 Sep 2014 12:51:30 +0100
Message-ID: <20140909115130.GV2601@sirena.org.uk>
References: <877g1o18ka.wl%kuninori.morimoto.gx@gmail.com>
 <20140901143047.GX29327@sirena.org.uk>
 <87mwaikdzx.wl%kuninori.morimoto.gx@gmail.com>
 <20140902113407.GV29327@sirena.org.uk>
 <87fvg97ecd.wl%kuninori.morimoto.gx@gmail.com>
 <20140905155513.GE29327@sirena.org.uk>
 <877g1fotdd.wl%kuninori.morimoto.gx@gmail.com>
 <540D5D2B.5080504@metafoo.de>
 <87oauqo5qs.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6015783555311259602=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DAB012650C3
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 13:51:54 +0200 (CEST)
In-Reply-To: <87oauqo5qs.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============6015783555311259602==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h85LGMdA0M9ASxa6"
Content-Disposition: inline


--h85LGMdA0M9ASxa6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 08, 2014 at 01:50:53AM -0700, Kuninori Morimoto wrote:

> 2 reasons for enabling DPCM
>  1. to use "sampling rate convert"
>  2. we need to use multi CPU (2cpu + 1codec)

> 2nd case is required in our next SoC.

...

> We can create everything/something in C code. I have no concern about it.
> I need to know DT style of "multi cpu system on simple-card"
> (= we will use DPCM in this case)
> It is easy to understand for me if Mark/you can show me your idea of DT style.

If these two cases look the same from a hardware point of view (one
external interface connected to the CODEC, one block within the SoC
which happens to be able to deal with multiple streams of audio) then
they should look the same from a DT point of view.  The fact that the
block can handle multiple streams of audio shouldn't be relevant to the
DT bindings.

--h85LGMdA0M9ASxa6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUDunBAAoJECTWi3JdVIfQV2YH/1m0hEQ98cxyRKan7t15e0vZ
FuVNQJsyYOMU+vSENsvn+O5dIsX1zYzbV4vf1mHyAgMwqaPe8vfBgEPbJG7a+tzN
3apfkFB4ZkQH9hYlkjELvZiwhNF88T9dWGeCtKrfRcvFUsfbmdNzLnmF0TsYV3hh
wVqP1XXpCMuc6Y4qX9SGbGqAwAxnOD/+Bw23GGJFmKs4GBMUFd1MHywyJ4axGR4N
U0TCsVUqtPCC1K45lc7HN58F0A0rRNw7oBSpDH5n9OO+OSoxT0FURb8QT+aafsPb
c1+pci2nZpVKHkxsuO7AI3TkdukuWlsc3CMci7WewDHOpP02WoKVA7QOVKyXg7Q=
=+0Uk
-----END PGP SIGNATURE-----

--h85LGMdA0M9ASxa6--

--===============6015783555311259602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6015783555311259602==--
