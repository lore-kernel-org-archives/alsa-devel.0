From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] ASoC: rt5677: Reintroduce I2C device IDs
Date: Wed, 23 Aug 2017 20:05:25 -0400
Message-ID: <20170824000525.GY17193@bill-the-cat>
References: <1503453106-5564-1-git-send-email-trini@konsulko.com>
 <1503498573.25945.69.camel@linux.intel.com>
 <20170823173912.GN17193@bill-the-cat>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZlyDGGI/Hohreivc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170823173912.GN17193@bill-the-cat>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org


--ZlyDGGI/Hohreivc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2017 at 01:39:12PM -0400, Tom Rini wrote:
> On Wed, Aug 23, 2017 at 05:29:33PM +0300, Andy Shevchenko wrote:
>=20
> > On Tue, 2017-08-22 at 21:51 -0400, Tom Rini wrote:
> > > Not all devices with ACPI and this combination of sound devices will
> > > have the required information provided via ACPI.=A0=A0Reintroduce the=
 I2C
> > > device ID to restore sound functionality on on the Chromebook 'Samus'
> > > model.
> >=20
> > > This is a regression from v4.12 on my laptop (a Chromebook 'Samus'
> > > that's not running ChromeOS).=A0=A0My fault for getting out of the ha=
bit
> > > of
> > > trying -rc1 when it comes out and not spotting this sooner.=A0=A0I'm =
not
> > > 100% sure if this fix is correct for all cases as I'm only able to
> > > test
> > > my hardware here, and this does fix my laptop.
> >=20
> > Are you sure the commit ddc9e69b9dc2 ("ASoC: rt5677: Hide platform data
> > in the module sources") does not fix your issue?
>=20
> As that's not in master yet I can't tell.  Can you give me a pointer to
> somewhere?  Thanks!

OK, my bad, it has a different hash upstream, but no, that change
doesn't fix things as I see the problem on top of Linus' tree.  Thanks!

--=20
Tom

--ZlyDGGI/Hohreivc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZnhhFAAoJEIf59jXTHXZSXeIP/jACeMELv85Hl8dAJ4Di40ws
MMk+VzRuTRf3SicXxPqiHSLgDQ5DQkReNrR1hR1zpL9GE4qC+6TrwLjq0UO+J/ef
1dzifnksG389chNpnWO2ICTPM5u0cxzCMLs6UoTHELh2nEciT+F1qQ66eiOkvmvx
U+2RG7Bq6AjYOB8fbnbH1GYq/8wz4tDfhtXWtLB1RsWSoj+8LbqdiO1+LGNk5l7/
re0zgxbpkRTaF9ZKrEu6NaqiAqlvlbCh1qmbR3sUsReU5gANEPDzUqn0bYQbzRkr
rfLnWsyM9W4zuLiWahW3F3G1GmYqnU7jurhatOYn0/yvW2qslzLqePjLmwrz6Pvk
nf8RwiwVXRy20hliEJ0VNb2pQASttNMW/XFhYmn2UQ4fD80AYDM2bbcDTZ6jYcu4
03EnL8/8RykcCTHaX+wPBtVzw648eP9SFFrzOSojaV4b5WZYRmN2/HxZTK1wX09v
9+ZCO51qAug9Uj09pmLbSAjgKAOtebamf9kJmKZHIWp28FN/z9jtYy2Uu67go9cw
XhcG52REma4Ma5fDGXiWkpBb7MW7GtAUtaVt/BNbXKuiGDMBc1x/VmtCGAHgfA9R
CT3Q8aD5gIV/DQCsAI710FPLPiMRff2FDS3uU3CIkK9t1WYAwx1VK4lzMyJX9xTC
/QE6y+WiMu1HoFErsxKq
=KHJp
-----END PGP SIGNATURE-----

--ZlyDGGI/Hohreivc--
