From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: rt5677: add a platform config
 option for MICBIAS voltage
Date: Fri, 12 Dec 2014 13:27:32 +0000
Message-ID: <20141212132732.GK11764@sirena.org.uk>
References: <1418271327-14710-1-git-send-email-benzh@chromium.org>
 <1418271327-14710-2-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4944617059370925333=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 70DBC260692
 for <alsa-devel@alsa-project.org>; Fri, 12 Dec 2014 14:27:37 +0100 (CET)
In-Reply-To: <1418271327-14710-2-git-send-email-benzh@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ben Zhang <benzh@chromium.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Albert Chen <albertchen@realtek.com>, Anatol Pomozov <anatol@google.com>, Bard Liao <bardliao@realtek.com>, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============4944617059370925333==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PlDVpzlhHY5RV9ko"
Content-Disposition: inline


--PlDVpzlhHY5RV9ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 10, 2014 at 08:15:26PM -0800, Ben Zhang wrote:

> The MICBIAS voltage for IN1 can be set to 1.476V/2.970V/1.242V/2.475V

The changelog says "platform config" but this is adding DT binding.

> +- realtek,micbias1
> +  Select 0/1/2/3 to set MICBIAS1 voltage to 1.476V/2.970V/1.242V/2.475V
> +

Why is this being specified as some magic number rather than using the
voltage (or at least providing defines for the voltage) - this is going
to do little to make the DT legible and...

> +enum rt5677_micbias {
> +	RT5677_MICBIAS_1_476V = 0,
> +	RT5677_MICBIAS_2_970V = 1,
> +	RT5677_MICBIAS_1_242V = 2,
> +	RT5677_MICBIAS_2_475V = 3,
> +};

...I see there are defined for platform data.

--PlDVpzlhHY5RV9ko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUiu1DAAoJECTWi3JdVIfQpdUH/1oAN3Z8QmiSAMUziZoVU2KX
/EXvCC46RKgbZJN2bfPUN3cPdo7Fshhu3Yp8sMdaRB1zokuLo0cEwhUOl8XzCHz/
VdSYnP5EI0hxEgj20YBjeKzwiahBfMCjYVMk92vEQYt+tEIazH0AogSyoNpsCGNn
lqp5DnRxfUXRx/2JNMNp+mVsfJtJzneBfoDFu/Q9aL1FpwF0Lf0fPZDZ1ElAoc+1
itAjPUaTndL2oZ7nZqg5aI/m6qJu0ekrtNVE6fjeyBY+N0NFMiNFiYWftPSglOq3
81XMdNukEhDuCqp4bI4armXTtp2lcfAn+3N77UCFZlXOr+ymikREKHeahKhnmEI=
=6cds
-----END PGP SIGNATURE-----

--PlDVpzlhHY5RV9ko--

--===============4944617059370925333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4944617059370925333==--
