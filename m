From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 06/11] ASoC: Add DAPM support at the
	component level
Date: Sat, 21 Jun 2014 21:34:42 +0100
Message-ID: <20140621203442.GB22657@sirena.org.uk>
References: <1402935191-18398-1-git-send-email-lars@metafoo.de>
 <1402935191-18398-7-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6653767228754055722=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C2D332617A4
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 22:35:03 +0200 (CEST)
In-Reply-To: <1402935191-18398-7-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6653767228754055722==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 16, 2014 at 06:13:06PM +0200, Lars-Peter Clausen wrote:
> This patch adds full DAPM support at the component level. Previously there was
> only full DAPM support for CODECs and partial DAPM support (e.g. no Mixers nor
> MUXs) for platforms. Having DAPM support at the component level will allow all
> types of components to use DAPM and also help in consolidating the DAPM support
> between CODECs and platforms.

Applied, thanks.

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpexeAAoJELSic+t+oim9sZ4P/3xluKFWIm9t8VmckpFwCyeb
U5Ece9BPpj4Axq6HvE+6siqr/S8+1+i3Gmg7xf2FG90yOohRK+TXiNm8vgJ7gKye
iX+ss8Ep2PHL5D/shU2liIzIAoHl6Rds2r4UAOmxRpkTXmFfY85Da/UFsqPJ4qk3
vxlFdgTv4N+ERg0VVSUEr4EHranCedo6pRl0PIyNRxgyva9Y9/oOoCgY4nzyiKeD
kP43EGw/io5FIqY/4Gn4vei4QLVy23gzRhhUUQKMnE+L95cI2wKtlOQ/90Hf52g6
XDMh6nmQwnJ3iu3/nPSNmFtKaCLh5K0OeCO15Rg++icKy7FOTi3XXuN4LnKUscmR
9EK0EfJlm6wtj4eFbxAsXEzHePsMqflZ3SscFtRsvfwmgGvCVepGZqmJejuaUbxI
wstp05edC8WgYaHEaowc156RgFSzutvTeFwYomPD1g31WpgobDwYsi78Ue/Irg1Q
MoUIKyMVFEF/JidRhjBLaehMhx8Q5zu6SaqFHvtEuu5PcBJB50INbWBki1ocJFpx
Cpqm4zmW/9XfrhEUGOVORth8QvrOMhSyTcC9olvA3tTvD5k+C09iBKHRWLs48NnU
k46WV5f45YJNqXPEitoJkorE+GQkzIt+4elpgyKmVG/DpXmr3guaH3D+4K6TG2Vy
B/kPVdj/8RI3gGwpqUQ0
=nWm2
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--

--===============6653767228754055722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6653767228754055722==--
