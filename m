From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: qcom: Return an error for invalid
 PCM trigger command
Date: Wed, 15 Apr 2015 17:04:06 +0100
Message-ID: <20150415160406.GQ6023@sirena.org.uk>
References: <1428927809-4919-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5447193796715280176=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6342126069C
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2015 18:04:18 +0200 (CEST)
In-Reply-To: <1428927809-4919-1-git-send-email-tiwai@suse.de>
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
Cc: Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5447193796715280176==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5t5nJKYblz+ydNB5"
Content-Disposition: inline


--5t5nJKYblz+ydNB5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2015 at 02:23:29PM +0200, Takashi Iwai wrote:
> Fix a compile warning
>   sound/soc/qcom/lpass-cpu.c: In function =E2=80=98lpass_cpu_daiops_trigg=
er=E2=80=99:

Applied, thanks.

--5t5nJKYblz+ydNB5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVLov1AAoJECTWi3JdVIfQO6AH/0RBsv1g51VsufbLyATSWYh4
V5+b2xj2sLZsJXA8CUv2UovSt9F6WGjjIULLhAHPcSQLlmSWoc4EXA12qViZsldV
GDkW8jEELdc/TTXoWWA0SQYIp30dxOtRpqQ/s25EUaTvsk0pAHE5snUsNIBp9vzL
YxQ34XHodAwvRAd1kYAhIUDnE/injENhICpelu/bRRf0UiMl4QBOE3QQpGEhxqKd
wiO25jswYP3vPY8uzeUGHatedi9bkJeVs/ImRUTiRgHjCUpgP1dhb+WlxLg693vB
BZ6oRcRgpQSNmXUKw/5wydbEnhXA2SCSkf3Y89rty6pkzN0QtfQ+I5j/Ai3ZTaE=
=cH22
-----END PGP SIGNATURE-----

--5t5nJKYblz+ydNB5--

--===============5447193796715280176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5447193796715280176==--
