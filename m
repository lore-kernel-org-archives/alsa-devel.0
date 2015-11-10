From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] ASoC: codecs: Add da7218 codec driver
Date: Tue, 10 Nov 2015 16:42:02 +0000
Message-ID: <20151110164202.GH12392@sirena.org.uk>
References: <20151106115451.GG18409@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CAAD@SW-EX-MBX01.diasemi.com>
 <20151108103429.GC6746@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CC6C@SW-EX-MBX01.diasemi.com>
 <20151109140225.GA26072@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CEA5@SW-EX-MBX01.diasemi.com>
 <20151110141513.GF12392@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CED5@SW-EX-MBX01.diasemi.com>
 <20151110154434.GG12392@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CF5D@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xQmOcGOVkeO43v2v"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337D460CF5D-68WUHU125fLLPO1uwJ3ImwLouzNaz+3S@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--xQmOcGOVkeO43v2v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2015 at 04:21:04PM +0000, Opensource [Adam Thomson] wrote:
> On November 10, 2015 15:45, Mark Brown wrote:

> > That seems like a particularly unfortunate choice given that
> > VOICECOMMAND is used in the standard Google headset mapping (see
> > ts3a227e for an example, that's a device specifically aimed at providing
> > accessory detection in Chromebooks).  There's also been some pushback
> > against using the input devices due to the difficulty in enabling apps
> > to access input devices - ALSA controls were preferred instead but
> > that's less helpful for tinyalsa.  Perhaps that can be added relatively
> > easily, or a uevent or something.

> I chose VOICECOMMAND as I thought this kind of feature might offer the sa=
me kind
> of use as the physical button, but if this only for Google headset use th=
en fair
> enough.=20

No, that's a generic button but the point is that the expected workflow
=66rom userspace is going to be different if the user pressed a button to
initiate a voice command compared to if they use an activation phrase.

> > Not sure what the best way forward here is, the other implementations of
> > this that I'm aware of do more of the detection in offload and present
> > streams of detected audio to userspace via normal capture.

> Yes, this is far more simplistic, and any voice processing or capture is =
not
> handled by the codec. It just an indication of above threshold noise leve=
l at
> the mic. For the implementations you know of, how are those events indica=
ted to
> user-space?

I'm not aware of any implementations that just do the activity
detection.  I've seen hardware with it but nobody using it in software.

> > I would at least suggest moving this into a separate patch and doing
> > the integration separately.

> Are you happy for me to leave the actual controls for this feature in, wi=
thout
> the user-space reporting side? Otherwise it's a pain to strip that out, a=
nd then
> re-instate later. The event can be masked off until the user-space report=
ing
> is added in a subsequent patch.

Possibly, let's see what the code looks like.

--xQmOcGOVkeO43v2v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWQh5ZAAoJECTWi3JdVIfQuIUH/jPDxB0jpVqwXZxUtj7ZB3Hz
G6SvrvGa1aC3AkMqDdJWF5xpBl44vRB+vO0oF2utzF06u8lzFYiDArQ7zGWDPH6V
Xpwn+kzY/7UjO2HPMZMKXBBYy7/qtKAXsQK0XtoE1/LjrhHmiD5B6a6SJqrZcPxy
N6gsWDpt++R1Fsldy1+WEZWiWMQDzlxvczVepO428yKlSf3T8Y9utL6BmQSL7zOs
JhNbTZr1arzJCJLdLVoRB+UWVE8WPTjOXBAxLZVwmylimkBU9LGWqaE1ApFtFrXe
qYzpUmoAYa8mrp66yZ3bkNT5VKnXvzzronCzHFi0m3oNwzI3SfOCrOcVPTifSpI=
=PiIb
-----END PGP SIGNATURE-----

--xQmOcGOVkeO43v2v--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
