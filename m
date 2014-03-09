From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/4] ASoC: tlv320aic31xx: Add basic codec driver
 implementation
Date: Sun, 9 Mar 2014 08:12:29 +0000
Message-ID: <20140309081229.GM28112@sirena.org.uk>
References: <cover.1393941102.git.jsarha@ti.com>
 <ba9718f573ca9195c80075a15fe114e0d4557da0.1393941102.git.jsarha@ti.com>
 <20140305015501.GS13126@sirena.org.uk>
 <5319C13B.4090101@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="abrXHEFNt7TvgPF5"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5319C13B.4090101-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--abrXHEFNt7TvgPF5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 07, 2014 at 02:53:15PM +0200, Jyri Sarha wrote:
> On 03/05/2014 03:55 AM, Mark Brown wrote:

> >>+	/* Mic Bias */
> >>+	SND_SOC_DAPM_SUPPLY("Mic Bias", SND_SOC_NOPM, 0, 0, mic_bias_event,
> >>+			    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),

> >The idiomatic thing would be to use the pin name.

> In this case the mic bias comes out of the chip trough a separate
> pin and it is up to board designer to connect it with any (or all)
> of the three mic pins.

Yes, exactly - you should be using the name of the pin that supplies the
bias.  This is how essentially all microphone biases work.

--abrXHEFNt7TvgPF5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHCJqAAoJELSic+t+oim9YpYP/AmHdvQQ1IGy2p4Yr/QSw86B
NipC3EwFBY353fDT0vtuJz63VYdEoaky3266DpKaK7mTl0rTMjGoHhcEZZ6Upl4r
z79o0KkAd465LSEQk8r4qEK7ClnQbPtgT6gKDWvZKIgeaCJTAgxhTiwbskvuGy5K
JH5wnTKO98D0wG5CBYBUCLFJxATDCSufIyjGVNdlQ6T+ULjv3a31aQjAHQ+Cylb7
0eosouK8n7Iy/3UHF+fCkOPPPiVuciJ+r8XN6Qm4SIMdJVKkStNcS1p0wjZlDhtX
AjPaQYw/KTvBxg7E3XoRjLbxPFA4HwJ53YEL5c21IJ/yotm+PHuVWhUvpj7C0lAq
aOrM7DSqVPB2/Upj/+qL1sNv7wA+nqKD0csOaUjGf4lsmAkZLQP2EISJ8UFgnyx5
QI9vBVQ2Wsn+dMUQTTDm94zGL11P+Y2QxAelgO+Uv+joGG/mq6SZmGHfYmbVmvlT
/8O/m0obvdStdNLA435RB154TM469IK9H6bmiV7y40Y3i4Pw8EA6TVnzBk5Xfde9
ulHHb3zdFaF7bZCY4XqnFbBejRxjEblz1GVC5ASHfrm5MbFDns86whQRDejJI9pe
Yc3aVsGFohVtgkq0csDa0j0LXwvv7wJ1Tpn1kZGRRXYxMha98z/LFlMDeDU30cRK
8KShKTfvkqxouOWMd4GL
=5oZq
-----END PGP SIGNATURE-----

--abrXHEFNt7TvgPF5--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
