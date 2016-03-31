From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: qcom: Fix some static checker
	warnings
Date: Thu, 31 Mar 2016 10:31:37 -0700
Message-ID: <20160331173137.GM2350@sirena.org.uk>
References: <1459423312-6334-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0152076691724453010=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A10D22666D6
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 19:31:42 +0200 (CEST)
In-Reply-To: <1459423312-6334-1-git-send-email-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, plai@codeaurora.org, kwestfie@codeaurora.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org


--===============0152076691724453010==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Wm6Et8bt556AKwYA"
Content-Disposition: inline


--Wm6Et8bt556AKwYA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 31, 2016 at 12:21:52PM +0100, Srinivas Kandagatla wrote:
> This patch fixes below static checker warning plus suggestions from Dan.
>=20
> sound/soc/qcom/lpass-platform.c:555 lpass_platform_pcm_new()
> error: uninitialized symbol 'ret'.

Please submit one patch per change, each with a clear changelog, as
covered in SubmittingPatches.  This makes it much easier to review
things since it's easier to tell if the patch does what it was intended
to do.

--Wm6Et8bt556AKwYA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW/V73AAoJECTWi3JdVIfQGg0H/iBiNjs3OCM2oOXqERVdFjMz
rYDlrJXiHpYbqhmNrurhkU/uCtQm3bd4JmbcD5650Mlayh/DlFtsoRzzobBS2OS8
FU0aKYthsiZdWQ49246Pu2vF4HcYrE8t0XSURvo+fsNAZpCyTPtis7lhd5lJIkDm
3oZyssyfq4MRActeeLHX9lwkG0GMvvHhcqvgPruA5Bnpih+HdK29v588uLBlR4lq
RTH52YJlIneUNEL0IR54ccJEpSSx7c4znOaipLF4ujGkXLJES28if+QA0dXDHa/P
DN0L/Ra+/MRwYubYv6uiXylhCZ2drP4LNBbFj30D4rQYchA7qE1hGyYNnRrk6Bw=
=h7QV
-----END PGP SIGNATURE-----

--Wm6Et8bt556AKwYA--

--===============0152076691724453010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0152076691724453010==--
