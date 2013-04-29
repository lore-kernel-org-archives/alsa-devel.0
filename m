From: Mark Brown <broonie@kernel.org>
Subject: Re: Configure a CODEC which has I2C connected to CPU,
 but no PCM bus connection
Date: Mon, 29 Apr 2013 21:33:55 +0100
Message-ID: <20130429203355.GH3270@sirena.org.uk>
References: <DB8F1B3EEF94C3439BFFE674EB05E3CC14C644DE@SINPRD0211MB405.apcprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1644790078426356435=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F1CB2616B4
 for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2013 22:33:59 +0200 (CEST)
In-Reply-To: <DB8F1B3EEF94C3439BFFE674EB05E3CC14C644DE@SINPRD0211MB405.apcprd02.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Craig McQueen <craig.mcqueen@beamcommunications.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============1644790078426356435==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Enx9fNJ0XV5HaWRu"
Content-Disposition: inline


--Enx9fNJ0XV5HaWRu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 26, 2013 at 12:01:02AM +0000, Craig McQueen wrote:

Always CC maintainers on posts, if you just mail the list your message
is likely to be lost in the noise.  Also please fix your MUA to word wrap
within paragraphs for legibility.

> I have an embedded device with somewhat unusual configuration: there
> is a second audio CODEC (Wolfson WM8940) which is connected to the PCM
> interface of another device (a radio module, which is acting as PCM
> bus master), so that radio device can do analog audio I/O. So there is
> no CPU<-->CODEC PCM link, but the CODEC _is_ connected to the CPU's
> I2C, and the CPU needs to configure the CODEC registers to interface
> to the radio module.

That's fairly normal - most mobile phones do this.  Take a look at the
neo1973, speyside or bells drivers for example of such a configuration.
You can just connect two CODEC DAIs directly together and either start
the audio from the application layer by running through all the steps
for streaming except for actually starting DMA like:

   http://opensource.wolfsonmicro.com/~gg/bluetooth_pcm.c

does or supply a configuration in the machine driver (if the format is
fixed) like speyside and bells do.

--Enx9fNJ0XV5HaWRu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRftkwAAoJELSic+t+oim9oc8P/0ebEgiTFb8WyJWwqXAczEzp
W7gh+k9JS/nEg5ITb5Y/TtQotBe9GM1dPJ7w8p10l8llNYO1Jm/sMXNCnrCYMPOz
Ttxpdw/Yzcy+8/dZSNITAwm1So29dzYGlyqckoceuxqn6YP8xDHQ1s3BH88/QIIV
526DsCU3fjZyYOi9W/qaeNRQBmpnYrwVisRVaUtxjqXygMzgqg0f0s6likgW1sCQ
oRaw8wo4PViB6Hp7LfzbuMPi5TqMyNsNGAlHKNY6TI6MSqYy+v1K921QlblEaZDn
CFKY0OtVsX4UXZwEMBBYhF+zAUlWGla/TvwpRRk2tmyE9mP1wGQzPPAYbFCnkQy7
srGX2oAyRll3c20jP0dnCY3GXibgfaLNh1ndtA58/xX31GYRkqeKXdPmIpwT+EHz
zORG9N0NU6Rd3OE5utBwo8GeU8zUKmI27XWGrZq8uRn3sGvlaNSWieYD4jf2maIH
HvZRN0vp+g7vh/PqPsWAOxjz1wCRQP23sVShph4xNFxdX2VpTkc+8if4LtatEkdh
KGnGazz2lpaKejgqeXnfEj3hi6tn1cJOVvHovcmvVDCQmGF1tyjstTUwXpvIw+jU
Y0osK2UHZ9HneJr54z7VAnVfnsAmPHrO7BY9+mSxW6lq0zVuzOHM+jwDsSntPuzH
BOa7OVIcnpauytTBJpgl
=SjD1
-----END PGP SIGNATURE-----

--Enx9fNJ0XV5HaWRu--

--===============1644790078426356435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1644790078426356435==--
