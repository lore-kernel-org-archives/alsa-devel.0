From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 10/10] ASoC: fsl: Update fsl-ssi binding doc
Date: Wed, 3 Jul 2013 17:19:00 +0100
Message-ID: <20130703161900.GU27646@sirena.org.uk>
References: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
 <1371734429-6081-11-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8672202232846921022=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1371734429-6081-11-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Timur Tabi <timur-N01EOCouUvQ@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============8672202232846921022==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aQoHefV7R8EJhyq8"
Content-Disposition: inline


--aQoHefV7R8EJhyq8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 20, 2013 at 03:20:29PM +0200, Markus Pargmann wrote:
> Update the fsl-ssi bindings. DMA is no required property anymore and
> uses the generic DMA bindings. imx-fiq is a new alternative to DMA

These updates should be done as part of the patches making the code
changes - see the review comment I had earlier for an example.

--aQoHefV7R8EJhyq8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1E7xAAoJELSic+t+oim9uVUP/2F3tPQFDuEDPO1Go0VL3ASy
uVS04PVlcVcBb+7Vl5XSMcePS27c/MkdZcBk3G1KJuyq/DosIjjLzrzbkQbVTR9W
zhE/qLGwAH0+7Dj60IyrXjqDGgaZ0rFzpHRXSZ2bMG8Ng8pjlj4GqiVVW6PeCttT
ToYZ1jCebhap9KPkfkva+ZkBBCFZ7fTE3nLOxr4LVjCUxwwMQ3hZioQ1Z9tejR7w
rskFBOzZ+PDozUJJVkngdsldhN16ncenJnQJT6G0qaOrxPwq+3Bo+AbXA1ntOooa
dsdnsVfZtoIFlllPrMKlcqwv3ONjAIYDgoj/aF6WMOeS/u7JNxvBx2t9Mmoo3OPO
/lxwYmVIkcxT99XaG0x28OdB4fAzfSG3J3O93Jn38S/WnyaBdZkAi+gNPLzqqMaG
KTU7xQuDXU53SKIzXgrnws3yZd5VHPvLj1nnS4PUcTq0EGu+8esP+BR8+X+B3WQE
/RzYVNVAW0+u5tqZ2WZSL3hrQB6VlTB10F8Vsn8pixpL3qEv2wZaCBH3JDuX+Mq2
OoS5VztXN7DyfpAKH5NB7+VBSm1Bv+9qCxqci2n4+owzWbqUkSDq9cTOq+oLsaIf
TdZYeZrXkx1ha0CvvTddwssBnoLRdZ95mrrO/ZEwsNitj3yElUNG2ls316DyMNun
/PtNmfFbQ4m1izQ60hdh
=Mpmi
-----END PGP SIGNATURE-----

--aQoHefV7R8EJhyq8--

--===============8672202232846921022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============8672202232846921022==--
