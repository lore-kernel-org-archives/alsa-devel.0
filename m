From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: add generic simple-amplifier
 support
Date: Tue, 26 Jun 2018 12:28:38 +0100
Message-ID: <20180626112838.GA1779@sirena.org.uk>
References: <1529924777-21136-1-git-send-email-nicveronese@gmail.com>
 <20180625112144.GB9413@sirena.org.uk>
 <1529926289.2900.26.camel@baylibre.com>
 <CAGb2v64D=DC02vVfwJj3XHwQTcAeS6y6fujdj2v=f5O5QHmLxg@mail.gmail.com>
 <20180625123952.GJ9413@sirena.org.uk>
 <CAGb2v64v4DEsXL4M2SsjjABgvOwANDQfGOTum0kL_JMYJ+vbug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0771195599646330165=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D4C7A2675C8
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 13:35:52 +0200 (CEST)
In-Reply-To: <CAGb2v64v4DEsXL4M2SsjjABgvOwANDQfGOTum0kL_JMYJ+vbug@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Linux-ALSA <alsa-devel@alsa-project.org>, =?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--===============0771195599646330165==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 26, 2018 at 11:20:37AM +0800, Chen-Yu Tsai wrote:

> Also, would it be possible to specify the name or prefix of the widgets
> from the device tree, such that it would be possible to have multiple
> instances? I'm thinking one amp for speakers, and one for headphones,
> each individually controlled.

There's already a general facility for doing this - name_prefix.  I
don't think it's got a DT binding yet but no reason not to add one.

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsyI2MACgkQJNaLcl1U
h9DLRwf/TjaCvllZkFZnlMyz4J/gQNrGrqFB1VeFMvT5Q5Q/xTWr/TcpmiJDBX8T
Z/lOMLgyEIjPedjcgX2ik5UIPZ2j5ID4t3HvD+tMgiosz6Vk7l+ycq02xymtxCqD
42kHBd4UQMGwwoI9ylCT5EJqhKegwpAmtwjtC3sasoLuOw02R4ZimORG6z8jGLDz
w+ZYOs075apWojicUGOSiLy/COGUe7ddDQOH22os4HNtaYVxZRruNx4DItywrCAW
oRhVCJEZ9bmXDKVK56cDrlmKz6RRkpmG3MNIdwI0GeF5NDvio41ZW3xDvn4uN+MW
JMpKCzpmiv2MxgBwz6AUiZT3x4vyBA==
=Ubra
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--

--===============0771195599646330165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0771195599646330165==--
