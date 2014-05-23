From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: Remove dependencies of boards
 for SND_SOC_EUKREA_TLV320
Date: Fri, 23 May 2014 12:24:56 +0100
Message-ID: <20140523112456.GC12304@sirena.org.uk>
References: <1400843461-24991-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0425201680499880757=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CD7032656DD
 for <alsa-devel@alsa-project.org>; Fri, 23 May 2014 13:25:09 +0200 (CEST)
In-Reply-To: <1400843461-24991-1-git-send-email-shc_work@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0425201680499880757==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8OnGB7eB/1rlkWaq"
Content-Disposition: inline


--8OnGB7eB/1rlkWaq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 23, 2014 at 03:11:01PM +0400, Alexander Shiyan wrote:
> Eukrea-i.MX51 board was converted to use DT, ie we no longer have a
> MACH_EUKREA_MBIMXSD51_BASEBOARD symbol.
> Transformation of other boards planned for the near future, so this
> patch removes all these dependencies and restricts build of this
> driver to ARCH_MXC.

Does it actually depend on ARCH_MXC or can we also enable build with
COMPILE_TEST now everything is DT converted?  Looking at the code
there's a lot of machine_is_ checks in there so it's not clear that this
will work well on DT...

--8OnGB7eB/1rlkWaq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTfzAEAAoJELSic+t+oim9PZoP/085JnYnO5zTIK+35pf3coZW
KIPb0NLn1pRKfv3Dq2Ldp0vMSAVD2bdgN6Gkx3/yYKuW+rZyZX4XSyDUwIaRT+u5
ndS5S1OBgS7iPy81tz70Mh/x3SBdB9Bu3vXTuJvJmo+tN6AHjmr1qBwUM7qsGJVN
msWrN+1WJSeEVdsdnakNxeqyaulG5RugOlOLJtheMd5J+8hx/+zdNmQBPmg/mtkH
sq/m+kglbicFp0FFRkvn6BDYMvJt5yi0BzUL1f+au/nhR23RkKIrVWuiV1Fi6ccl
U59/Z7r9hUxmgJaCqcCjDLGqtrVvog/gaxoGhJ2SblKQggf+LwVQ+6UxpC/ogc+y
8eg5lSfWsIvb1MrQ9hkslEq4Oudy+Qfa1Md5w6VRzo9UM/0oAOkaRjaq0prl1JOT
HKoUBkVAaTm6VjR0UX23DBcl0S+IgMDMNoP7kbNmMycQnfSNc2kwJZIQO4HI1bEY
pM5pPdrQoL28gqD9jQLcLh2Pu/9lXXqwilqUq3949J8uJgrdayUkQY55VxM9QWL+
a/mCVcj8jSVm09fIytmgU3KVA0wxS12Ymlim4zKvVNn/SB9tUUsLuqBu5CgWmC0y
Ki7kXEf1CkMV1amASFbZznH0DuoOjTFNa0pWeQb18DuiLuVqhR+JPv/sX8jRn2MT
CrTPCySRNefIWpUcxmKj
=VTkd
-----END PGP SIGNATURE-----

--8OnGB7eB/1rlkWaq--

--===============0425201680499880757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0425201680499880757==--
