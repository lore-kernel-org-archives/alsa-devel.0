From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ALSA: add new alsa control byte extended
Date: Fri, 29 Nov 2013 11:25:05 +0000
Message-ID: <20131129112505.GR27568@sirena.org.uk>
References: <1385699397-18662-1-git-send-email-vinod.koul@intel.com>
 <s5hbo13fy6c.wl%tiwai@suse.de> <20131129074459.GE8834@intel.com>
 <s5hzjoneft5.wl%tiwai@suse.de> <52986123.5040004@perex.cz>
 <s5hsiufedxu.wl%tiwai@suse.de> <52986823.1050600@perex.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3575406747393615097=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A43D26556D
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 12:25:11 +0100 (CET)
In-Reply-To: <52986823.1050600@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3575406747393615097==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/Isdj7O9hWi8F9Bn"
Content-Disposition: inline


--/Isdj7O9hWi8F9Bn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 29, 2013 at 11:10:43AM +0100, Jaroslav Kysela wrote:

> driver). But if these large data are static and they are not expected to
> be saved (alsactl), the control API may be extended using a new ioctl or
> the hwdep interface with some custom tools may be used.

I'd expect them to be handleable with standard tools, from a user
perspective these things are just another setting that gets applied when
changing use case like volumes and routing so manipulating the settings
in a separate place seems wrong - at the level where you're applying
them it's all part of the same set of data.

--/Isdj7O9hWi8F9Bn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSmHmOAAoJELSic+t+oim9x2IP/j2YLJV6yvES38i6b1kjpIXG
3jnzS0l4KQEYtnrz9ycx4XAOUJ2evACHw710iZY5uMu0JaWijT4D8L2oesGLNHd5
ZDZZ81VqKDQWw+usHIvxC1KNjvaIdEPUA+Z8KDi28v6INJexfXClRuODhQuLVPAw
2TNbRgbdhQdXVpnJr0uJUQ/bI/v+rXB1x3z1zppVY4XzK6FAhJ1VSjmzGswQKlwr
WF3mwXRryWJQWgEKp2cMXsl8tsFud0qu6/I4M4p/bV+lMk/2mRRpjvdOwT99gEbT
OCyURR80AtSfi5mB5rkQuIB80c9pjx/5UOVjpShYmFLYKQjVFIHcxjw7HkPDmdek
ogv7cmkOuIlcfClpEp0mWDPNpVNX6F5DQv7rC8lwoVw61JpBx+xicxmvpYLXEf4U
SmyQ5Gje8FerZBZLRNFPL7z/yHRAh2jCW1ex4PdIQeSOK896bmXhAU3K1s/nO2IV
dxBfR6f2/IKEM5yR8vfmTlI1VSva3GzQ3F137oDZzF5df02PaGJuUXoq4ru9YudX
VcYPSpj4l015Ew2wdmbpNqmcIANbysOBBugDkYWx2rA+IKR3en14fqhr2OzC7lvz
BhepaYVXGrOHCkoFeD6Kg3cjzxCVpi8vKfZ5Ffea9zsn9u/3llnYvrasVarAHwZZ
ClJt+ga+pf6Ce8y1COQ2
=v5yh
-----END PGP SIGNATURE-----

--/Isdj7O9hWi8F9Bn--

--===============3575406747393615097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3575406747393615097==--
