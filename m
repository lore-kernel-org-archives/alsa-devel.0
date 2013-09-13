From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 3/8] ASoC: davinci-mcasp: Get DMA
 related properties from DT
Date: Fri, 13 Sep 2013 18:53:54 +0100
Message-ID: <20130913175354.GU29403@sirena.org.uk>
References: <cover.1378738436.git.jsarha@ti.com>
 <35b6dc24d8a803b97c683d4d2c51db7e3518f7ff.1378738436.git.jsarha@ti.com>
 <20130909152559.GM29403@sirena.org.uk>
 <d56ff517b8d6e29af7639665bb17c1bb@kapsi.fi>
 <20130912110800.GI29403@sirena.org.uk>
 <62c9342f91e99fa5d421a7ad29fbf354@kapsi.fi>
 <20130912115626.GO29403@sirena.org.uk>
 <49bf24974af0ff34d2be7db97e04f2a9@kapsi.fi>
 <20130913103431.GG29403@sirena.org.uk> <5232EDF7.2010000@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5684851572397355779=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 20E39261670
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 19:54:00 +0200 (CEST)
In-Reply-To: <5232EDF7.2010000@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: Darren Etheridge <detheridge@ti.com>, alsa-devel@alsa-project.org, Joel Fernandes <joelf@ti.com>, Jyri Sarha <oku@iki.fi>, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============5684851572397355779==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CEuZzS3A0DQ3Z2v/"
Content-Disposition: inline


--CEuZzS3A0DQ3Z2v/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 13, 2013 at 01:50:31PM +0300, Jyri Sarha wrote:
> On 09/13/2013 01:34 PM, Mark Brown wrote:

> >OK, and presumably this is just part of the main McASP register block
> >and doesn't need to go into DT?

> Not really. For instance on am33xx SoCs the MPU usually accesses
> McASP registers trough L4 interconnect, which is not accessible by
> DMA controller. For DMA controller the data port is also mapped
> trough L3 bus to entirely different address and a simple register
> offset is not enough. Naturally this mapping may change SoC to SoC.

I see.  I don't think this is a problem so long as the bindings are
specified in a way that can be reused with dmaengine, which I'd guess
ought to be the case if it's just specifying a physical address.

--CEuZzS3A0DQ3Z2v/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSM1EvAAoJELSic+t+oim90SkP/1MknuOjhEduVeGHFu/ahS48
TB5MrVcw0l6w088j6ky+pDelD0jdpwCKlT6Bi/xY7Hq2wEsuLTq3MI+QW23xvilV
bPzKjwr1uALOOwzBuHVEoiqfIrAsWgOGtGlljVhCMmZfhcwJbtgU+lukdVXItwve
qqTnqnTd7aSoCq+FXk4bCABVULzNiZ3KrhIwn7fJOmLOuyrCaQhDPO/xbxD61hGc
J+q8sS6lzGqLI1+4mHKaa0+3TA5+iYdtlIt0Qe5DqlWh9y7CEbjmA8OqijIXa+74
DpTnSqTYwPgLRgeX6X4Y77vebz8yLmW1JJhho+xy51ybcpmeVv0JfMIo+3KJXCZE
dI228UGAQv/LpFUvluqD9cuRH1sdRo9ornULAX7kvJ8rqepT+jvpj+JcXKDGDEm4
anRpl6TrixmIInv+/TKeO1vfVjJVazTAJK0DA2nWmcMpI7E8dZxKNDKGD6yOW7os
7cbbBztuQpSkZySLaeGOLFjbpMoB1+vJxGzJ3dlrqXTFPORq/QmR1UQ94XCvophH
dfoD8IDr+oHYYgLcWMBTU963ZPYnB+NRdDJHR9OIDIYkFqX82/F3VD72wKdCnT7k
BjBZ1WPgzR/ig+wKmC7oOsAR/peFvFi1GCxbCl7qmfvMybuOXlnEJrx2kgqPPveM
CuAf+co0NzvhEKxcBktX
=tHEY
-----END PGP SIGNATURE-----

--CEuZzS3A0DQ3Z2v/--

--===============5684851572397355779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5684851572397355779==--
