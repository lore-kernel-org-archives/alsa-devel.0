From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: topology: Reenable use from userspace
Date: Sat, 31 Oct 2015 11:54:48 +0900
Message-ID: <20151031025448.GA28319@sirena.org.uk>
References: <1445830900-1752-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8170037242997229825=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C7608260462
 for <alsa-devel@alsa-project.org>; Sat, 31 Oct 2015 03:54:54 +0100 (CET)
In-Reply-To: <1445830900-1752-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>, Mendong Lin <mengdong.lin@intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8170037242997229825==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Qcw+NG9yjQzXdZsc"
Content-Disposition: inline


--Qcw+NG9yjQzXdZsc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 26, 2015 at 12:41:40PM +0900, Mark Brown wrote:
> We had inserted a #error into the topology UAPI code to ensure that the
> ABI was not adopted by userspace while final review and testing was
> ongoing.  Since we are now comfortable that the ABI is suitable for
> production remove the #error, future changes will include provision for
> backwards compatibility.

> Are we OK with this?  Looking for some acks and reviews...

I saw a reply from Vinod but nobody else here.

--Qcw+NG9yjQzXdZsc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAEBCAAGBQJWNC13AAoJECTWi3JdVIfQ3fMH+Mwfc07cOe6Rv/NbPb8fIC6W
H6Xrv0qh9ey1njNv0eFOYfKVIL66grxfnrZ7abL1s4xrQWzAuhpW6I+vCt3eJ6Nd
cyl5IjWfj5iic6LfE48VCmdxIEMWQSNBouy3Mor8M2FBPwpgxaaN1yBtGtXBkFLN
rnp9fxbKA1fcDOQ/njzV8OGXE4f/IpC/U/I5pj/yC1bvF91fz8eVRNxWAcW5DOgj
k4aOQpCs8vgkMK5gptvS57ojiK9OG30fc8APQpI/jI8q26eruRkZAMVCgk19xH0U
XIIktmYNg8E9FhmbyQkdKYOBsReqbU7u7wDkKwOJ/ecaimKQSfADRUnLub218A==
=7DMl
-----END PGP SIGNATURE-----

--Qcw+NG9yjQzXdZsc--

--===============8170037242997229825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8170037242997229825==--
