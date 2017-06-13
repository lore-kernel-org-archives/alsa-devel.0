From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/7] ASoC: intel: bxt: Constify
	hw_constraints
Date: Tue, 13 Jun 2017 21:26:52 +0100
Message-ID: <20170613202652.pt53jvmqkulorhc4@sirena.org.uk>
References: <20170608213725.5378-1-tiwai@suse.de>
 <20170608213725.5378-4-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5525755211644335987=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 24A2B266F88
 for <alsa-devel@alsa-project.org>; Tue, 13 Jun 2017 22:26:57 +0200 (CEST)
In-Reply-To: <20170608213725.5378-4-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Brian Austin <brian.austin@cirrus.com>, Krzysztof Kozlowski <krzk@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Matthias Brugger <matthias.bgg@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5525755211644335987==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xlct6wjxgraeaddf"
Content-Disposition: inline


--xlct6wjxgraeaddf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 08, 2017 at 11:37:21PM +0200, Takashi Iwai wrote:
> snd_pcm_hw_constraint_list(), *_ratnums() and *_ratdens() receive the
> const pointers.  Constify the corresponding static objects for better
> hardening.

This doesn't apply against current code, please check and resend.

--xlct6wjxgraeaddf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllASosACgkQJNaLcl1U
h9C/fwf/VFe0qNagBqeQPchNQqi5E0BW/mKYTkNIbFU/FdKpFULsUxNmRmpcRqIt
TylXulXTDUzwO09U0i5uvkV4hHfrZtHaoGQ0Z3s5p/BRHDtrXqORnORv7h5dcTST
KzeVofFcUX7L0sbo35qCMAGH7iluO6BszcX6MTSflt6DCB63d2uXjBbUTAudxIsZ
aBL72z5U8jhq4usVfYJcmoO/MYMNlcDcWfe6cZ/bkNnv8WRggEFQQeIuexKbPzBQ
xRbkAlX/mwhfXYd2Ufrh1KlCzpez55IK5HT+oGNtD+tljmO8EpcBYprLzHWcDHXe
/Hi5gbFtx3nzsZuNGtA51yiluQYOtA==
=v6Yl
-----END PGP SIGNATURE-----

--xlct6wjxgraeaddf--

--===============5525755211644335987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5525755211644335987==--
