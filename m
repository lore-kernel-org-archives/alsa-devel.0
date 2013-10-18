From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: kirkwood: add S/PDIF support
Date: Fri, 18 Oct 2013 13:48:32 +0100
Message-ID: <20131018124832.GK2443@sirena.org.uk>
References: <20130924124122.64834b2a@armhf>
 <20131018003439.GG2443@sirena.org.uk>
 <20131018103019.GW25034@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mxx18rB+F1nHtdkj"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131018103019.GW25034-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--mxx18rB+F1nHtdkj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2013 at 11:30:19AM +0100, Russell King - ARM Linux wrote:
> On Fri, Oct 18, 2013 at 01:34:39AM +0100, Mark Brown wrote:

> > The last set of DPCMish patches was reported to work so should be a
> > fairly small refactoring away from being OK - the main thing is to
> > create back end DAIs for the physical links and then put the widgets
> > that manage the enable of the S/PDIF and I2S interfaces between the FE
> > and BE DAIs instead of directly connecting them to widgets on the CODEC.

> ROTFL.  You're now telling JF to do exactly what I did in my last patch.
> Your two-faced-ness is utterly astounding.

> "widgets that manage the enable of the S/PDIF and I2S interfaces between
> the FE and BE DAIs" is exactly what I did and you told me that was wrong.
> Make up your fscking mind.

No, this is not the case.  The major problem with your last set of
patches was that they did not create any back end DAIs, instead they
created purely DAPM routes from the single traditional DAI out to
widgets in the CODEC.  What I'm asking Jean-Francois to do above is
create and use back end DAIs.

Please let me also remind you that confrontational behaviour such as the
ad hominem remarks above is not at all constructive or helpful, please
keep the discussion civil.

--mxx18rB+F1nHtdkj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSYS4dAAoJELSic+t+oim9bCUP/Ahw56i8QZFIIjoN98uRhbpg
dmLHMohpbQeQ/6LotWSmWP4xMXS+yqlbj5ScYzE1/rk6xg8BuTyujyQOSC3IJAGC
7Gd2BTxyUmWZz0+/kma9bD/U3+d/htuBMHnABgVlAnaZRsoFPfJinNSsq5/s5J+a
XeROoGNONVttaaDRXTNhCUsR7C5QL9xQSI3ayD/0m0i86unPAuSGrpPGGDa7THHB
Z4c5AvSNAlAjnTyhuE73h+qknN8Nl935Y4cff3v3MdrcXPLAQ1tA9pxHRVeQsPt3
wI9xgymqTGT7vnVf27Yfkm7aCBG5FeEGEc9bTTeakR0gxbb+oloEeLaemuxoItWH
ifTRIZITm7ke1KBUTj7NUbgF+Ad+rNIidbNehmruG5+Eog3KrkZe/zp9q8EstuH5
VF10ptLg3Ap1y6Sc0Tx+Tyqxo89UDZ+ZAm+FgrVMSEPFVjY7kMj13UBSqVAF+IAw
Mn+w/MUGV9MzavGJ3Mf4V1O4NOM4wHHb1oxZQyExc2XRUZupP3YhoQK7doCwPew9
+IkxfzhaOVsFs+FXLMqkJrvlChf4hxCTrYth4xZMWYs4hN5vPSjwG4Vsuynf4s7G
ErXfcnrPfDABzs7zwmucetvDF/+sTkgCkyja/QENf/Pyo9z20N5+XhyjfTYaUt6g
aNjkxV6tufNiXrUloswK
=hqj4
-----END PGP SIGNATURE-----

--mxx18rB+F1nHtdkj--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
