From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 9/9] ASoC: sti: Add IEC control
Date: Fri, 10 Jul 2015 19:06:47 +0100
Message-ID: <20150710180647.GW11162@sirena.org.uk>
References: <1434983473-25092-1-git-send-email-arnaud.pouliquen@st.com>
 <1434983473-25092-10-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6512840844737412786=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D41D8260483
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 20:06:56 +0200 (CEST)
In-Reply-To: <1434983473-25092-10-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, kernel@stlinux.com
List-Id: alsa-devel@alsa-project.org


--===============6512840844737412786==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Cmf/VlDi8PytwGQJ"
Content-Disposition: inline


--Cmf/VlDi8PytwGQJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 22, 2015 at 04:31:13PM +0200, Arnaud Pouliquen wrote:
> Add control to configure IEC60958 settings.

I had one question on the rest of the series but basically everything
else looks reasonable - I've applied some of the earlier patches, where
there were comments can you please send incremental fixes for them?
With this one there's no technical problem exactly but it seems like
something we should have a standard userspace interface for so I'd like
to check what's going on there and propose something standard if there
isn't anything.  It should at most affect the control naming.

--Cmf/VlDi8PytwGQJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVoAm2AAoJECTWi3JdVIfQbK4H/3tG/NieD4k8BqHk6b+nG265
WZDLdF1MUA1Kx6rTnivbiBuZEFlAeHlq03OmDQ/rB8TcQcFKtEMDthBc5kG3C7+G
fl1NTYfJCUuJeSFj019voPdOCZfVjfPYz0KzSxmpjQjHMLzyZMzQyYhEY1uA4EDV
fpcRfB9w64mlTOFnCZdWMNX2B0ORpl9GBzTBNeZkNOl2ghJB5sfxWGRrFKzgXaql
RuW4vO9UHcq27vzXpAm4uo7sQFrWbxrPhzZTE5UJu4LobQQAlSsfXVCqJcBsWnQ4
bSNA/NP3ZzdSXcULbRoglLSFFJRaXFBppBXQY9abVmdWraL+UCBufV8a2cLNyNs=
=ufcB
-----END PGP SIGNATURE-----

--Cmf/VlDi8PytwGQJ--

--===============6512840844737412786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6512840844737412786==--
