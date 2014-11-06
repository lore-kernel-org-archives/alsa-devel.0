From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 3/6] ASoC: Intel: mrfld - add shim save
	restore
Date: Thu, 6 Nov 2014 12:36:52 +0000
Message-ID: <20141106123652.GA8509@sirena.org.uk>
References: <1415098520-14113-1-git-send-email-vinod.koul@intel.com>
 <1415098520-14113-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3966275092347625513=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C98AE265230
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 13:37:03 +0100 (CET)
In-Reply-To: <1415098520-14113-4-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3966275092347625513==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3gIr+u2NK768I+f"
Content-Disposition: inline


--u3gIr+u2NK768I+f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 04, 2014 at 04:25:17PM +0530, Vinod Koul wrote:
> In ACPI platform we need to save few registers of Shim on suspend and
> restore them on resume, so add handlers to do this

Applied, thanks.

--u3gIr+u2NK768I+f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUW2tjAAoJECTWi3JdVIfQ8rMH/jRGEOLttJy9OGWiqRqu7GRf
xV1ck+cVDOTG+Kwm1zbAo2k11fYtNNzbzJ/P0j1ZggcC9NIh8uYOksKdmZtcGxi1
Vi3Ml9TJA5BCC9lj5t6ybLFacau+92pxpC8Mv7xDRdAtSHccvI/ZDiej3Cskeytm
XVUZ0qnxtpbeF2ncB3plLJzFA0Fs+0mRYFvAUaRydgACX/T1S9uleAmy/gLiGle3
d3v/KV5gFzUEx3uZX+SW8+Ra+cZk+KhuNlamrYRvgtKRN7Hpj93LsiyhuWy5vMVB
+msWP9bisOnC3Ktc3bx2xFlioDwyezNDCkBQefpKeCepJESq0QWTY0HZ6AZOWk4=
=eU4F
-----END PGP SIGNATURE-----

--u3gIr+u2NK768I+f--

--===============3966275092347625513==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3966275092347625513==--
