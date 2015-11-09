From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: Power up the RC clock to
 make sure the speaker volume adjust properly
Date: Mon, 9 Nov 2015 14:09:05 +0000
Message-ID: <20151109140905.GB26072@sirena.org.uk>
References: <1446724551-27762-1-git-send-email-oder_chiou@realtek.com>
 <20151105121230.GD18409@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694FA2BE6@RTITMBSV03.realtek.com.tw>
 <20151106104433.GB18409@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694FA36C9@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1330094800915001292=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CAC026051F
 for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2015 15:09:28 +0100 (CET)
In-Reply-To: <7EB0DE829A537248AF2ED30C97D12694FA36C9@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============1330094800915001292==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 09, 2015 at 03:13:09AM +0000, Oder Chiou wrote:

> > What makes you claim that this is "essential in case of the operation of kcontrol
> > continuously"?

> Like the Chrome OS, while the user pull the volume bar up or down, the
> kcontrol will be manipulated by the UI continuously and seamlessly. In this
> kind of case, if the "cancel_delayed_work_sync" is removed, the
> queue_delayed_work will be failed within 200ms after the previous
> queue_delayed_work, and it will not be able to make sure the power of the
> RC clock enabled at least 200ms, thanks.

No, it won't.  To repeat what I said if you just schedule the delayed
work again without cancelling then the right thing will happen.

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWQKj7AAoJECTWi3JdVIfQAI8H/1vyXMSy5Uc0efVZn4ZcvgDC
20Ofv6pN5P2Rvws2rDeF+jiHYrAmpMXzO4t01bFVCpEdVvjhw8rrxpZ5SudKJRPG
jugMY8VlZphiVuAPY72QQmfhjO8er6Kp14owSL6a7JjhryHXSe45nS55st7oNEg1
UOMx1WaWXmFy3qLSJpQrNV4Uee0T806g1XfZcm9Rkn0z/TxsSzpcHa2m9mz3Mm5U
Rcfnmch8pRXHEFH5EEy4Do5bXniYXIuZVlEMbYTWnH11i+aEbnlEmNJVQVngokF9
M18rBaW9g9RBoFGz2uf6KkQ6bEXXXiJz8UWwLBFwkqX8uYuMX4auwjVIswD58a0=
=XAjX
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--

--===============1330094800915001292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1330094800915001292==--
