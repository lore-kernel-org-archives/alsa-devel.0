From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Add suspend_pre and
 resume_post for Braswell snd_soc_card
Date: Wed, 11 Mar 2015 12:50:47 +0000
Message-ID: <20150311125047.GD28806@sirena.org.uk>
References: <1426045713-1738-1-git-send-email-yao.jin@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3235672408420308392=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5ED662651D5
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2015 13:50:55 +0100 (CET)
In-Reply-To: <1426045713-1738-1-git-send-email-yao.jin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jin Yao <yao.jin@linux.intel.com>
Cc: mengdong.lin@intel.com, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============3235672408420308392==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4Cp72eN6HUuZZoDF"
Content-Disposition: inline


--4Cp72eN6HUuZZoDF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 11, 2015 at 11:48:33AM +0800, Jin Yao wrote:
> On Braswell, we need to add some machine specific setting before suspend
> and after resume. For example, disable/enable jack detection in codec so
> use snd_soc_card suspend_pre and resume_post ops for this purpose.

Reverted since it doesn't build!

--4Cp72eN6HUuZZoDF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVADomAAoJECTWi3JdVIfQOtgH/3eRdyvH/1tGM4SwypurM00F
zPTfQqc3bt0xlrvyH/cskhhOfbBgHhuAn15qYjbNab7fSSZwY/WrbbCNnsr1aUdH
Dp/09JM05rAjDE0bM9wPZw8NkAOWgLpLQyQL6r0taxhHjPVQc3hXQ3oJULKjra0T
Wu8sPjaFS24lN7Dsa6HLU7I29mOegA+EtDk2m9TRc9ymXKA74S9EBCHscFro6TPH
951SgUl6goIFr9QuXDNpmrIkmhyAovC/Zt4fyApfbjQ61GhSuYykBY7/5twOla5/
XJz0E3qnCqYy6nxwUlnXO1rkFAtMJ22+apYnWjBfe97SjLtOlKH+8SK0Y+3AtEA=
=b4TR
-----END PGP SIGNATURE-----

--4Cp72eN6HUuZZoDF--

--===============3235672408420308392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3235672408420308392==--
