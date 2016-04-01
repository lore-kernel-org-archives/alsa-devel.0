From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5514: add rt5514 SPI driver
Date: Fri, 1 Apr 2016 07:17:40 -0700
Message-ID: <20160401141740.GY2350@sirena.org.uk>
References: <1457953101-19348-1-git-send-email-oder_chiou@realtek.com>
 <20160329215121.GP2350@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694FCEA41@RTITMBSV03.realtek.com.tw>
 <20160331165048.GE2350@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694FCF18D@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9084149147651564147=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 12BD1261536
 for <alsa-devel@alsa-project.org>; Fri,  1 Apr 2016 16:17:52 +0200 (CEST)
In-Reply-To: <7EB0DE829A537248AF2ED30C97D12694FCF18D@RTITMBSV03.realtek.com.tw>
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
Cc: Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, "koro.chen@mediatek.com" <koro.chen@mediatek.com>, "pc.liao@mediatek.com" <pc.liao@mediatek.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============9084149147651564147==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bL2/s+BzS+0mqUOB"
Content-Disposition: inline


--bL2/s+BzS+0mqUOB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 01, 2016 at 06:01:47AM +0000, Oder Chiou wrote:

> > Are you *positive* about that?  There look to be routing things going on for
> > example which might be system dependant.

> They are the default settings for the our common hardware planning. If the
> developer wants to modify the settings to match the different hardware
> planning, they can consider to change the settings in the DSP firmware.

So if they do that the driver will not be compatible with their
reconfigured firmware...  this needs to work on all systems, including
end user ones with different system integrations.

--bL2/s+BzS+0mqUOB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW/oMDAAoJECTWi3JdVIfQW20H/2XcvRUQTNun96faT1CU+II/
xlhrnQhb0dE0sBGgHbJLY8v9sTKUG29TEvLKUm0TOSF0jZIdbdimH1eJ1cFYAyUA
valgKVcCuzQA43vjuspePmhyhh/ErX/yJ/MDnWr94zTZ6Ustgu4frXdQdLddn9rm
Yg28+EacyNjlMSrKcO4jq4ZOrx0J5buV13j8hE61/opARW7Sp9MO+r+++EOcfuQp
6ZRpJSq0CasxMG7liCSMSiq90mVM8grT/TONzRMZ259MYobC31URS0JP0jab/6Xj
zkmTSbW5Cw3ifk7rSKSEJVf6/aWWBc6jNbumgQPuDZYVts2Q9B0LPgmAdtfniO8=
=/+O0
-----END PGP SIGNATURE-----

--bL2/s+BzS+0mqUOB--

--===============9084149147651564147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9084149147651564147==--
