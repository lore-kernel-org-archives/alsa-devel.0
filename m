From: Vinod Koul <vkoul@kernel.org>
Subject: [GIT PULL] soundwire updates
Date: Thu, 6 Dec 2018 22:46:21 +0530
Message-ID: <20181206171621.GA2847@vkoul-mobl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3947648525217484665=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 14C8C267AF2
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2018 18:16:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3947648525217484665==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Greg,

Please pull to receive a single commit for soundwire tree for this
cycle. Am off next week so sending this bit early

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-4.21-rc1

for you to fetch changes up to b1635596860dd3229645e41276f6c83ca788e4c1:

  soundwire: intel: constify snd_soc_dai_ops structures (2018-11-12 15:36:0=
6 +0530)

----------------------------------------------------------------
soundwire updates for 4.21-rc1

A single change:
 - constify snd_soc_dai_ops struct by Julia

----------------------------------------------------------------
Julia Lawall (1):
      soundwire: intel: constify snd_soc_dai_ops structures

 drivers/soundwire/intel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--=20
~Vinod

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcCVllAAoJEHwUBw8lI4NHR5MP/27rtEHHXFVptE40cmGuohet
9UD9ZscmPsOm69uNV7lZzbg8b77U9mrZ4Vz5YSCPOpL1bDNnPz1WDOGr0+bBCqug
rNon7bLGbJmcCsnSS1tMevF1Jy/AgGLXUWOglTOkW1DUohJVPf4iEVKDG4yNR2hU
AJKtQRh2O9muVXU/J5abom7B4+OevUkf3jMgIZulHQgXiAUfIYii+weK79o4ic32
N+k3R4QOSCztcViKSHEWVs2AK7bhZ81f43Rr/P+9lht8yq5+3PLTBeAbBACil+iA
nm4ZosrefngTz+FN5ncaDBHZDo2jjsf9JwxcjVDjFvUpOvdCQ1b9TIWgB48qKrss
JiIEH+UfSi6INrYk7IEyMlsyCGxw8FX/Zf4CMV4qgwbmZf6rEsKsAj1uIhA2vCsp
1LdF8P5YB3Y5kGbce3gAATITzTfxjaUczx/UyxU0PINeW2biQjhsyW0Ng3PnbjYB
7kGp2ssjARfgNszceAi6EQxRO3o2uyNeml2Q5wEL+IRuVMoiRd7GYaAnqKBNiTxV
7jRfitsx0bByvt92bRWMGmhzJGevBuV3MnQRUmjKQzZE44dIblOrsHIel3/IqH9c
2lLiewhsS5KOicq75TkLE6gnq4jIgb4kIeHy59m+Q4NLYwAJLQkO1ikFFrfRW1yU
VkZmpWh69ZDX8L3SsZm5
=Ae/g
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

--===============3947648525217484665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3947648525217484665==--
