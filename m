From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC:Question rate constraint between the dais
Date: Mon, 19 Mar 2012 16:32:39 +0000
Message-ID: <20120319163239.GD5132@opensource.wolfsonmicro.com>
References: <64362.10.252.27.21.1331805184.squirrel@linux.intel.com>
	<CAAMvbhEoMYzgEwYo-461DDCps8UYBpUdRoNeFb4-e2b9Lyttvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4504680282369028194=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 831C010419F
	for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2012 17:32:42 +0100 (CET)
In-Reply-To: <CAAMvbhEoMYzgEwYo-461DDCps8UYBpUdRoNeFb4-e2b9Lyttvg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: Ramesh Babu <ramesh.babu@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============4504680282369028194==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jCrbxBqMcLqd4mOl"
Content-Disposition: inline


--jCrbxBqMcLqd4mOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 19, 2012 at 04:12:42PM +0000, James Courtier-Dutton wrote:

> A majority of the sound cards out there do 48KHz well, but not so well
> on other rates, so defaulting to 48KHz is probably the best choice.

This really isn't so true in the embedded space, there's a few systems
that only do 48kHz to the AP but generally if there's a fixed sample
rate it'll usually be 44.1kHz and otherwise the rates will be flexible.

> One of the most difficult things is getting 44.1KHz MP3s etc.
> resampled to 48KHz, but most MP3 playing apps support good resamplers
> so they can still talk to pulseaudio at 48KHz.

Again, not so true for embedded and burning power on resampling tends
not to make people happy.

--jCrbxBqMcLqd4mOl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPZ1+FAAoJEBus8iNuMP3dT3IQAIR0oA0P0tEhiO5WY+w/9Gcf
vfI1IL/YOvpDas7x4Pg6M4dJbTInCCeFsKJEkFzQoOnAdhHuEnF5geXhU/+GZv+l
HATzwdvZ4fA4g0K0VeY3PuQz/C6167nfVMNdxEDWS/UzD7OH42Kz4/a/Awn9CtIi
wfULSJeHIpYxAE3Mx9FBs7KUtuJ6hbGkw9u9tYD0BwXE1ewZ2YzzpojjxSKTf40g
tI0Lu9MQIhlB8m9fVOWjp2p2Myh6/gunsTRsl9I9yv9LDgYYsjddOV5wvrZvLNus
Ueb+GFvoPdffe4GTuTIBpKhBPHyNYzUQe+oMUGBp4mkSCKIdXSRctqc7k4MnaTWz
MKEz9FX3HsLfzEWTARCkwmpbQ4KlXNsG94Tl8ew1IWOzp9scYU4mJWqhZfXW2X8V
Oo3+pY8XcLUunV4xmDKb5T7NJc5J9WJcT//Qpkt08wlSoSuINcfjXtbsqSbpSKIj
4T//vaJrjiIz0J8wi9IsjxCAQ5v50o4/BiyQKJ7fwzkq7RKU57OAOr1RuirEcUAI
TwJ/HCwt9X8MOJ8KEzR83gfIhyqbnJDZHyS/14OjRBQWOnRdv3FAUTPR3A7PlQut
hExkycFLJvK6Qhi1SoNcKMUCCPNoAnKehSr+OYNA4ZWedFee9T5fUfUylmlpIe1v
j6vHp2Htb9jjTfjH0Cgk
=oXHd
-----END PGP SIGNATURE-----

--jCrbxBqMcLqd4mOl--

--===============4504680282369028194==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4504680282369028194==--
