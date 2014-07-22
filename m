From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 1/1] usb: gadget: f_uac2: Fix pcm sample
 size selection
Date: Tue, 22 Jul 2014 12:44:48 -0500
Message-ID: <20140722174448.GL20588@saruman.home>
References: <1404411328-32566-1-git-send-email-sebastian.reimers@gmail.com>
 <s5hha2xu19g.wl%tiwai@suse.de>
 <53CE9ADF.80604@zonque.org>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yQDbd2FCF2Yhw41T"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53CE9ADF.80604-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Sebastian Reimers <sebastian.reimers-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reimers <sebastian.reimers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

--yQDbd2FCF2Yhw41T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2014 at 07:09:51PM +0200, Daniel Mack wrote:
> On 07/04/2014 07:43 AM, Takashi Iwai wrote:
> > At Thu,  3 Jul 2014 20:15:28 +0200,
> > Sebastian Reimers wrote:
> >>
> >> The pcm playback and capture sample size format was fixed
> >> SNDRV_PCM_FMTBIT_S16_LE.
> >>
> >> This patch respects also 16, 24 and 32 bit p_ssize and c_ssize values.
> >>
> >> Signed-off-by: Sebastian Reimers <sebastian.reimers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >=20
> > In general, this driver should check more on p_ssize.  This can be any
> > integer value passed as a module parameter.  It should be cut to a
> > sane value or give an error in the probe function when an invalid
> > value is given.  Ditto for p_srate and other parameters.
> >=20
> > Also, I don't understand the logic of the code
> > 	runtime->hw.period_bytes_min =3D 2 * uac2->p_prm.max_psize
> > 					/ runtime->hw.periods_min;
> >=20
> > But this is mostly irrelevant with this patch, so for this patch:
> >    Reviewed-by: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
>=20
> Felipe, are you fine with this one?

seems like I missed this one, do you mind if we take it during v3.17-rc
and add Cc: stable ?

--=20
balbi

--yQDbd2FCF2Yhw41T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTzqMQAAoJEIaOsuA1yqREiO8P/jDaeqQgH+/qdVccHDpbp6MM
cWUDEFNyTZH7qwi/R3Fa3ZWB1JwHiG2By7BNY7kdX73GuRIXSRlaimrQIILfu/nj
yZc+/TG0J0s7Daq6qYDjQuePgGToxmOjkZOrbnogNUBdVuaMWMX9rHGUMdTWHCCY
k4we24Qttlc/EEqXuDSlClPeSnrSyKjb9u2kyI3LRDCo/vgITDe+V+scN7p04ZBd
Ao5De+qigpcsr5QLA4L5Ji6QE2mrhCOCAC4TvU87iyFZRa0s5pRmfKhT0a4t8C7e
YrN0/ljA/Io3ze+KxMjyiNzlyB3asVe68ek/GeCX8Vzq8KMlseHTu6XwUxiOyXch
8DtR1tjMKqZ+Rc2iwz6IYeA6jshnmstyy2sMjJkoNarrCkjYQzZ3ti2exm9jw4ZV
y12WTG7avoQVXflrrePF7ts+rL5MoD9c8go/0ejE7LVzfpY343q4e6syZwC/c5fc
VQsuW5FHmt75X/Y3xSLggGhdzj7JKYqgblL8KaLgG23Yqmxs8jyEMgdPULXgXwI8
+MaZ2aCWsX8EQOCIMHYqCCfxqcl1ZgtwI218P70pSNe6+mHPXMQvt8ba6V6OVAon
bhChPHPOjYvV3QJWhn+iTrsZpmDEb7RMOUyulXcIERW9OoawZIaCKGMQkzuSjKRW
/KcW8A7gEGFUes+duKCD
=CJAU
-----END PGP SIGNATURE-----

--yQDbd2FCF2Yhw41T--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
