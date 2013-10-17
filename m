From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ALSA: pxa: slightly refactor reset
	handling
Date: Fri, 18 Oct 2013 00:36:07 +0100
Message-ID: <20131017233607.GW2443@sirena.org.uk>
References: <1382004097-6350-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5992047346512410043=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D8178261622
 for <alsa-devel@alsa-project.org>; Fri, 18 Oct 2013 01:36:09 +0200 (CEST)
In-Reply-To: <1382004097-6350-1-git-send-email-dbaryshkov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5992047346512410043==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uKwnt1DTffWt333R"
Content-Disposition: inline


--uKwnt1DTffWt333R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 17, 2013 at 02:01:35PM +0400, Dmitry Eremin-Solenikov wrote:
> PXA25x also shows some problems when using interrupts during reset
> handling. Thus do not use interrupts on all pxa kinds (to detect codec
> ready state). Instead use a common mdelay-loop on all platforms to
> detect codecs becoming ready.

Applied all, thanks.  I'm somewhat surprised nobody noticed the reset
issues on the pxa25x before - this stuff all got really heavily tested
back in the day.

--uKwnt1DTffWt333R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSYHRkAAoJELSic+t+oim9AgwP/ipwJ98p8aRLnZl/oVl7bmSp
ouceVHaM/MBL0WpyiPNH2wK9FwkxuYKy06GKuk1mMwKRZI7jb21see0H8fhYEi4l
BYe2bLhuIgSDo8CaG1lRWB8687LvOKE0RDjBAnmMMjRzqmCCJUm9ksVvg5Popzan
7IhB4jIFQgdoyNO1Ra5XSkafMCtZLwbwHo/Xx8vrxoYrKNDsdHX2t4uRJUozARBx
xO8ThkNOVyQ1PgCW3fAc708glwM2BE6D9pkyfkqM0U0wuQfi736x78B2hRFNsPZV
izWfnNsJ4fWCGm+ZGBpskGs70Bza5vkie112x4KGMjILnC6c3X/X8bd3n/as7h90
zt3s5WSCp7cX+XQfTm/7XM9F1fdg0UI9q0pd+0hHykdwFD7ht0ABgyJYhh6R/pDB
qBNs45CVdTmziVJCoUz8yEN9yV2zzg47j2J483P5uR0hHlixVQ9KCCNWgh3tbH+6
rghXzCURrVpS6Pv8qFP1EdhdmgZUfNzRybOkR6SivG7vCzkuW7nPq9Tttk6iDnh0
BA/Rln/QXwQsEABYJaAfAXgt0gP5OUP9LQRFOLpcYUSUBWZ9Aos9+4WzIvzojDEO
EcLiF2yPdGAgPq9W5JlyDjgLY+0Vasm/lpyoR/l0LU2PDOxbigltZMhZ46dj9FFI
AtZKLN44fSGBdGkO98fo
=2L+e
-----END PGP SIGNATURE-----

--uKwnt1DTffWt333R--

--===============5992047346512410043==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5992047346512410043==--
