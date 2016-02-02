From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: add "coreboot" to
	dmi_system_id list
Date: Tue, 2 Feb 2016 19:49:36 +0000
Message-ID: <20160202194936.GB4455@sirena.org.uk>
References: <1454304078-12322-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5769304269326120845=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8252B265104
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2016 20:49:41 +0100 (CET)
In-Reply-To: <1454304078-12322-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, john.lin@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============5769304269326120845==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Jsn5+Lu/ZvzbAGtZ"
Content-Disposition: inline


--Jsn5+Lu/ZvzbAGtZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 01, 2016 at 01:21:18PM +0800, Bard Liao wrote:

> +	{
> +		.ident = "Google Chrome",
> +		.matches = {
> +			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> +		},
> +	},

While coreboot is most commonly seen in ChromeOS systems it's not unique
to them so this seems likely to generate false positives.  Since the
target for this change is internal-only development hardware it doesn't
seem unreasonable to expect people to be able to keep changes like
device ID updates internally.  This is one of the many costs of BIOSes
that require us to do such DMI hacks, it'd be much better to improve the
firmware and the driver so they can specify required properties directly
rather than relying on DMI.

--Jsn5+Lu/ZvzbAGtZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWsQhPAAoJECTWi3JdVIfQU1wH/2kJEaJEhmNfSZV8aBYqKLYq
rqAqdBg7LsYBhBdaq83LMaTItvZ/i3Z7I5gxlzuMNI3s1dHEQ36RBuNYJ5Drjwxb
NPEcY4nzSibHZCQIVlgDLviRq8fSuPux38/LrqT4AZIoNs/8t5x3kcAhzpp3Spqg
xWU1sp1WfTskHKIB3Fy17FLXfMzZA8B9KejLqyN5JQBGp8Hl3gT9JCnct78Kf7d0
YYYCbTxBXWtJsdSklhs14flgNB2tAQIM4oTP3xhjttTTBR4A/890OFwEDlShRVlf
h9WBZADPFFAv8CJRC7ItxFDOuZcm1JYa2Hdu1WD/iu1L0YJZiVudg42FGIJoitw=
=vmuB
-----END PGP SIGNATURE-----

--Jsn5+Lu/ZvzbAGtZ--

--===============5769304269326120845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5769304269326120845==--
