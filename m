From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Fix double assignment of .owner in struct
 snd_soc_card
Date: Fri, 14 Jun 2013 11:00:20 +0100
Message-ID: <20130614100020.GH1403@sirena.org.uk>
References: <1371203336-16972-1-git-send-email-emilgoode@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0472137707066900113=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1371203336-16972-1-git-send-email-emilgoode@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Emil Goode <emilgoode@gmail.com>
Cc: alsa-devel@alsa-project.org, linux@arm.linux.org.uk, tiwai@suse.de, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, lgirdwood@gmail.com, haojian.zhuang@gmail.com, perex@perex.cz, eric.y.miao@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0472137707066900113==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7/IUJOcl5c0tDlVH"
Content-Disposition: inline


--7/IUJOcl5c0tDlVH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 14, 2013 at 11:48:56AM +0200, Emil Goode wrote:
> In struct snd_soc_card zylonite .owner is assigned THIS_MODULE
> twice, remove one of them.

Applied, thanks.

--7/IUJOcl5c0tDlVH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRuumxAAoJELSic+t+oim9q2kP/AnbRKoCuS/4EoZPVoSWxUZE
Sq4LX2eq/DSR86zhOTMpwqqklNM+Xl+FBrsFTMB7uEkhenY6+zTvKJcKSsdB7Rg2
vWVEflULvI9vNz+MeVFD+ICkou6v/V20iaemlp5F5seFoxCAUAugwFDCEourNK5b
8bc3i2CUWZ8fqJ1EAtvliljaT+b/w7zCh8j+Gc1IPQzWptuQPduNV5GGeOCSkWrZ
JIdcJMW9oBi3dpBaAOm3AtSceV+YYy6XxWTDUds8pU21VDiiXQW2DrijSJue2hxL
ep10ty884mT7ehNUU0o/lXXs81HvktrHtN1BqcEyvKPg1+YalB3JWqt+02QTK9X5
Dn8LFA4dsdZ7BVkhZKHu5lI14wVCbRW5m6XyV1HHCLPRvWJICUFOnvO7xq7ChMNS
3+nMgX3gYehYU1PxsFVquM9d5Or0ixwrlFPWrPMYyc+jKjZtOYX4YSmmysgbr1S1
B8RD/r2ugqpVHyNJvskBrXUpYxYdkOQ6ek/5bDmJ6kfNk3rxDhP5rvah2tQGKXge
KlhRQlOOZ1CePS5Vwv8IgVPanM6JtRDOyf4aDb0wn4m2xQ3Fl+t/JfLlLilQBlFN
asnB6cPw8Kp8DYIkytxkQXdKd5s0uiS7q6fcXjtJe26hT1aKt/n20UtssME92vNC
D0pZyRATL1RpNoDA4Tat
=M+me
-----END PGP SIGNATURE-----

--7/IUJOcl5c0tDlVH--


--===============0472137707066900113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0472137707066900113==--
