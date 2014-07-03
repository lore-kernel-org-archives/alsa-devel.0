From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: adau1701: fix adau1701_reg_read()
Date: Thu, 3 Jul 2014 19:43:02 +0100
Message-ID: <20140703184302.GP410@sirena.org.uk>
References: <1404399096-4056-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1016329070879169273=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EB511261A74
 for <alsa-devel@alsa-project.org>; Thu,  3 Jul 2014 20:43:19 +0200 (CEST)
In-Reply-To: <1404399096-4056-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org


--===============1016329070879169273==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pw8vfKuzsXn95o6p"
Content-Disposition: inline


--pw8vfKuzsXn95o6p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 03, 2014 at 04:51:36PM +0200, Daniel Mack wrote:
> Fix a long standing bug in the read register routing of adau1701.
> The bytes arrive in the buffer in big-endian, so the result has to be
> shifted before and-ing the bytes in the loop.

Applied, thanks.

--pw8vfKuzsXn95o6p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTtaQzAAoJELSic+t+oim9Zm8P/3vwcFCdi0ulop7jFuTn1/bt
tyfV94iYmSAnyuO94qaaL1RyFBgU94vWBKIEpg+m9Y0hQ120cw4IscTHhjIdUwOL
g6+2Dmi59mZOyJRwGIwZpATVPfiiAIpx0Cq4Y/FR48ozjlMAx4pjXOSTEjhozkea
E8Llarp4scQKu2/NR/aO8PFV1LfrjjSzv4NDIEz9VkRAIz7OPrE3pP8OPzfXjADO
I3RFmNYh3KBwz4uAHqZwcMxzzD1R219xbylBFFrRcsRJQK7bUEPemeMnoIdwRjFo
Zj4aHx+MtUandiukEbSjDndADNbM+eV2Rp2w5nLasJe6/mxkwO8EUoyiOo4Jkmg0
OckNJtR1KKmoDsWnxtKgKvlHAFrgRKbCufoh4bGAFqw/JDflBQc3ZyIYqu/tLvws
//yn5uiCaFpgmvvvImUjWPmqhRzSJcegCupevTRAoisZMzg8ADkFtZackep6Pmjx
NicKYV9abFL7tSh9r+HIoTw3F5+LKE1YCHLN1unXuPA12ybSloy54MypWX3ZufJh
DIoPpEwbtpXgbsjJ+NT7nm79+sxXz1ieYB40OxkzPu1hhd6MpRmwGMRewRrj0OAn
el0hIZlQmNynRBflPDJ65nhx/kC0iFnXEspGQdss8lkVR2Q0dij5JOdJ20ocxedt
Mg5drspFTj5Yu4scOBYA
=JyUy
-----END PGP SIGNATURE-----

--pw8vfKuzsXn95o6p--

--===============1016329070879169273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1016329070879169273==--
