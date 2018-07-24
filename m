From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 07/12] ASoC: wcd9335: add CLASS-H
	Controller support
Date: Tue, 24 Jul 2018 12:59:08 +0100
Message-ID: <20180724115908.GC2414@sirena.org.uk>
References: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
 <20180723155410.9494-8-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4178664424981887162=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F263D26733D
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2018 13:59:11 +0200 (CEST)
In-Reply-To: <20180723155410.9494-8-srinivas.kandagatla@linaro.org>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.com, vkoul@kernel.org, robh+dt@kernel.org, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============4178664424981887162==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
Content-Disposition: inline


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 23, 2018 at 04:54:05PM +0100, Srinivas Kandagatla wrote:

> +static inline int wcd_clsh_get_int_mode(struct wcd_clsh_ctrl *ctrl,
> +					int clsh_state)
> +{
> +	int mode;
> +
> +	if ((clsh_state != WCD_CLSH_STATE_EAR) &&
> +	    (clsh_state != WCD_CLSH_STATE_HPHL) &&
> +	    (clsh_state != WCD_CLSH_STATE_HPHR) &&
> +	    (clsh_state != WCD_CLSH_STATE_LO))
> +		mode = CLS_NONE;
> +	else
> +		mode = ctrl->interpolator_modes[ffs(clsh_state)];
> +
> +	return mode;

This looks like it wants to be a switch statement.

> +static void wcd_clsh_state_hph_lo(struct wcd_clsh_ctrl *ctrl, int req_state,
> +				  bool is_enable, int mode)
> +{
> +	struct snd_soc_component *comp = ctrl->comp;
> +	int hph_mode = 0;
> +
> +	if (is_enable) {
> +		/*
> +		 * If requested state is LO, put regulator
> +		 * in class-AB or if requested state is HPH,
> +		 * which means LO is already enabled, keep
> +		 * the regulator config the same at class-AB
> +		 * and just set the power modes for flyback
> +		 * and buck.
> +		 */
> +		if (req_state == WCD_CLSH_STATE_LO)
> +			wcd_clsh_set_buck_regulator_mode(comp, CLS_AB);

This seems like there's a pretty confusing state machine, or possibly
that we might end up in different states depending on how we transition.
Whatever is going on it really feels like this code is more complex than
it needs to be.  Some of this is the use of lots of nested if statements,
some of it is the lack of any clear description of what we're trying to
achieve.  It's hard to tell if the code is doing what's expected because
it's hard to tell what it is expected to do.

> +		else {

If there's braces on one side of an if/else there should be braces on
both sides.

> +			if (req_state == WCD_CLSH_STATE_HPHL)
> +				snd_soc_component_update_bits(comp,
> +					WCD9XXX_A_CDC_RX1_RX_PATH_CFG0,
> +					WCD9XXX_A_CDC_RX_PATH_CLSH_EN_MASK,
> +					WCD9XXX_A_CDC_RX_PATH_CLSH_ENABLE);
> +			if (req_state == WCD_CLSH_STATE_HPHR)
> +				snd_soc_component_update_bits(comp,
> +					WCD9XXX_A_CDC_RX2_RX_PATH_CFG0,
> +					WCD9XXX_A_CDC_RX_PATH_CLSH_EN_MASK,
> +					WCD9XXX_A_CDC_RX_PATH_CLSH_ENABLE);
> +		}

Switch statement?

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltXFIwACgkQJNaLcl1U
h9AlGQf9Hntz7b0NDrasFJ50EvVDGuiZu8yWDMlZgGZY5deKA3MUubcQmCzDqL5C
s54SdXf9usQEcMFlsngWgJZful87H7a0rvhq8JMBsRnCBXDMj14L+nkDVGVfslOQ
bVeSAefLXB2RqVZdqS6VWCp1FjZ+8SFWyGgeEbF0IgWu2DlY/FsufZqJgQUIphfj
BLjdiTJCN16tE65aVfcMHH5LUao8rizBaiSmCipiJKdYrLlC6ebVUyYNHFByT2Hr
s1AgdhjZjodUP72kkbPOmoCup5/MX0doutsW/o2DEaLYLSeSXuxnORAoadSco/du
HzxbV2+1/RFzkFvKMQ5hONi2ZL6BaA==
=RLr1
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--

--===============4178664424981887162==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4178664424981887162==--
