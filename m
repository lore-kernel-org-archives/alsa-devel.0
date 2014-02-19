From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv2] ASoC: Intel: Fix sparse warnings for
	firmware loader.
Date: Thu, 20 Feb 2014 00:09:27 +0900
Message-ID: <20140219150927.GG2669@sirena.org.uk>
References: <1392818784-6248-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7928716884565382236=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 67F5E265893
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 16:09:58 +0100 (CET)
In-Reply-To: <1392818784-6248-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7928716884565382236==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JRiAoq/qu/J6dj1n"
Content-Disposition: inline


--JRiAoq/qu/J6dj1n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2014 at 02:06:23PM +0000, Liam Girdwood wrote:

Applied, thanks.

> Changes since V1 :-
>  o Fixed sparse warning for block_module_remove
>  o Fixed additional sparse warnings when building entire driver.=20

Don't put stuff like this in the changelog, if you want to include it
put it after the ---.  Nobody is going to care when they look at the git
log since v1 won't be there.

--JRiAoq/qu/J6dj1n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBMkkAAoJELSic+t+oim9W08P+wT12C8YlIFH04RvjZRIe2Kj
RfNJsY0uI9b9+vz1MHhFtWI8fCJP5M1TD+rDjpwR6wrAFmCaBXe32cssi9IOIixy
nODtav/jp5SSi6rkBWca8R77hT6m0Mv+6OG7ANQ3s+uK5tUCpX+auiX3mCTlX+Fm
8e3Zt9nTw9IoAxMs559yiGcyE+5ZmONedYgJvcnxBG90SYE+pwB9HsTPaOlrM9vf
miGBLGv2ebuNf8EF5Fcgkgbdp4lcnz5ZFwCabBcQirF1DiOC7MHT9GjW+i+nbSQt
PQfwQK/1X/R9VUbUPAR+wsnP/6dLs8nSGbiCHLHoOBIOkT6Ro8Xb00H6lZf3EUHd
NaCGA8X+L1CQYNrJCEK0Fsz37ypLdDbOctJsgCIp4HB+GS5/U3R87Dgna4yES8hy
oWnyjfo5bJdIyDafsB5K6fRVoaMrxiZCGncUG0Qw+R+1jOrO49xmTk66PGs6i5IA
DmQzGqcCuSL1qybpBVQokxgXmZb/r4OCMTWDRqspeMPs9XmDtM1pl+7AecMnuPgw
QnxtiLiSLNfOOxHhwDkfq+OEHeXD9y2VZyKuWKHCLRs5uUjH0GLsSIOaPZjTzwmd
WLAEaJEMHp1uL4q3wvT4SaVR0KvVFUS26jgDvdqxBFc39/wnf69OjiEaqg5Fx+xF
9kyxub2Ik64TbfH1R29D
=0mbr
-----END PGP SIGNATURE-----

--JRiAoq/qu/J6dj1n--

--===============7928716884565382236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7928716884565382236==--
