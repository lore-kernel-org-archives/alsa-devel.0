From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: rt5651: Add IN3 Boost volume
	control
Date: Thu, 19 Jul 2018 16:02:34 +0100
Message-ID: <20180719150234.GE27938@sirena.org.uk>
References: <20180718205542.12364-1-hdegoede@redhat.com>
 <20180718205542.12364-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1961923882827108255=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E72C526733D
 for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2018 17:02:41 +0200 (CEST)
In-Reply-To: <20180718205542.12364-2-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============1961923882827108255==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BQPnanjtCNWHyqYD"
Content-Disposition: inline


--BQPnanjtCNWHyqYD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 18, 2018 at 10:55:37PM +0200, Hans de Goede wrote:

> +	/* IN1/IN2/IN3 Control */
>  	SOC_SINGLE_TLV("IN1 Boost", RT5651_IN1_IN2,
>  		RT5651_BST_SFT1, 8, 0, bst_tlv),
>  	SOC_SINGLE_TLV("IN2 Boost", RT5651_IN1_IN2,
>  		RT5651_BST_SFT2, 8, 0, bst_tlv),
> +	SOC_SINGLE_TLV("IN3 Boost", RT5651_IN3,
> +		RT5651_BST_SFT1, 8, 0, bst_tlv),

These should all have Volume added to the name however that's a
preexisting bug so not a blocker on this.

--BQPnanjtCNWHyqYD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltQqAkACgkQJNaLcl1U
h9AeEwf/WGQXvNv/QlvCpNlzm/q48yyC1D3wp/S6iXVVDD3nNGaW686U+ci5xrM/
EBjzxTk3FgM8G7jZQnI3Lq4YtLr9YKhFdZcrs+MzOjlFS+IIuktAOxTLPNXWZdBR
23Qz6E8MdMlNh1egJq6n5pu+1zUwNlyYlFNMbeeOa4ti+qtUYwYwbV85JyKJ4QgO
KigNg+Lw9U98Xc2onCi+th2JKX1xwo+sMo09gEiN6HKDU7sFhhCQ6iXMCOZW4POF
RyJIqMBfuSQUj6YuTY5lt1RtWhTLGCT1rKx65T1hIxBRz+aba/6sSul8fulcxaMe
e0em1mY0gK/tVbeh08IG/07jD+YxMQ==
=r0WQ
-----END PGP SIGNATURE-----

--BQPnanjtCNWHyqYD--

--===============1961923882827108255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1961923882827108255==--
