From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/30] ASoC: hdac_hdmi: Add support to
	enable MST audio
Date: Tue, 17 Jan 2017 17:54:42 +0000
Message-ID: <20170117175442.knusnvczrh56o5d2@sirena.org.uk>
References: <1484589477-7630-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4455615597037549178=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B1EB226725F
 for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2017 18:54:53 +0100 (CET)
In-Reply-To: <1484589477-7630-1-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: jeeja.kp@intel.com
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============4455615597037549178==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wr32l73hyerjfxl7"
Content-Disposition: inline


--wr32l73hyerjfxl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 16, 2017 at 11:27:27PM +0530, jeeja.kp@intel.com wrote:
> From: Jeeja KP <jeeja.kp@intel.com>
>=20
> Display port 1.2 introduces new capability Multi-stream transport (MST)
> which will allow multiple stream to route to single display port where
> multiple monitors are connected. Multiple monitors will be connected by
> a MST Hub or a monitor capable of daisy-chaining.

This is a *really* big patch series.  As I've said before please try to
keep patch serieses down to a manageable size, 20 patches is getting
quite large and this is quite a bit bigger.  It's a lot easier for
people to digest things in smaller chunks and it's a lot easier to push
something enormous that's going to take time to get through to the back
of the queue when you're short on time.

--wr32l73hyerjfxl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlh+WmEACgkQJNaLcl1U
h9Cvswf+MvM80sz5muhi/lRphEDakmwdfVlbgJtU3/3EZ7EHH5jJAzB1rtaL8oDx
yOI+eZYw/0jVUUFhNkm6UOny43WrdP7GW3kTbGGYkeQFNRYWiFfXEw3im9rnewQ+
LBAZh3hPbLLhI+lspFgWPVfbhUWpxiBPwc/YldPFFsAznNSDwmYEbmUgyLO0tKOC
t1JGa94txp4cx+EDpZLv0Eub06oujEgz7inT6OVsoD5la1ZFTOV/AA5nxuxD+Y4k
CtGRj2VmVnbNGRvWPXW4l0VTmywhErAVXOBIodSgpY+JxbDIAG1TNqhDwWq44msA
JXuQQOKdqt+RCR/aaB22/999XPg4/Q==
=bzII
-----END PGP SIGNATURE-----

--wr32l73hyerjfxl7--

--===============4455615597037549178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4455615597037549178==--
