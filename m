From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: rt5645: add device tree support
Date: Thu, 7 May 2015 13:51:42 +0100
Message-ID: <20150507125142.GW15510@sirena.org.uk>
References: <1430833322-13531-1-git-send-email-bardliao@realtek.com>
 <1430833322-13531-3-git-send-email-bardliao@realtek.com>
 <1430837158.8043.61.camel@loki>
 <ABFD875FF5FB574BA706497D987D48D701067CC7@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5328855422955254988=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B16CA2650DB
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2015 15:06:45 +0200 (CEST)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D701067CC7@RTITMBSV03.realtek.com.tw>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "zhengxing@rock-chips.com" <zhengxing@rock-chips.com>, "yang.a.fang@intel.com" <yang.a.fang@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "koro.chen@mediatek.com" <koro.chen@mediatek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============5328855422955254988==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U/MfkCnVXJJtEFur"
Content-Disposition: inline


--U/MfkCnVXJJtEFur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 07, 2015 at 05:34:27AM +0000, Bard Liao wrote:

> > > We should really be using device_property_() instead of of_property_()
> > > APIs since we will have to support both DT and ACPI properties.

> Unfortunately, I can't find a way to test it.

Why can't you test it - weren't you testing your original version of the
code?

> Is that ok we just replace all of_property_ with device_property_?
> Also, is there any corresponding API for of_get_named_gpio?
> Or we can replace it with device_property_read_u32?
> I tried the change above, and it can build. However I don't know
> if it can work.

You shouldn't be using of_get_named_gpio() for DT stuff either, use
gpiod_get() which follows the usual pattern of taking a string which is
used to do the lookup with whatever firmware is in use.

--U/MfkCnVXJJtEFur
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVS1/dAAoJECTWi3JdVIfQmVkH/Re4REwYGr66mCoC3uI+kYlp
TdXn4QsfoisqcT5UJh2s7pD4tKcJgPR77bKWmpOiyJOTJvIAt7i70PxVSvgjy2IX
bhAcQotPxq96US0faxw4wZ/RiJ2w8zyMRydSL+rJEkvAnVhjTbSJUX2kEW+IYwOI
tva6qHtx8VvIehfnGM4jq5aEWOSlon9Mty1xZdLPpgMDWzlPf0PSZxItwv29nH+J
WDeYgQeDS7QG1dDMtWc8t8zcGoKwcWp1xkLB4Hw/Vxdf3eK/V1uJF4bi2RMTJpcs
q5nIRjLpC8+plnJludsWfPIJkIWzWbK0DGeTmp1Y1wFFfWzwfahqAXxGj16LOxA=
=xQJh
-----END PGP SIGNATURE-----

--U/MfkCnVXJJtEFur--

--===============5328855422955254988==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5328855422955254988==--
