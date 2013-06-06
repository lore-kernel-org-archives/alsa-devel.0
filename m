From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] ASoC: WM8962: Create default platform data structure
Date: Thu, 6 Jun 2013 09:42:59 +0100
Message-ID: <20130606084259.GK31367@sirena.org.uk>
References: <cover.1370433363.git.b42378@freescale.com>
 <4e85e3a9b5dfdc04899958424eb53a9cfd0f4ace.1370433363.git.b42378@freescale.com>
 <20130605122511.GB31367@sirena.org.uk>
 <20130606032125.GA18783@MrMyself>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3044696252893469418=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130606032125.GA18783@MrMyself>
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
To: Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============3044696252893469418==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xKAOFH8xvSgM/GoA"
Content-Disposition: inline


--xKAOFH8xvSgM/GoA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 06, 2013 at 11:21:26AM +0800, Nicolin Chen wrote:

> Hmm..sorry I don't fully get it. Does that mean I should do something like:
> struct wm8962_priv {
> 	struct wm8962_pdata pdata;

> instead of pointer? so no devm_kzalloc() for it any more?

Yes.

--xKAOFH8xvSgM/GoA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRsEuPAAoJELSic+t+oim966cP/jy6V3vEiHufeikqvOcbZUNU
r9l9YvTleDgmooovSTM+t2gNp6MBhkhb2/Qdd4qqwBTspwVRJrdsda8FWT3sW3nC
IawPLWHoxBeZoU2kUGMEdi09BfQ+cZFK4mxkWAIJ1/EmZ9B+Hf8k0vXSgRNdt3NK
Q+GukLmJqhdHKvLl8qsZCvq8hg5D150fKz90YzUd7Y0kEyFLAhwuVbOaDAn/hv+M
AKXnnXP9Jirh5xTd+8r5SyXKtPcP1+9aE7Bv0WNkIxcfjocaLbLwTt9VTC8OAxsr
Lbmt6E8LFKcYYH8+ir/GMxkjpp7V42CaRQQZpch6MN/083Ol71znnLCbpsuW2+di
iXDkNLNj3A/AqRa/uDPaavlpcZrWxlE4D3AiRJb/it5myMlrScbM63SFj07zgQIu
SElGGXo7bMvFX2LC74pnv7kD6Ux3SfIj3qvHIUuC/1Xnt+UByd+SBxmZKYmYqavs
1Tq0JpD4+zBLIopHrsgJfRhP6d+EBOYyjz3QEOGm0p+yqNUoszQAM6AZtC1Gh7iD
Ldz5GcAtugzXCycwp2pULOIHkbHagixZdfzqYDODUI2dw/p3cadVJJFwxCxRAvjK
maxFRSqSK69x25ftZdGPfL5uApDES67+XJfYPWDC/47Mqp9ftJg05Ka5G8p0+cLp
XfSQJo3xorMWTiKp+Gwu
=sktu
-----END PGP SIGNATURE-----

--xKAOFH8xvSgM/GoA--

--===============3044696252893469418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============3044696252893469418==--
