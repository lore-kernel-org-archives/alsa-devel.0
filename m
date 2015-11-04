From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ASoC: Add mediatek HDMI codec driver
Date: Wed, 4 Nov 2015 12:03:43 +0000
Message-ID: <20151104120343.GZ20228@sirena.org.uk>
References: <1446638053-12143-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5546807396474365269=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D507526044B
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 13:03:55 +0100 (CET)
In-Reply-To: <1446638053-12143-1-git-send-email-p.zabel@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Koro Chen <koro.chen@mediatek.com>, Daniel Kurtz <djkurtz@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-mediatek@lists.infradead.org, kernel@pengutronix.de, Matthias Brugger <matthias.bgg@gmail.com>, Cawa Cheng <cawa.cheng@mediatek.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5546807396474365269==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7fVM7fn5T1d7Fqim"
Content-Disposition: inline


--7fVM7fn5T1d7Fqim
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 04, 2015 at 12:54:13PM +0100, Philipp Zabel wrote:

> This driver is based on the work of DW HDMI codec driver.
> It controls mediatek HDMI Tx's audio module, and handles
> HDMI jack detection by sharing IRQ with HDMI Tx.

How does this relate to all the other HDMI related work that's going on,
especially around handling of the EDID data?  I'm not seeing anything in
here that uses the constraints code that Russell added for example.  As
I keep saying I really want to see some collaboration and consensus here
with the goal of sharing code and achieving a consistent userspace
interface rather than a lot of individual independently implemented
drivers.

--7fVM7fn5T1d7Fqim
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWOfQaAAoJECTWi3JdVIfQoOkH+QFfUyyNyef9gK84uZSUw64q
la83BKf4TX8X3zvH/QfIMGbyW3NE8Rwm5o6lawNSnhfcUdHGgqu6lcPuxbBkIWRJ
Ul5jJcfLzyC5VQIxivAh3XN3ATpYcIcuvG/ZgtovtcPBZJ1p31pXX0SIw8XNAkzZ
i+qqR6mvJhIQr3g4v6wbxW14bhYGiTrqOXw860HlKC0DhdhOKQjsvYfosKZRlpxr
xuXd4wYtykHhgbKCE31z9onJwT52atYJUi/9x99pZXeaVReKP9tUrvha43Uo5Xtj
VeIAF+/ul5X/Ln/QOuq7DbupfHZXe+zSL0n2iqzZEgkMXPudpRjKw2YzoH0Iuk4=
=pJbs
-----END PGP SIGNATURE-----

--7fVM7fn5T1d7Fqim--

--===============5546807396474365269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5546807396474365269==--
