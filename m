From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 016/102] ASoC: wm8995: Remove superfluous
	const
Date: Thu, 20 Feb 2014 10:58:30 +0900
Message-ID: <20140220015830.GE2669@sirena.org.uk>
References: <1392723148-12597-1-git-send-email-tiwai@suse.de>
 <1392723148-12597-14-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7544242378619391323=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B4E1D2656C4
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 02:58:42 +0100 (CET)
In-Reply-To: <1392723148-12597-14-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7544242378619391323==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E2M0Wzx5stW0r4fF"
Content-Disposition: inline


--E2M0Wzx5stW0r4fF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:32:28PM +0100, Takashi Iwai wrote:
> As SOC_ENUM_SINGLE_DECL() itself contains const modifier now, we can
> reduce const from its users.

Applied, thanks.

--E2M0Wzx5stW0r4fF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBWFDAAoJELSic+t+oim9mpMP/14F67kaGWyN2IdaUipFiC1q
RnMrZ0fFxq3upRPdr1StcYoU47KpwUE1bS49RnrQ9V9OONgEo2C3GKnQ2Wx1KpO4
L7BT4FpROjEeWoG/mc26wsW949H0dNz1beaaByXiBjmZLbPFiSML5K8k7jUD7cdz
20UCg0BKDOf0XN+Oa7wfaBs+zxJkOfUmIIXZ0E94tifbJzu+LqD7Fa1VO1hmh4as
tIeFXe5um0Fc0wjDefCbSQrEZTE/C0ZTPCBDRT3vmttGDr3LkzuZqmY2yr2BE3L3
dXWmhrPo5BCsInUvhKS06mM0Qog+CHQJ1Ac8rVHNbZC9063bD2GYNIKP+02d6DGy
zFrDWiR0CKukanlBB1YqEKkcRe89dGgI1AuNy0tnKREOTM38UH9djPTYrtRcl7Dy
gCJB5uDKWVI/7vCyAvXQ0mMtp8bZrXjRz2nf3oulJSwKUvxEBySs/F2iFpLM8kjN
826zVEIumt409P1mzw9lVQFWkhxywo0l68ELfLM5COKgMAlNrjQJngreceeX7lo3
ThkijMK79OTpuwPOjWev0MC7vlATtkINZoa720T5yR/W6pj4H8hgoz8cNaMKUgR8
oJcdy+8y6+xLSw4shARq7feXdjkL6dvFeFb2cX6mWT7gMPjqdugK50YrTPFThe9G
/69Tma9Qn7BzUnJ6vNBs
=/Yq0
-----END PGP SIGNATURE-----

--E2M0Wzx5stW0r4fF--

--===============7544242378619391323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7544242378619391323==--
