From: "Ryan C. Underwood" <nemesis@icequake.net>
Subject: Re: rawmidi virtual and long sysexes
Date: Tue, 22 Dec 2015 10:11:47 -0800
Message-ID: <20151222181147.GL28165@localhost.localdomain>
References: <20151219233143.GK28165@localhost.localdomain>
 <821A542B-D0E2-4AD5-A3EF-18A937735B3B@ladisch.de>
Reply-To: nemesis@icequake.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2929609044404643784=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.icequake.net (64-251-151-187.fidnet.com [64.251.151.187])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AACE26596E
 for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2015 19:11:55 +0100 (CET)
In-Reply-To: <821A542B-D0E2-4AD5-A3EF-18A937735B3B@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, stsp@list.ru
List-Id: alsa-devel@alsa-project.org


--===============2929609044404643784==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L2Brqb15TUChFOBK"
Content-Disposition: inline


--L2Brqb15TUChFOBK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 22, 2015 at 06:51:47AM +0100, Clemens Ladisch wrote:
> Ryan C. Underwood wrote:
> >Basically, the rawmidi virtual plugin enforces a 256-byte limit on
> >events, and emits multiple events if e.g. a >256 byte sysex is
> >encountered.
>=20
> All sequencer clients have such a limit.

I was not objecting to a limit.  I was questioning the utility of a
_hard-coded_ limit.

> >This does not seem to be documented behavior for
> >snd_seq_event_input(), nor is the fixed limit described anywhere.
>=20
> Yes, the documentation is lacking.

What's the best way to submit a documentation change, patch the docs
embedded in the code and mail that here?

> >Would it be better if the maximum event size could be configured
> >through params?  That would avoid needing this clumsy workaround by
> >sequencer clients.
>=20
> Handling split messages cannot be avoided; the API is not
> capable of sending arbitrarily large messages.

So, the client writing to rawmidi has local knowledge about the
largest sysex he will generate.  I only propose that alsa-lib be
willing to accept this local knowledge over its own hard-coded default
when sizing the event buffer.  (For example, the device buffer size is
configurable by the sequencer client.)

Of course, I won't bother if such a patch would be rejected, and will
instead change the documentation.

--=20
Ryan C. Underwood, <nemesis@icequake.net>

--L2Brqb15TUChFOBK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iD8DBQFWeZJiIonHnh+67jkRAuWLAJ9RoB1ryj8lS3WSYTHQOMluEtCllwCeP9B7
UjzHYO9Td5xR154VfUdR3sk=
=9AUf
-----END PGP SIGNATURE-----

--L2Brqb15TUChFOBK--

--===============2929609044404643784==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2929609044404643784==--
