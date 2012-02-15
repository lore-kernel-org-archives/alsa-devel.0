From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: DAPM - Notify stream event to all
	card components.
Date: Wed, 15 Feb 2012 07:58:01 -0800
Message-ID: <20120215155800.GB2996@opensource.wolfsonmicro.com>
References: <1329318937-14488-1-git-send-email-lrg@ti.com>
	<1329318937-14488-2-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8567616394034134594=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 46572103EF1
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 16:58:04 +0100 (CET)
In-Reply-To: <1329318937-14488-2-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8567616394034134594==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Content-Disposition: inline


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 15, 2012 at 03:15:35PM +0000, Liam Girdwood wrote:
> Currently when DAPM widgets are power sequenced the stream_event()
> completion callback is only called for the stream_event originator
> DAPM context. Other components in the card may also be interested so
> make sure they are also notified of any widget power events.

Applied, thanks.

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPO9YBAAoJEBus8iNuMP3d7GMP/RpFRTR0EGWUM8He6+hbjzr1
mGFWhy3JBwj9rlcwBJSLsv+ksC6QXdG+QAm3uv+R9BodMDFgGZJSJH6s90yYjkvV
fwDz2msh86ME1k+v/U5oC3coR7XvvAPIKrKy52O06cF9a5KqzNbRtJcs1ivBBdqB
pKbUxUd5k0BPEoBuNoaSTjcIrxYaXMXmA05Fyf9EHxCliI3dvmd0hWK2zIDDnkTX
AlhTeBD4ZiBBgiFyd081qi8ImwnzFLdv10G7lajPpes6RG8CNRG7KJeVYF7IbCw1
XF5IuQJr4O9VnuPl0Z1PfgN5N+80qM1bT0Ia2DzQjThax6q5jYKd/a5+XGupQPy4
b69un/wlUSXV1O9R7txNZlSvIIFyaWZ6EJk2MyWq/cBJ/Nhc6kijrfwMBby4JsAD
TPFGEZCJR94FRpfswVR4Y7WMceYfh/FTD64ixfXubY2JcHMPARAiXPViBfJmGm+q
juqWdzA4VDrqxK+0wWaCBkaavjMxOAtpeCQfGTZywBqo2NP3NoMqmmt+EqaUVMF0
ng7R0ylKfqWtqG7/FXIBq6xgGjCwOz5qMw+kDKiOwnAfb2z8Wc0qlkJpAIzkYLaM
/B3G1XN+3VNtULzPinhgJUtrQ284rpih8bofz4vxKEqbcboJCgIHy2IpFhWSlO2t
LjFJlGsboyD1tsKPmAsa
=siB7
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--

--===============8567616394034134594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8567616394034134594==--
