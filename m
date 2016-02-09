From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: add "coreboot" to
	dmi_system_id list
Date: Tue, 9 Feb 2016 18:41:31 +0000
Message-ID: <20160209184131.GM13270@sirena.org.uk>
References: <1454304078-12322-1-git-send-email-bardliao@realtek.com>
 <20160202194936.GB4455@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D70110F96C@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1138133338270032150=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A98762614C5
 for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2016 19:41:37 +0100 (CET)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D70110F96C@RTITMBSV03.realtek.com.tw>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "Koul,
 Vinod (vinod.koul@intel.com)" <vinod.koul@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, "rakesh.a.ughreja@intel.com" <rakesh.a.ughreja@intel.com>, Flove <flove@realtek.com>, "Bossart,
 Pierre-louis (pierre-louis.bossart@intel.com)" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1138133338270032150==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wAI/bQb0EMvlZCHl"
Content-Disposition: inline


--wAI/bQb0EMvlZCHl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 03, 2016 at 02:37:08AM +0000, Bard Liao wrote:
> Add some Intel folks.

> > the target for this change is internal-only development hardware it
> > doesn't seem unreasonable to expect people to be able to keep changes
> > like device ID updates internally.  This is one of the many costs of BIOSes
> > that require us to do such DMI hacks, it'd be much better to improve the
> > firmware and the driver so they can specify required properties directly
> > rather than relying on DMI.

> Agree. We will find a more reasonable way (maybe ACPI) to specify
> required properties directly. However, I can expect that will take time.
> If you think use "coreboot" is not a good idea, can we match the
> DMI_PRODUCT_NAME field just like before until we finish the
> implementation of specifying required properties directly?

Sure, new matches for specific products are fine - it's just that this
is too big a wildcard.

--wAI/bQb0EMvlZCHl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWujLaAAoJECTWi3JdVIfQjlkH/iY1BR3SW9tubbP4kqbpfd+x
Esumco40cifK6FSEUVfhY8u70k7eW8uR86MKCiFbXcCykzAvkK8IGx0BFSLL+OTa
oVl4oodlXaOFO8usbIi8YMkGAXuoD2mjtpsMZ9r9Ehz1S9CJxF3KiP/20pHzdEzw
MhnXI1ebst6Y28LZbY+G2Wv8cbfFfYVuqcniiBZ1tuxl6xN6ZWI3jgxYPvuJWM9D
FRPFkQcRvkagXGa0Qurwrr97V4K166IXBZDfrGdvo1RljthChAfY47Ogj1ZCE/Ty
FuBsg/JuQZp49LrAH7pHAUVBDPx4lh/DUry6N/C0gzZBSjCIm34eXf247FYp5Wc=
=EfR9
-----END PGP SIGNATURE-----

--wAI/bQb0EMvlZCHl--

--===============1138133338270032150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1138133338270032150==--
