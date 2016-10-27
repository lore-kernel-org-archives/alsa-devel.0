From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: hdmi-codec: Fix hdmi_of_xlate_dai_name when
 #sound-dai-cells = <0>
Date: Thu, 27 Oct 2016 15:19:56 +0100
Message-ID: <20161027141956.GL25322@sirena.org.uk>
References: <1477568568.2908.14.camel@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3395490107521733783=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1477568568.2908.14.camel@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3395490107521733783==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CqfQkoYPE/jGoa5Q"
Content-Disposition: inline


--CqfQkoYPE/jGoa5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 27, 2016 at 12:42:48PM +0100, Jon Medhurst (Tixy) wrote:

> -	int id = args->args[0];
> +	int id = args->args_count ? args->args[0] : 0;

Please write normal if statements for legibility.

--CqfQkoYPE/jGoa5Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYEg0LAAoJECTWi3JdVIfQRBEH/RfX4LLKEGy1jBsZpIBfS9gs
APHPpV8l/rX0smyLszZZmnFjFi3o3AEf+4bxapeKC00eiz6uVMKNDuCpu+RA0FJ7
LsM+IVy8AUHR/NXAd0xoTPzXO3vBW0jOKy8iMg0nGPKc9tC6cjw5jj2n/PWyAylu
QuXcPseqDsSHbjYXxejmFO0qzWOVZ13/tdi3Tq8+tdYp32+QNlIZGG2W2kL5bw9z
DUwqyEz5XZlOVOarhP9D2yWzOEkijaKu44+l5w5wIwkL9b63B4bqicRDZfh4SG6g
N8OzXs6yYompaMr27oMrI6eXJybOe3aS7sOkZzJm1cPdeeDoRREAjJFqKJK5KaM=
=4aYk
-----END PGP SIGNATURE-----

--CqfQkoYPE/jGoa5Q--


--===============3395490107521733783==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3395490107521733783==--
