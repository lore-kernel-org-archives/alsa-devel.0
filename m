From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: set correct platform drvdata in
 pcm030_fabric_probe()
Date: Tue, 12 Nov 2013 11:31:04 +0000
Message-ID: <20131112113104.GN2674@sirena.org.uk>
References: <CAPgLHd8kfDJJg045WbRrrd06rKSsUZkYha2nFPuXkbkAKRvpTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/TUrtqMIkCP4YtJm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPgLHd8kfDJJg045WbRrrd06rKSsUZkYha2nFPuXkbkAKRvpTw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, grant.likely@linaro.org, rob.herring@calxeda.com, wfp5p@virginia.edu, mpa@pengutronix.de, yongjun_wei@trendmicro.com.cn, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--/TUrtqMIkCP4YtJm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 09, 2013 at 08:41:14AM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> platform_set_drvdata(op, pdata) in pcm030_fabric_probe()
> will be overwrited when calling snd_soc_register_card(card),

Applied, thanks.

--/TUrtqMIkCP4YtJm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSghF1AAoJELSic+t+oim9mAwP/0Kcr3GXZOqB5AuNWtki2xcW
9o+gHY4cwKMX18MtYzcqIkIDMCwB6LidD9iDoQXvKpN5u8TTk7bgA87Vjt9SrWBd
/ZhOdt78GDNfDuEQIVvzW3thWHkkwbp5HnnUSNUeHbFoPaywpimhZBRrPQw1C3Dl
gpdMKm4s8G/Nhu1YRG8WOPnVqCLxfWXg7SINmvHA22mQsuOOgPfsUJTMaubA/Z+m
2LmzCpSZLyK6Nr066wiRRyCFntXRAknQTgvYzs/KvC2lsFy0YMTmnJBAcbzIafdC
0UbdL5NFVahED52HW/i37ZgltE5C1yaf07jP7jtcTqRSNKfqPQRDd1WSxLbEHOd8
G22ivGTU9Rcxbb4vtadsrKHq9HpKj9kZHjIBQyIUw1OVMQLwYeEdbYfFU/yM8WY0
DO/WvyNNXSIRClNJF+NSiFgqCTfCLbvmeH7tnf/2aQTp9cLRMWKlraxmdGCFIfHG
9tEcL4tx5oQIsUUKOF3LYX/Hcc2ygS4ThJQZLrg2vCjjLXbJv3Qbnoi06DfS01gf
jyk5vaz+MGxHe22FRMWx7sR8XWeiJbXb97u+cJrYqLwo05HMUTP1xrsX7oOKTPJh
tt93UaF/MIR974vAUZQQiJTsn5SvXmHD6FwD4Yb+LrZ0VaQAaFqUVgw0Osu53vXa
T+PWcXGGYq+tZ14rxmEQ
=nXDD
-----END PGP SIGNATURE-----

--/TUrtqMIkCP4YtJm--
