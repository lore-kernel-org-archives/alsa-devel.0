From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv2 5/8] ASoC: SGTL5000: Enhance the SGTL5000 codec driver
 about regulator.
Date: Thu, 7 Nov 2013 20:38:38 +0000
Message-ID: <20131107203838.GC2493@sirena.org.uk>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-6-git-send-email-Li.Xiubo@freescale.com>
 <20131101185045.GG2493@sirena.org.uk>
 <1DD289F6464F0949A2FCA5AA6DC23F82876EFF@039-SN2MPN1-013.039d.mgd.msft.net>
 <20131106100305.GI11602@sirena.org.uk>
 <1DD289F6464F0949A2FCA5AA6DC23F828783E6@039-SN2MPN1-013.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7752616928672572048=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1DD289F6464F0949A2FCA5AA6DC23F828783E6@039-SN2MPN1-013.039d.mgd.msft.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Li Xiubo <Li.Xiubo@freescale.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, "timur@tabi.org" <timur@tabi.org>, "perex@perex.cz" <perex@perex.cz>, Huan Wang <Huan.Wang@freescale.com>, "LW@KARO-electronics.de" <LW@KARO-electronics.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Shawn Guo <Shawn.Guo@freescale.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Zhengxiong Jin <Jason.Jin@freescale.com>, oskar
List-Id: alsa-devel@alsa-project.org


--===============7752616928672572048==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CdJmqRynzCmrDwyG"
Content-Disposition: inline


--CdJmqRynzCmrDwyG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 07, 2013 at 03:01:02AM +0000, Li Xiubo wrote:
> > > The SGTL5000 is based on regulators and when it is disabled, there
> > > will be an error returns directly while the SGTL5000 codec is probing.

> > What makes you say this? =20

> static int ldo_regulator_register(struct snd_soc_codec *codec,
>                                 struct regulator_init_data *init_data,
>                                 int voltage)

If the regulator is not used in the system then why is the driver
getting as far as trying to register it?  Surely this is a system
configuration error?  This all sounds like some problem with either the
system integration or the driver which is causing it to try to register
the regulator needlessly - you should be fixing that problem, not adding
ifdefs.  I'm still unclear on exactly what the issue is so it's hard to
say exactly what the best way forwards is.

--CdJmqRynzCmrDwyG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSe/pLAAoJELSic+t+oim99WkQAJmoFKa2Rxz+LvulqUAubIQZ
0bAeSYIuQKpgagL7BdzTsqxBrJCnDMeXEZeootYApoG7tUbebtIMxbvThbAg5crq
Mpqn51/w4mCGUzZugWRlHqKo4d2+GwPeFqC95hpNvjoOxNyn+zpl1cY+f70r7VV+
aKw1HHjD6z9ylDPiVwiPGUKg/P/ovmeaL250QW9GYrpcyoRYGyjYxRQqcAtTVU7e
yZ+bV7mLtgRylRp7fXtHiNEz7bmzIlWd+hxyZ89lKrqYwzmlXISPA5iW52sxgoew
i2HRgibRdV5ba1L/cKfxsAVJ72piDyFDzeC/50vx3ZQQQZ6IDD7UQ5Fv1LgSOKVK
gOdj+ZL6d885HquLtOQf/Dytdoz676vuFvBAjVc7hkvX+gwt21VQWY6WU98SpK0M
iXXy/7kFXh2LkIyQ6wzR1l3CkSlnwuWXTaf0OkpuDrsjIHxkZ/fFXlFSsN7UWE9/
bppBmkVvEMLAcm84U5/by8+uEr5wPf9oJgatfVBUfuiCRlDMOymTSlzguCz0fWYW
sqlSAt7+ttAA45PXwiLp4F5XiGkj/ai8F0IGNN+b1HOzCej5zmaKx6pWKm3gMa5U
1rhfGMJE+1SclPaTuJvIQygLwx6/n+VsYcxmKzNKreVUpfHhGVn4+g2OVYUhUSTF
yFN3a1PSBcNCxyw+Uxz5
=f1d4
-----END PGP SIGNATURE-----

--CdJmqRynzCmrDwyG--


--===============7752616928672572048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7752616928672572048==--
