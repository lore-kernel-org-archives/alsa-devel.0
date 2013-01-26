From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Add support for platform and
 CODEC drivers on same device
Date: Sat, 26 Jan 2013 17:20:21 +0800
Message-ID: <20130126092020.GH30594@opensource.wolfsonmicro.com>
References: <1359020951-25904-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1700213307425705063=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 58C95265265
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2013 10:20:30 +0100 (CET)
In-Reply-To: <1359020951-25904-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1700213307425705063==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dx9iWuMxHO1cCoFc"
Content-Disposition: inline


--Dx9iWuMxHO1cCoFc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 24, 2013 at 09:49:11AM +0000, Charles Keepax wrote:

> So this patch will check for existing widgets during soc_probe_platform
> and only create new widgets if no existing ones exist.

...or as I was sending that it occurred to me that it'd be even neater
to share the DAPM context, though that's much more refactoring.

--Dx9iWuMxHO1cCoFc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRA5/MAAoJELSic+t+oim9ugAP/2QkA6h/wwjKHRy0/BgfAgj8
kSTOrMHtoHccHVzLkxx0GtMl2mc3hz2yxqKQt5C4bqbukvtGNlTOr0e1d/aLiMhb
KsfJGi0Sw/usQnzoIduCG7Lw0tgWxjeOFeR8oFGyfhB37iTzcyeRdHvRVkoN7p8D
9S/E6515L/Ky1YbCeKFGc3Tw2mrnB9AhmfoufTkam+Tlk3ac+slglm6IvQWp8vEh
X/Dezgk74RU81G8/8xsEGdnJsO4AIT2nodq1hliX8ozzQRFvGPe/IIy9nRYR6RQ5
8tltZ6WxZrG+56EIahjc9t3dflhkpkDGBbsMl+Vo9NtEF+0l1M8ozmIMk1YhuVbT
fUNDFjLuVlxYo/SJX57f2d/pZpmduJvz2KoA6T3ZvR2suICpLIR78Rrn+zmtyhMJ
xtWydVTbptUQ3w75jhVmZkGMxhGUUCOOjMEHSxkJOX4NNBsDM/9vp4c97hKIY01Q
HMa3t6c402ReYzAK5dHa/Tw0stBVHTaKS9P95XlJlEyWh2Cuig34hkwrSv5lYO5G
IfTJNQwIibKEerBrBnXp3e5MIsy9vFGVXozrHX+RQ8ePb5OY9yGfPGfCvy0zm/I0
V7AOP9F0M+1+IepEa3KzHa3k/9QpF4VzoSmDdE+0P78O49lSzWdA8wCIiQmRYi9S
PKfkFj2qwlBZNCIOKtoW
=nQW3
-----END PGP SIGNATURE-----

--Dx9iWuMxHO1cCoFc--

--===============1700213307425705063==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1700213307425705063==--
