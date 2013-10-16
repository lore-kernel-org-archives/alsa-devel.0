From: Mark Brown <broonie@kernel.org>
Subject: Re: Audio Miniconference 2013 schedule II - Edinburgh
	21st October
Date: Wed, 16 Oct 2013 11:28:57 +0100
Message-ID: <20131016102857.GE2443@sirena.org.uk>
References: <20131014161003.GC2443@sirena.org.uk>
 <20131015164408.GQ2954@intel.com>
 <20131015192636.GW2443@sirena.org.uk>
 <20131016021732.GU2954@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1379890047869275793=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C154426510F
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2013 12:29:03 +0200 (CEST)
In-Reply-To: <20131016021732.GU2954@intel.com>
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
Cc: Colin Guthrie <colin@guthr.ie>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Arun Raghavan <arun.raghavan@collabora.co.uk>, Liam Girdwood <liam.r.girdwood@intel.com>, Tanu Kaskinen <tanuk@iki.fi>, David Henningsson <david.henningsson@canonical.com>, "Bossart,
 Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1379890047869275793==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ky0ujAyBToem0Xjc"
Content-Disposition: inline


--Ky0ujAyBToem0Xjc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 16, 2013 at 07:47:32AM +0530, Vinod Koul wrote:

> On 3.4  was hit by DAPM sync bug as DAPM update gets triggered without holding
> lock in few places, after realizing the problem I sae the fix was availble
> mainline, clearly this should have been marked to stable.

Yeah.  Changing locking makes me nervous, I never know how that plays
with the out of tree stuff people have - when DPCM wasn't in mainline it
all seemed especially fragile for stable.  That's sorted now of course.

--Ky0ujAyBToem0Xjc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSXmpmAAoJELSic+t+oim9KSgP/iRz88vERH6pe+gosiqXpyRj
Jw6hIOpHW+HjzVNrk9UEqUOOhOOt7lOqOFAJzhXrlA3Vp2vXn8F0CQMn8hAGZ0vJ
YfQLdHrHhzAeCyW0cgL9ZnVvACwwdQucrnzv4mkk60s5wCGs872+XbMJmuODRC+b
cBT6e4j7oDJHKNOFT2tQ6KW28iVc8uNJnIt3iPA7VurvO4VB1WmJZ1JxSK5wA35C
ape89oWRK+B/ajEICsOwEzob+jFBn+fWVr1pVBqsW6biWtjaSlH3eJ0Pgk2N8PiI
lbPr1sAf5NSq3KF+cLgdjBqFViNDFDepcszpXyIQdLZZ6tW3N0eAvFGKWV4bvwNB
515mRair+eZMPs1KOTItfZStE0Y68oqe1+AYJuNjjOlczTjNPAOmxP/khkg3D0el
2w0BWNWotPSrQqVBmLuycDgxRj6Q+zhxMnzDndS0ALVMB1ZzrktvhnDbBY0P1VtS
WizSecQsksbcZu+KzsrbwXo1QKibv2RVKUXFprEzpcwxCIYhv4Jtn9crctpCVU5K
pPkVH+Ktl2VhLuJ1oq3d26nP8PdjzzKc7aZwmvBxFMmPc6Bz+5BVJCviNyxKdsin
v7RiunQ7iQJMMUTXqj50GRJGlvt3fp9T7+12G3knucl8iDuwpRKjwmPfcMddC9Qr
h4lh3d3LRlHoQH0WIEc0
=MYmV
-----END PGP SIGNATURE-----

--Ky0ujAyBToem0Xjc--

--===============1379890047869275793==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1379890047869275793==--
