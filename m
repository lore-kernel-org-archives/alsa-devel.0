From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5] ASoC: add RT286 CODEC driver
Date: Fri, 14 Mar 2014 10:16:03 +0000
Message-ID: <20140314101603.GQ366@sirena.org.uk>
References: <1394521896-27721-1-git-send-email-bardliao@realtek.com>
 <5320CE8C.8090608@metafoo.de>
 <ABFD875FF5FB574BA706497D987D48D7398652@RTITMBSV03.realtek.com.tw>
 <53216DDC.9090502@metafoo.de> <s5h61nizdj5.wl%tiwai@suse.de>
 <20140313192902.GL366@sirena.org.uk> <s5hzjkteufy.wl%tiwai@suse.de>
 <20140313204323.GM366@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D739CDD9@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8036687392870920093=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D3DCD2652E4
 for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2014 11:16:18 +0100 (CET)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D739CDD9@RTITMBSV03.realtek.com.tw>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============8036687392870920093==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="krEeKW19zDoEvn6D"
Content-Disposition: inline


--krEeKW19zDoEvn6D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2014 at 09:38:20AM +0000, Bard Liao wrote:

> What's your suggestion of the I/O part of rt286 codec driver?
> Can I keep using regmap without using its cache?
> Or it is better not using regmap in this driver?

I think we need to understand what the code is actually trying to do -
I'm intending to go through the driver today or before the weekend but
=66rom the quick look at the I/O code I'm just really confused about what
is supposed to be happening.  I'll try to follow up before Monday.

--krEeKW19zDoEvn6D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTItbfAAoJELSic+t+oim9rtIP/2fjadWlv/ZhuOfAxFxlGmLT
3JB6bzc/tDE9kLdGNrWU4zcAWL5OswtbILre09o3ZUoreUNM68X37aPBZl2Fcu1t
DqEewHLTdmPw7yYWmqSEllz220eF6wjTd48Aj9evj55bgKnG3Mo3V2DdiQrzheme
xU6HWHio2DfAIPGi5dAUrk5c/k6zEmJVULFXn3QD/XbZfXdDxDCWoFoDVMgK2XNG
6qkTq8aFGHUZrozv1c/RniG1/SA5E1XYvlQAGnTREQCU39nbS5HkaF6MVSapYzf5
81RSslQhFwhhV6AH6P1hF1ArfL7P+AC947yxiD/w3biFDUJEoHZWE3+8ZsgmeNoc
YrhnPpIBQfE1WRV1EJeGtkY3rTS80M6ijD5GsnWWigvSAGDi4Lru1F3rN9FRn6ke
WweEzQWdyX0VvgoE9JjgetHdggowIizZIrD6A2W4phNu/XQRbnwamuTTSRRLV4A2
E7stwllaC5WgQjWNNgWmknA5YEbHtvKlUVPoYadRJbd+f0GjYouNhQfmrelWNKiA
b2F8udNxB/OySTLCSlvZTDChDDNP3Fi2juWow0UElWfa/JUwAClR+UB16RWqnDJB
wHcPpa+VVaJOk3jsTIJrMQHO/vvZt+Ft8c3DKVKm844W7Lr7sU/4wPcGhMYM5i4J
hL+m86d0FiY6qtmCfP7x
=4O3H
-----END PGP SIGNATURE-----

--krEeKW19zDoEvn6D--

--===============8036687392870920093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8036687392870920093==--
