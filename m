From: Mark Brown <broonie@kernel.org>
Subject: Re: Splitting out controls
Date: Fri, 30 Oct 2015 11:50:42 +0900
Message-ID: <20151030025042.GT28319@sirena.org.uk>
References: <1444657786.2528.78.camel@loki>
 <20151012205908.GA25971@us.netrek.org>
 <561CADA8.3040903@canonical.com>
 <1445009730.3536.18.camel@rf-debian.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2810176672881147918=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F43B265D6F
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 03:50:50 +0100 (CET)
In-Reply-To: <1445009730.3536.18.camel@rf-debian.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, James Cameron <quozl@laptop.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


--===============2810176672881147918==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uc+LCsvbRhlIZa01"
Content-Disposition: inline


--uc+LCsvbRhlIZa01
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 16, 2015 at 04:35:30PM +0100, Richard Fitzgerald wrote:

> However, what about this sort of scenario: some codec has a speaker
> volume range of 0..100, all of which are valid and safe. Manufacturer X
> makes a device with an inadequate speaker that can be damaged with
> volume settings above 80. How is that protected? There's nothing wrong
> with the codec driver. There's no software at all for a speaker - it's
> just a speaker. Where do we put a hard limit of 80 on a codec control
> for one specific device? If it was my codec driver I don't want to have
> to put a workaround for one specific device because manufacturer X chose
> the wrong type of speaker. Or do we not care about the "stupid
> manufacturer" cases and we're only interested in protecting the device
> the control directly applies to - in this example it's a codec control
> so it mustn't damage the codec but we don't care if poor hardware design
> means it could damage other hardware connected to the codec.

This is what machine drivers are for - providing system specific
integration.

--uc+LCsvbRhlIZa01
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWMtsCAAoJECTWi3JdVIfQ2PwIAIX/reKxv5ZDYFA5O+NSSLaD
5tFoOpLQxtdefziSXNg/L3J5qLTr0fsGm3oHxEQqHsQx33BOzRABxvA/MZE/Kl/I
pQYCorrk2O19ryQUlLN6xQxFAcYiImRr+gfD2zup98TQsHLbo/3CkjLTwyrQrsWv
7RbES3XvIV8plehZEzFHVfGrvsZgGpnlq4R8iJztn+9T4JHN3JHWycY80sM56BP9
aem+NhSAs0wC8Lm4vM7sYQOmj8yxW3HRWCPGIK7P2W8tJdlMoOJpikviQU3kQDN+
O8n1lqbEkvTgbhl8zkZbI9X6vmR2VsegHRhVLuvELgqlZYZWhNs7JTNgGL4flI4=
=pixH
-----END PGP SIGNATURE-----

--uc+LCsvbRhlIZa01--

--===============2810176672881147918==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2810176672881147918==--
