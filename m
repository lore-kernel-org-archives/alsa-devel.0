From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 1/9] sound:asoc: Add support for spdif
	in Audio Codec
Date: Fri, 22 Jun 2012 10:21:29 +0100
Message-ID: <20120622092129.GH4037@opensource.wolfsonmicro.com>
References: <cover.1340273261.git.rajeev-dlh.kumar@st.com>
	<4293b6815ad92e19fe8791262cdec8e68f365ddb.1340273261.git.rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2472938717343000586=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 747FA2438F
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jun 2012 11:21:31 +0200 (CEST)
In-Reply-To: <4293b6815ad92e19fe8791262cdec8e68f365ddb.1340273261.git.rajeev-dlh.kumar@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Cc: tiwai@suse.de, Vipin Kumar <vipin.kumar@st.com>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org


--===============2472938717343000586==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Jz4B0QKJ3xxfGEtb"
Content-Disposition: inline


--Jz4B0QKJ3xxfGEtb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 21, 2012 at 03:54:49PM +0530, Rajeev Kumar wrote:
> From: Vipin Kumar <vipin.kumar@st.com>
>=20
> This patch adds the support for spdif in audio codec.

As ever do try to provide subject lines which are appropriate for the
subsystem you're submitting against.

> +static int __init dir_modinit(void)
> +{
> +	return platform_driver_register(&spdif_dir_driver);
> +}
> +
> +static void __exit dir_exit(void)
> +{
> +	platform_driver_unregister(&spdif_dir_driver);
> +}
> +
> +module_init(dir_modinit);
> +module_exit(dir_exit);

module_platform_driver().

--Jz4B0QKJ3xxfGEtb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP5DkTAAoJEBus8iNuMP3dwX8QAJ4ZnQjy7UhQsx5y/XWom1si
BsSprDq1H6jilrPMQSf71xTjdZpyEZHpjSbsgdv2a+tLQSEoHKobx9As/xrSJ5qb
tbvKZrZjKx/ojE1HkTozE0iBP8YZny93uxLYk3Zq7I4rfsBXOHTC9xSwi94HDidl
ylbBsiXOrP9mW3u+sN+HUNyKMmha0M1AfH6NY1CyMLuPBpLJEDtzYBr+SdrdujqS
8YQFHohm59MYDCc62/5Jow+9MQIdMCpF28t61+WJ8h55YmUFheaEvqpCKxF1vsuk
y51ZdCi8FRou/xoxqfeZv4bIsFtS9pduZPyKz/kZl8DIttOW/UMlrPWmjuZ+5aG4
OCVXBZfZMZeJXKOi1FkEeUwSam172jpCt7soLiwVlU8rF7/OMOk4gE3KG7122prL
YIxqnqUMqbV+RsUnuOuwjiKRHiIdO8oRHY8GDB9FiHZZlqPoyxqqFcV4YvQ1+Ibf
tlqYS9i8NG0fOGkMQXcKPbagRTnajxC+WI0Kz29CgZQ14FXGR8sK6xZKuNtNFOOw
qvarxxypt4la8evs3ZR6am1WB0dT44dnhsxkJYtazo5gtCDi1nRucq+rCcwF9uGQ
i4ZtL9MXas7rTfHvtr4wUlIuZZSxmjs64x53ln5fH97zNZ0iGZ18DPvz/u8PiNz8
LvfaUQDfmJYqQhrXsBTA
=ooQl
-----END PGP SIGNATURE-----

--Jz4B0QKJ3xxfGEtb--

--===============2472938717343000586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2472938717343000586==--
