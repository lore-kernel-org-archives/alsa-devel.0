From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: mc13783: Add devicetree support
Date: Wed, 30 Apr 2014 11:06:53 -0700
Message-ID: <20140430180653.GB3245@sirena.org.uk>
References: <1398495423-2223-1-git-send-email-shc_work@mail.ru>
 <20140429222522.GS15125@sirena.org.uk>
 <20140430140849.GR29462@lee--X1>
 <1398867073.695596467@f224.i.mail.ru>
 <20140430141708.GS29462@lee--X1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140430141708.GS29462@lee--X1>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 30, 2014 at 03:17:08PM +0100, Lee Jones wrote:

> Neither Mark, nor I can apply this patch independently, we need to
> create a shared branch somewhere, or we'll risk conflicts at merge
> time.

You acked it without saying you didn't want me to apply it...  usually
that means someone is OK with things getting applied.  In any case, as
ever it's on a branch by itself so you can pull it in easily.  I just
tagged it.

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/mc13783-asoc

for you to fetch changes up to 780aaeff96819ca58e0cad830bfbe6eee9aef82c:

  ASoC: mc13783: Add devicetree support (2014-04-29 15:24:54 -0700)

----------------------------------------------------------------
ASoC: mc13783 DT support

Tagged since it updates the MFD as well.

----------------------------------------------------------------
Alexander Shiyan (1):
      ASoC: mc13783: Add devicetree support

 Documentation/devicetree/bindings/mfd/mc13xxx.txt |  3 +++
 drivers/mfd/mc13xxx-core.c                        | 10 +++++++---
 sound/soc/codecs/mc13783.c                        | 14 +++++++++++++-
 3 files changed, 23 insertions(+), 4 deletions(-)

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTYTu6AAoJELSic+t+oim9Vh0P/jYa1eG8S1qWD2CwLbOj5Dqi
oWjI0D2qQrIOp9xZcoFfi5Qhov6eRPkVLrthcXKaJymz5BbpuA1GzXmMRzbm5+Gr
96LWV46zSmJ7u4I/sdgd7UCQ6uLiZjeblTn7KOlvi0Hff6BWnvlmT6dkFTJNY7rF
66e8JU7Y+pALqgpQPwjNyCOqk/NtI0YSQmLXSn/M+uCAt4eHHHRDgkMtf2rK8q8L
ng1I2UFBGSUXKCvtMn9+KCtcgfiMMOdLTYczTDBJzR5xTVyB4fpAxs0A4AD+0waY
YhLHTveCkbWPNY9O+RUKBaSs8ZK3xVvkx6aCHswF/Aoi7wiAQhJXGH5QtrZqJrGk
pMTCyNgvHjmeqLdmOSg82R4um9WAZbhUEbAUXdI6kWxQwxrnQD0j3EkMz+6V/moW
0PYKNdMt6LmU3411SjjtvkOhhkxnCWm+BmYXwz8LLwiHc+/7YMjFyz2awR5Wl3ZV
fKO0t28nGyFzX9dAtgyVHPXW+vDsWb+0CmE4rbDsRUq0TATi9nLRRe6m1jb8VyNn
9bLmB5X290t7MbPmYRQjHaNzErfbGx5KIL1AxnZWH3+4r27G7Y9xV2XvJgARRZOx
u5X3MvIa+9vH2Ou+MeS9mbAksemn6+JuDTPOvjLJwqjilm4jZsMKEawHiVpKYBBP
Sd7pIIUQc4kcS/2ymM+9
=XeyG
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
