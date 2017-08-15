From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/9] ASoC: cygnus: Update bindings for
	audio clock changes
Date: Tue, 15 Aug 2017 18:14:24 +0100
Message-ID: <20170815171424.whcy4mftex6sgzgj@sirena.org.uk>
References: <1502748417-26417-1-git-send-email-lori.hikichi@broadcom.com>
 <1502748417-26417-3-git-send-email-lori.hikichi@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0657323401445315278=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 790A02665D5
 for <alsa-devel@alsa-project.org>; Tue, 15 Aug 2017 19:14:39 +0200 (CEST)
In-Reply-To: <1502748417-26417-3-git-send-email-lori.hikichi@broadcom.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lori Hikichi <lori.hikichi@broadcom.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0657323401445315278==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="66mfxpv5mjvo5zls"
Content-Disposition: inline


--66mfxpv5mjvo5zls
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 14, 2017 at 03:06:50PM -0700, Lori Hikichi wrote:
> Allow each audio port to select which clock (if any) it wants to use.

Why is this in DT for the port and not either using standard clock
bindings to configure the clock tree or allowing the machine driver to
pick?

--66mfxpv5mjvo5zls
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmTK+8ACgkQJNaLcl1U
h9BdDQf/XoW2PfmCiGhijMR5GDKi7Wu5sOxP1t5FlXac9JAVPMsrizz71HR3m+5K
4OvSczZs94VPMjw77lNMgaS1MrCUkoXU8rnhD1CaO/UGuIx2oaJVtvOvPy/TZh0g
mCYqgQKO/dv3Iam+zNrH89cuS9NeekGtM7yle4/6Ab7wj3TnX09G1rRaOVEZj4UU
Rl9d87kSNzmK3j4QmdMccMkJBED+I14PxqlIjZ9/jSOcUz9aMvO8HAFcFhNTA/Vn
Bqdt27Gs7kbN7OpE/BK5PFMIbubyM4ruwfMJxhtT4WLnk/L2yDyKvDwANY8yYaaj
I5hgYg9fn0oR2RWVH42l12vLSSmm4g==
=YcJp
-----END PGP SIGNATURE-----

--66mfxpv5mjvo5zls--

--===============0657323401445315278==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0657323401445315278==--
