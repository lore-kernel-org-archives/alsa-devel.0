From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 04/25] dt-bindings: sound: qcom: Add
	bindings for q6afe
Date: Thu, 1 Mar 2018 20:41:33 +0000
Message-ID: <20180301204133.GP12864@sirena.org.uk>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-5-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2373277592384872643=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AA9A267C25
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 21:41:35 +0100 (CET)
In-Reply-To: <20180213165837.1620-5-srinivas.kandagatla@linaro.org>
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


--===============2373277592384872643==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9pS2hy4/DrI8BQlq"
Content-Disposition: inline


--9pS2hy4/DrI8BQlq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 13, 2018 at 04:58:16PM +0000, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

> +- but must contain the following property:
> +
> +- compatible:
> +- qcom,apr-svc-id
> +- qcom,apr-svc-name
> +- #sound-dai-cells

Property or properties?  It's a bit surprising that both the ID and the
name are mandatory, does the name actually get used for non-diagnostic
reasons?

--9pS2hy4/DrI8BQlq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqYZX0ACgkQJNaLcl1U
h9DVswgAgNJ4G1f96WfH9ZdNbYjqbFopiIHLA51w5qPJCavaMFl900adibi+E4Wd
I77+PJxyz5HuLtxuZi/ioi2rzhy7HVoPRx/laRpn+PgVE5fwtUfAIHCL4/tqBpA7
e/rqmW5dbv1H/OuG8sICw164RmcpSB+9IQ03IiJS+sfIP3qRv4ygPiP1353Ba7Jw
zBER6PLEQ2VL+ASqf/Bhdu4pLJfAUu9OgFoR+7DpK6AFskRaLFCsYqKs7w2y4LWk
1RcNXjflfvfwlXKO86oONrNcB8wiJSGp8gbRXLEDIG1ydJnr4hLLJ1hjkgl+HwTN
Ux/aViDUZMRPrqBWIm7mtDotwLUmvg==
=tDFr
-----END PGP SIGNATURE-----

--9pS2hy4/DrI8BQlq--

--===============2373277592384872643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2373277592384872643==--
