From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: tegra: add tegra+RT5640 machine driver
Date: Wed, 12 Jun 2013 19:28:04 +0100
Message-ID: <20130612182804.GT1403@sirena.org.uk>
References: <1371058534-25158-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3358797847564771288=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1371058534-25158-1-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
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
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============3358797847564771288==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rePSHXHJe0GetUdz"
Content-Disposition: inline


--rePSHXHJe0GetUdz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 12, 2013 at 11:35:34AM -0600, Stephen Warren wrote:

> +  RT5640 pins:
> +
> +  * DMIC1
> +  * DMIC2
> +  * MICBIAS1
> +  * IN1P
> +  * IN1R
> +  * IN2P
> +  * IN2R
> +  * HPOL
> +  * HPOR
> +  * LOUTL
> +  * LOUTR
> +  * MONOP
> +  * MONON
> +  * SPOLP
> +  * SPOLN
> +  * SPORP
> +  * SPORN

These should really go in the binding document for the CODEC and be
referenced there in case new packaging variants turn up or something.  I
know we've not done that for some older drivers but would still be a
good idea to start, if nothing else it saves typing for anyone making
any other machine drivers with the same CODEC.

Anyway I'll apply, this can be changed later.

--rePSHXHJe0GetUdz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRuL2xAAoJELSic+t+oim98R8P/jZNL3Y1Fm75248UKY+kj47o
dI46n+0h65iM+BBEeSoT2q0E0Q6n1tMrSCZLvAG1Q+gVeRMhD55HpIG2RcpISzfq
N7aZSey2ncxFjF3rMypk4KRmVF/efqSqbndbIMMIj9aLIUvNQMU1MyMryMphoeKf
fs0CutqBQUSZeYSc/Ai5P/irC8nCWv0GeYkLvdaJXLNgQrTq9a9lQ8cO7tjPTGvq
Tn0vXqasMLyOVO/qevObPv1MOhFTiw3g0N1StbM5oo0Vh5ZMO0KKHB8S0HDnWxP2
NQzx0YfvFn1gjCdv02Ea4NQQp2bC5H9ZdRR6kQr7I0jgmf+o2Vu/bsKk13HI+TM5
u7p9lObG31HxdPT9DmxKtb/nWeut2WKUgTkrSBsliseohDILTCKDrzMe3VKZ2lfs
aENYqoguypO5/B6qWWm9btEIhcSs219/NKOWDqKH8BZqfSd7dtZOELidteoJuEWU
mNhOGqeLPcCLVQuZgpNVjMThnGcphfm7KYexDCZtVvPlvuGyjl/b73CKa75ZeMKI
GlqccdMPqi3cFNO+uJisr//pwYJ0Fv+HETaLOi7wLe/CWqk+n9b4x7Bx2GNnJF+M
dadVtLO7aRaeV3lTbqf9t0VVPX4w8NlJ6oKwhh/G6UQzP4JI6Gk3VBON3fpFhZbu
40k606iUNoa094b0D1qn
=dxWB
-----END PGP SIGNATURE-----

--rePSHXHJe0GetUdz--

--===============3358797847564771288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============3358797847564771288==--
