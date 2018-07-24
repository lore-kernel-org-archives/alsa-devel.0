From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: da7219: Allow pdata to specify a
	VDDIO
Date: Tue, 24 Jul 2018 17:58:35 +0100
Message-ID: <20180724165835.GO13268@sirena.org.uk>
References: <20180722232822.34641-1-djkurtz@chromium.org>
 <2E89032DDAA8B9408CB92943514A0337019830B8F8@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6512854260321817541=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E3D226733D
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2018 18:58:41 +0200 (CEST)
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337019830B8F8@SW-EX-MBX01.diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: "moderated list:SOUND" <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>, open list <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Takashi Iwai <tiwai@suse.com>, Akshu Agrawal <akshu.agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org


--===============6512854260321817541==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="68uOmRXIw+u8y5pO"
Content-Disposition: inline


--68uOmRXIw+u8y5pO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2018 at 02:41:26PM +0000, Adam Thomson wrote:
> On 23 July 2018 00:28, Daniel Kurtz wrote:

> > Provide a new device property to let such systems specify a different
> > VDDIO if needed (e.g., 1.8V).

> I'm not sure what the general view on this is. In the past it was suggest=
ed
> the regulator framework was the way to go to pass this kind of informatio=
n,
> but obviously ACPI platforms don't tend to use it.

> Mark, what is your feeling on this? Would you be in favour of some kind o=
f=20
> fixed voltage regulator representation, similar to the patch for the AMD
> platform (ASoC: AMD: Add a fix voltage regulator for DA7219 and ADAU7002),
> albeit tweaked to avoid asynchronous probe() issues, or is this a reasona=
ble
> route? Personally in my mind, and in an ideal world, I'd prefer just one =
method
> for retrieving this data in the codec driver, but that may not be sensibl=
e.

Yeah, keeping things consistent if we can seems like a definite win
which points towards using regulators here.  One other thing that
concerns me with using device properties here is what exactly we'd be
expecting to set them - I'd not expect system integrators to suddenly
start adding such properties.

--68uOmRXIw+u8y5pO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltXWroACgkQJNaLcl1U
h9DRbQf/f9qcI/FZGoXzYAQJISjJeHSz0eZ81Q6qSqn7jRcnPmZHqJjVfxmuoavu
sBvaTCi++RQhAvx6PqEpmnMoQpAQCto0/N8b8jcBUn+SKAPn90cvWwKpNnSCZksF
5t3hjH6SGq57f0vg3PwF4HcjSwRjp9NRleTsPqARgD8lbqKwHHW67PCmt3E/jG7O
09dXqpw28uH/chkRg/aH9ruiNBEufd6x6dXMXQMiEWMVam5I0JrH+o1BabG6uCF2
Big/B4j32E+i9jz1jbv8DRUVybFWxNaNXECV0dre7sPnBTOeJ6xbXGYhVEXuLB6Z
bIIjAwwTaaJd4KXnz//7b8wMmbpK5A==
=nY4j
-----END PGP SIGNATURE-----

--68uOmRXIw+u8y5pO--

--===============6512854260321817541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6512854260321817541==--
