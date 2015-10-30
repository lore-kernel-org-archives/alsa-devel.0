From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Skylake: fix typo in sizeof
Date: Fri, 30 Oct 2015 12:02:58 +0900
Message-ID: <20151030030255.GW28319@sirena.org.uk>
References: <1446156281-31024-1-git-send-email-vincent.stehle@laposte.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1352210407217811904=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D272265DEF
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 04:03:02 +0100 (CET)
In-Reply-To: <1446156281-31024-1-git-send-email-vincent.stehle@laposte.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@laposte.net>
Cc: alsa-devel@alsa-project.org, trivial@kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1352210407217811904==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xxgoS+Xwt19NyhFM"
Content-Disposition: inline


--xxgoS+Xwt19NyhFM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2015 at 11:04:41PM +0100, Vincent Stehl=E9 wrote:
> The size of the pointer to a data structure to send is erroneously
> passed to sst_ipc_tx_message_wait() as its tx_bytes argument. It should
> be given the size of the pointed skl_ipc_dxstate_info structure instead.

This was reported by 0 day, please don't ignore reports from 0 day.

> Cc: trivial@kernel.org

This doesn't look like a trivial fix...

--xxgoS+Xwt19NyhFM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWMt3fAAoJECTWi3JdVIfQ0XUH/1Ey18LeDkqd0ot6aVF+kIIs
YoauXhIEYscFRJu25GP3WlfTBBlmXM6i+VLy/JWdR4W4JTw+VlWbO0FVACGMJctx
a2L17xDhLr1Ed0h6WUnS9znsr4/qDQXdx8QuX4U6FuJi/0AHogyWIv2DBB8hWR8O
K+GNGvRRY24FwnpcUmWfZTa9Gl9WJ7laelVVcN5CB5f/cZIvD2mcYjqM25jyeKjL
Ag8gbSdDB79l8p/ZcSR52nE43HyT13D+9P6QMHsLZJ468OKG7NvEdy9yJjy7NhFr
dFwEIehT169lkGncx4rg9oylLHVP4XIAlUkGim4dJpocl93Twym7MMllwPlEhQc=
=yttT
-----END PGP SIGNATURE-----

--xxgoS+Xwt19NyhFM--

--===============1352210407217811904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1352210407217811904==--
