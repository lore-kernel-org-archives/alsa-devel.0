From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: rt5645: Adds push button support
	for rt5650
Date: Wed, 29 Apr 2015 12:19:03 +0100
Message-ID: <20150429111903.GH22845@sirena.org.uk>
References: <1430186383-2168-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0530670257394114877=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C4572604CA
 for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2015 13:19:13 +0200 (CEST)
In-Reply-To: <1430186383-2168-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, zhengxing@rock-chips.com, yang.a.fang@intel.com, lgirdwood@gmail.com, john.lin@realtek.com, koro.chen@mediatek.com, jason.ym.lin@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============0530670257394114877==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f9r2E9KP2b+SQXLJ"
Content-Disposition: inline


--f9r2E9KP2b+SQXLJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 28, 2015 at 09:59:43AM +0800, Bard Liao wrote:
> rt5650 support headset button detection. Currently, the button detection
> is only implemented for rt5650 codec. The button detection configuration
> register's default value is different from rt5645.
> And we didn't touch the register in the driver, so we will get the wrong
> value when we dump the registers. We will fix it in another patch.

Applied, thanks.

--f9r2E9KP2b+SQXLJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQL4mAAoJECTWi3JdVIfQxiYH/i3u8LeYRiWQFHRzdOEUgAyp
VhSBHmOuwfKq1nQYeLmvEvXIhO6ysCpX5cUlnjd0F2bEPcf/HQlA0zmKCf2Gh9Ho
rnAHNnFND1eSwPjxTBsWWhAJfA7zCk3iPL3EGYN62h4hiOJbL1o/Kdc1JJ37+HQJ
JioKFHxEyrPQ9o2Y5obqUHcet5OtvqlQndT7CGeaJJQ9n6bDIWpsCAeTe+t5KjTj
cuBXI+xUPp7qd/hJrgDcXzIuiLQ653DDlTKZUv8zqk/y7z9TCsJgSZ43wiMAOI2w
wLH1txAC36reXD5AXqSFCGOaz7AugJcwZc+qcmNPlEMt0laAKD99yObTCtlfUJQ=
=XXmz
-----END PGP SIGNATURE-----

--f9r2E9KP2b+SQXLJ--

--===============0530670257394114877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0530670257394114877==--
