From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 11/25] ASoC: qcom: q6asm: add support to
 audio stream apis
Date: Thu, 1 Mar 2018 21:33:56 +0000
Message-ID: <20180301213356.GV12864@sirena.org.uk>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-12-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8882713471432277853=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 28F67267C4B
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 22:33:57 +0100 (CET)
In-Reply-To: <20180213165837.1620-12-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: srinivas.kandagatla@linaro.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, david.brown@linaro.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, spatakok@qti.qualcomm.com, andy.gross@linaro.org, linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============8882713471432277853==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TG7lY2/6mW/akb80"
Content-Disposition: inline


--TG7lY2/6mW/akb80
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2018 at 04:58:23PM +0000, srinivas.kandagatla@linaro.org wr=
ote:

>  	uint32_t used;
> @@ -131,7 +191,7 @@ static int q6asm_apr_send_session_pkt(struct q6asm *a=
, struct audio_client *ac,
> =20
>  	rc =3D wait_event_timeout(a->mem_wait, (a->mem_state <=3D 0), 5 * HZ);
>  	if (!rc) {
> -		dev_err(a->dev, "CMD timeout \n");
> +		dev_err(a->dev, "CMD timeout\n");
>  		rc =3D -ETIMEDOUT;
>  	} else if (a->mem_state < 0) {
>  		rc =3D  q6dsp_errno(a->mem_state);

This should be folded into whatever patch is being fixed.

> +	open.hdr.opcode =3D ASM_STREAM_CMD_OPEN_WRITE_V3;
> +	open.mode_flags =3D 0x00;
> +	open.mode_flags |=3D ASM_LEGACY_STREAM_SESSION;

What is a legacy stream and why are we using it in new code?

--TG7lY2/6mW/akb80
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqYccMACgkQJNaLcl1U
h9B4PAf/XuHY01+J4AY6SjvYrppdjRDO75cG1EFh0grfxKTIwzDe4rz/G31M2XP6
+o4/4MM/kFyjfLrz6MFGzTli4f0L+XTA5g6xMWNBR88N4VCVeJUG7UtF5qRVdfty
3q7oFiYNGe1GatCnwT2Vdom5XsezJVOphq0o1n+pZg3/xN3r4Cob7erT1CA3t1we
St+PE0vCAItwRd4skPzZbYLQ5FbrX7Wg2tYEPaLb6p+DpVxbQbqoCp83TVRH6NVU
vBXlr2f4RSL1jHbhayVIOdYDpE7/duVy60qFMRDIt7L0FD7q+igro5n1ZuyxsBnB
evcmg1mok6pN7Bfcjmid04+odETRgA==
=Yo1h
-----END PGP SIGNATURE-----

--TG7lY2/6mW/akb80--

--===============8882713471432277853==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8882713471432277853==--
