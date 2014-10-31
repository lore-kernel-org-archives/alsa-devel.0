From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/3] ASoC: Intel: add runtime power
	management support
Date: Fri, 31 Oct 2014 10:34:51 +0000
Message-ID: <20141031103451.GK18557@sirena.org.uk>
References: <1414739301-12659-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4909471032251380046=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C54422606A7
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 11:35:15 +0100 (CET)
In-Reply-To: <1414739301-12659-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4909471032251380046==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XA7quakUSnawneuz"
Content-Disposition: inline


--XA7quakUSnawneuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 31, 2014 at 12:38:18PM +0530, Vinod Koul wrote:
> This series fixes the device open pm handling and adds the runtime pm
> support. Also we fix lock usage while changing the driver state

Can you please stop sending so many different patch serieses for the
same code simultaneously?  I'm assuming that these are mostly orthogonal
but it's making it hard to keep track of what's going on and I expect at
some point they'll end up conflicting with each other.

--XA7quakUSnawneuz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUU2XKAAoJECTWi3JdVIfQCQUH/03baTEM6Q8vehmw+1EO7nHv
c9HytJAJoOyveq7J0jdv6UodKyJMtrd0JioIbK5LFEoRbC4d+9+G9Q8itiQ6Z5BG
q8/JhlnuoOMAkKMVjq+BnT4ZV/4rCYiVWM2BvsY8cFNTdyfFY0+Jg5SWNh3CQPP/
oCFBSuW1b7oQImKPf7dfte1a/o8Dm7fIpHJmPd/Gc7XJLHtAo25L8pYI7IA79lyQ
v4MvMasPwBWbJepNNpJ2FTq+AYX3TRAC5QpBtHq4Rm0/Y9aWv5YMtmjGoz7yXCJg
cSvex7OzJzPD5xkgDYjRTzBEkqwfqC/d7daWx7JX5NAd2EiT6m6mX3u02FZAMg8=
=0HhG
-----END PGP SIGNATURE-----

--XA7quakUSnawneuz--

--===============4909471032251380046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4909471032251380046==--
