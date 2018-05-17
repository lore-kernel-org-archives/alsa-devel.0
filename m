From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v8 09/24] ASoC: qdsp6: q6afe: Add q6afe
	driver
Date: Thu, 17 May 2018 15:55:44 +0900
Message-ID: <20180517065544.GO20254@sirena.org.uk>
References: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
 <20180509125635.5653-10-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5363601596158534057=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CFFE2676C7
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 18:44:54 +0200 (CEST)
In-Reply-To: <20180509125635.5653-10-srinivas.kandagatla@linaro.org>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org, plai@codeaurora.org, spatakok@qti.qualcomm.com, lgirdwood@gmail.com, tiwai@suse.com, david.brown@linaro.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, andy.gross@linaro.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============5363601596158534057==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UOYwgDhKKQYesrzQ"
Content-Disposition: inline


--UOYwgDhKKQYesrzQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 09, 2018 at 01:56:20PM +0100, Srinivas Kandagatla wrote:

> +static struct q6afe_port *afe_find_port(struct q6afe *afe, int token)
> +{
> +	struct q6afe_port *p = NULL;
> +	struct q6afe_port *ret = NULL;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&afe->port_list_lock, flags);
> +	list_for_each_entry(p, &afe->port_list, node)
> +		if (p->token == token) {
> +			ret = p;
> +			break;
> +		}
> +
> +	spin_unlock_irqrestore(&afe->port_list_lock, flags);
> +	return ret;

This lock only protects the list, it does nothing to ensure that the
port we look up is still valid by the time we return to the caller.
That means we won't crash during list traversal but does nothing to
ensure we won't crash immediately afterwards if the port is deallocated
just after we look it up.  What stops that happening?

--UOYwgDhKKQYesrzQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr9J28ACgkQJNaLcl1U
h9DU0wf+Jtg3rkURqsNLq9Q51w6wZOr5Z1t4oGjqjm177dzbIX0kk0g+c1ZhXwXg
+mf5+FHVn/KLccGKF/FC9P/vqyi6woA35Rw+QCofo/yQDM46Zzf7Fx0uu2A5nwle
C8ikwuP9e3ubGeRACgUc+y02tkc/HtxN/q5QeEb/6tmVDC+5sNTBRbKkvarql/uV
vgOFSMarPI2jXj0w6ckSKzh2RTKVqsTCmbs2CA+n8F2L2DddcGpO2MmI9CGihAJE
ZWvl1NSw84lrPzT8+zepPvBAGc46WdAZdQSTD6NCpemz4whVLWyWsosiXSPuowHb
ezb4siubq+6OXdKqCrLcz9yLhWb70Q==
=+I/X
-----END PGP SIGNATURE-----

--UOYwgDhKKQYesrzQ--

--===============5363601596158534057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5363601596158534057==--
