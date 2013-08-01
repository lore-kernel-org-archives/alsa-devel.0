From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ALSA: Added jack detection kcontrol
	support
Date: Thu, 1 Aug 2013 09:24:28 +0100
Message-ID: <20130801082428.GE9858@sirena.org.uk>
References: <1374863133-6745-1-git-send-email-eu@felipetonello.com>
 <1374863133-6745-2-git-send-email-eu@felipetonello.com>
 <20130726185458.GX9858@sirena.org.uk>
 <CAGrhNMy7qZ8CbAjFX5Gv8OqYkit+Eqzr2zZTYXeQ-cNO22+pTQ@mail.gmail.com>
 <20130726224813.GB9858@sirena.org.uk>
 <CAGrhNMwGdMwhd5L2gGxQ=N=8nFk4L5txYmhEtLBVcFj-Etphnw@mail.gmail.com>
 <20130727122524.GH9858@sirena.org.uk>
 <51F9DA8B.8050302@felipetonello.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0627781910912497770=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B3FB9261692
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2013 10:24:37 +0200 (CEST)
In-Reply-To: <51F9DA8B.8050302@felipetonello.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Felipe Ferreri Tonello <eu@felipetonello.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Wang Xingchao <xingchao.wang@linux.intel.com>, linux-kernel@vger.kernel.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


--===============0627781910912497770==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="efNa9iaz7avsrDl2"
Content-Disposition: inline


--efNa9iaz7avsrDl2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 31, 2013 at 08:48:27PM -0700, Felipe Ferreri Tonello wrote:

> I did that but I'm not happy with the control name. Usually drivers
> add jacks like: "Headset" for a headset, "Headphone" for a headphone
> and so on.
> I did the following: control name is jack name + (jack type) + Jack.
> If jack type == jack name, don't add (jack type) to the name.

> Any suggestion how it should be?

That sounds reasonable as a first pass, might be worth doing a survey of
the existing users to make sure it doesn't come up with anything too
horrible.

--efNa9iaz7avsrDl2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+hs4AAoJELSic+t+oim9qWoP/A3YR0hOi8pJ+KH0OEFATk/H
O9H0vtB8fbeQIJspJLvvRa0bT4RORjOqNMMmi1sIQtEF3QtwjdaFIWZJ14wYSHnd
QRqZadPo4BMHuVhuSrs34/Sy0/VAQpn/zHrDSqKpxgNG9RlOChAlPAohxYKRL7ju
cCQUxSkVK511vuCQoVyLhvNPt/yDAK/KqvQJ9tvRY3JGnENYM20COham2nR+IcQW
4g22CDmPPUHQz5APuEacZlxsIqbG4ZGFtCx4APYQ8OAitjZvVUFpRjBmArtxDKpa
UzYBRveiG1oYbRCpCAz61nYHuJcTc4cBb2txiKBaaBErbF1h1IR0hi1y1TJP97d8
zuY8WG2TywzPVfA7p902AalZpVCPjDxinu/z+HSerX41+G/OS137tD65rfcCSDFc
vFvRncp2y1um3Erpr0hj96KH9IHMvJzOmUovqLCgnRgs0CnTO+RMjdDvgYSbAozz
x/1c+t5n5OsJ2Fs5gYLPczPUfjzi6wbOSWyNO2PPpKDOG0pHfT/oY2IQeC0r3FaD
aZ08gI/i/mvnPJ+6K7i5mNHkLVr8W0Jzxkpa5ci0DQYitn7BEIQBOLqeEjdRoOoO
CmYvuzgdaES3Gxp+J+QVXJSeh3lkpVi7UF30LoOgfENZAMP7Kxx2csHcG6/LojX/
acUHoVkPdlc0yHIaWs6L
=US9D
-----END PGP SIGNATURE-----

--efNa9iaz7avsrDl2--

--===============0627781910912497770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0627781910912497770==--
