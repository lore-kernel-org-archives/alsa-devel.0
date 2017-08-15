From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: mediatek: Correct the interrupt
	property
Date: Tue, 15 Aug 2017 14:56:10 +0100
Message-ID: <20170815135610.353otptxulcv547a@sirena.org.uk>
References: <43a7fb98e7252d0b7b73cdabf1eedd0bf896d68c.1502784169.git.ryder.lee@mediatek.com>
 <20170815115309.glj52jx3kpq4jxq3@sirena.org.uk>
 <1502805100.25910.8.camel@mtkswgap22>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8614200842029176883=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 71489266C99
 for <alsa-devel@alsa-project.org>; Tue, 15 Aug 2017 15:56:16 +0200 (CEST)
In-Reply-To: <1502805100.25910.8.camel@mtkswgap22>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Garlic Tseng <garlic.tseng@mediatek.com>, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============8614200842029176883==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rjgewxksvknb56nm"
Content-Disposition: inline


--rjgewxksvknb56nm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2017 at 09:51:40PM +0800, Ryder Lee wrote:
> On Tue, 2017-08-15 at 12:53 +0100, Mark Brown wrote:

> > What harm does having the extra information in the bindings do?  If it's
> > possible there might be a use for the extra interrupt it seems better to
> > have people describe it.

> Yes you're right. The current driver get IRQ number by index "0" but
> actually it should be "1" (GIC 132). Perhaps we can switch to use the
> platform_get_irq_byname() and add interrupt-name in DT so that binding
> can be agnostic of the IRQ order.=20

Yes, that's generally good - it also means that if future revisions of
the IP have different sets of interrupts the binding can adapt
gracefully.

--rjgewxksvknb56nm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmS/XkACgkQJNaLcl1U
h9DndQf/c87WbDQgINERlFlcHwzAF9tNyDj4nhlmW/udRkwIaL+AOiQUH6+EIEQ8
XZocnfUdhZf6VG5bDizTll6B5ti7T0jN3oaQDU3B1UFVrTnuVhAc3SM96Bob+6lG
kR0eHvfzBKq5lxIsh3rqWTahIKJ5tglF20mJ25GwXJnM/Gfz+U39opdrQcUDEi82
0B1TXUCutFAg4hD82MskWmwuCJs5LvCPaV8N9wx0L15i7tulyTNW2D8n/U/qRYZp
1qpdMT1nTZ9xKQPZ0Q/b16UWabCE91vWl7smnrEqhZyesmn+ALK1DnnIi3coQdG1
d1A/rSERw/EIU/CTcxngAfsRi0evAA==
=CJq1
-----END PGP SIGNATURE-----

--rjgewxksvknb56nm--

--===============8614200842029176883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8614200842029176883==--
