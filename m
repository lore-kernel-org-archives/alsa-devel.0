From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 07/25] ASoC: qcom: qdsp6: Add support to
	Q6ADM
Date: Thu, 1 Mar 2018 21:24:02 +0000
Message-ID: <20180301212402.GT12864@sirena.org.uk>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-8-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0855251640109731431=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4770D266F0F
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 22:24:04 +0100 (CET)
In-Reply-To: <20180213165837.1620-8-srinivas.kandagatla@linaro.org>
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


--===============0855251640109731431==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3T2jnoiI0lx9XXvh"
Content-Disposition: inline


--3T2jnoiI0lx9XXvh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 13, 2018 at 04:58:19PM +0000, srinivas.kandagatla@linaro.org wrote:

> +static struct copp *adm_find_copp(struct q6adm *adm, int port_idx,
> +				  int copp_idx)
> +{
> +	struct copp *c;
> +
> +	spin_lock(&adm->copps_list_lock);
> +	list_for_each_entry(c, &adm->copps_list, node) {
> +		if ((port_idx == c->afe_port) && (copp_idx == c->copp_idx)) {
> +			spin_unlock(&adm->copps_list_lock);
> +			return c;
> +		}
> +	}
> +
> +	spin_unlock(&adm->copps_list_lock);

We've again got this use of spinlocks here but no IRQ safety - what
exactly is going on with the locking?  In general all of the locking in
this stuff is raising very serious alarm bells with me, I don't
understand what is being protected against what and there's some very
obvious bugs.  We could probably use some documentation about what the
locking is supposed to be doing.

> +	case ADM_CMDRSP_DEVICE_OPEN_V5: {

> +		copp->id = open->copp_id;
> +		wake_up(&copp->wait);
> +	}
> +	break;
> +	default:

This indentation is confusing.

> +static struct copp *adm_find_matching_copp(struct q6adm *adm,
> +					   int port_id, int topology,
> +					   int mode, int rate, int channel_mode,
> +					   int bit_width, int app_type)
> +{
> +	struct copp *c;
> +
> +	spin_lock(&adm->copps_list_lock);
> +
> +	list_for_each_entry(c, &adm->copps_list, node) {
> +		if ((port_id == c->afe_port) && (topology == c->topology) &&
> +		    (mode == c->mode) && (rate == c->rate) &&
> +		    (bit_width == c->bit_width) && (app_type == c->app_type)) {
> +			spin_unlock(&adm->copps_list_lock);
> +			return c;
> +		}
> +	}
> +	spin_unlock(&adm->copps_list_lock);
> +
> +	c = adm_alloc_copp(adm, port_id);

So really this is a find or allocate operation...

> +	if (IS_ERR_OR_NULL(c))
> +		return ERR_CAST(c);
> +
> +	mutex_lock(&c->lock);
> +	c->refcnt = 0;

Why do we need to lock the thing we just allocated but didn't yet
initialize, and surely if something can find it before we finished
initializing we have a race condition?

> +	copp = adm_find_matching_copp(adm, port_id, topology, perf_mode,
> +				      rate, channel_mode, bit_width, app_type);
> +
> +	/* Create a COPP if port id are not enabled */
> +	if (copp->refcnt == 0) {
> +		ret = q6adm_device_open(adm, copp, port_id, path, topology,
> +				  channel_mode, bit_width, rate);
> +		if (ret < 0)
> +			return ret;
> +	}
> +	mutex_lock(&copp->lock);
> +	copp->refcnt++;
> +	mutex_unlock(&copp->lock);

There's an obvious race here between checking the reference count and
incrementing it - something might drop a reference before we increment
it which would be bad.  I'm also not clear when we'd want multiple
things using a single COPP.

> +	mutex_lock(&copp->lock);
> +	copp->refcnt--;
> +	mutex_unlock(&copp->lock);
> +	if (!copp->refcnt) {

This locking is also broken.

--3T2jnoiI0lx9XXvh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqYb3EACgkQJNaLcl1U
h9C11Af+NLrkXf6H6aaT6ysSq6f3xzPiWQdmYMfCaA2XSy3Lbp7dz1UE2/hsL+fz
V08/WtJ4otq95fnwSdeehWvJLO92GETYkOhSqpSLzp9xfQWtuQls660BoxAWoths
ZOQmWr9F2gg/wOj7TFOQ+jvB8fczjrrxGu60l69AG6oJzRHwjJVxIvYixhpR59x9
6lfOXcoRphcsUNWV4DA7MVnYDB2JbwbYtTAh+kmaBmnYSnVKmHQfUIX5zZHRYNaz
gOs74lmMCrG6MDPtjmTzpJ1Pmyq9HRDQ8OlrQ4ObWAL7R+rDYJZs7oWr3yIJres0
4vT3/g1/FYYz1E5V3gM4DqkahLHRqQ==
=VY1a
-----END PGP SIGNATURE-----

--3T2jnoiI0lx9XXvh--

--===============0855251640109731431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0855251640109731431==--
