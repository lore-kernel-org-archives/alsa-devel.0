From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: wm8804: Add DAPM widgets for
	SPDIF/AIF
Date: Mon, 2 Mar 2015 18:16:13 +0000
Message-ID: <20150302181613.GB21293@sirena.org.uk>
References: <1425319075-10400-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1425319075-10400-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6805091114097251623=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DE4E226065C
 for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2015 19:16:27 +0100 (CET)
In-Reply-To: <1425319075-10400-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, info@crazy-audio.com, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============6805091114097251623==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T6oTHiTqGIAXraaa"
Content-Disposition: inline


--T6oTHiTqGIAXraaa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 02, 2015 at 05:57:55PM +0000, Charles Keepax wrote:

> Firstly, 'Input Source' changes names to 'Tx Source' this is a
> lot clearer, but perhaps we shouldn't change this, as it doesn't
> have to change?

Yes, leave it be.  If you were renaming this should be in the changelog
with an explanation as to why.

> Secondly, the patch removes the controls 'TX Playback Switch' and
> 'AIF Playback Switch' as these bits are controlled by DAPM now. I
> wasn't sure if it would be preferrable to leave dummy controls that
> do nothing?

This sounds like you need a more detailed changelog entry explaining why
it's a good idea to do this in the first place, never mind the proxy
control - what is the purpose of this change and what benefit will it
bring?  Given that this is a S/PDIF bridge it's not at all obvious that
the chip will be used in applications where the sort of power savings
you're likely to see from powering down one of the links (as opposed to
cutting the power to the chip) are likely to register.  Why move those
bits to DAPM control at all?

I also note that this patch is apparently written by but not CCed to
Sapthagiri Baratam.

--T6oTHiTqGIAXraaa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU9KjsAAoJECTWi3JdVIfQsRwH/3bMzBnuKr1MFj5duSpiMN9e
GJIiXPPYp5nYjUSrdyr23NSwClvJmGIFsFi3ZdkG64IxYuRmZxk8t27QXqKePbw6
NFV757mQMxMneJXjDRjOVhuJQJ4WPmzCqI8SmiwuocTiUMdtLl49ZRAsatcTS+RU
++bFyWMOsirwq75IX6ZUiRl/xl3jhVk4Jc42rCbgH/5ZBuzY9NRWM9EDOqJKopof
m96+aRMwF7XkJ8L73QgOBEQ13e8YeZE18mp7um8t+JYnffr+XYnPWpFOMMlQb/YU
21rHAnPXcv8SbU63Fszwoez/tgw8u70ehFPaSYzlG6Y84iw20l3rKFtsTfPx1qw=
=zfJ/
-----END PGP SIGNATURE-----

--T6oTHiTqGIAXraaa--

--===============6805091114097251623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6805091114097251623==--
