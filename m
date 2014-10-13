From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5677: make volume TLV closer to
	reality
Date: Mon, 13 Oct 2014 09:01:10 +0100
Message-ID: <20141013080110.GE27755@sirena.org.uk>
References: <1412892687-1264-1-git-send-email-dgreid@chromium.org>
 <20141009231042.GC18557@sirena.org.uk>
 <CAEUnVG72KL7iYGVgg8UMM6NyeSEe8vFADjFKzE4cLUUYwqTq5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8241137987467005187=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 417BD2604E5
 for <alsa-devel@alsa-project.org>; Mon, 13 Oct 2014 10:01:23 +0200 (CEST)
In-Reply-To: <CAEUnVG72KL7iYGVgg8UMM6NyeSEe8vFADjFKzE4cLUUYwqTq5w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Anatol Pomozov <anatol.pomozov@gmail.com>, benzh@chromium.org
List-Id: alsa-devel@alsa-project.org


--===============8241137987467005187==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bMDD5T6Tp9Yu3dvb"
Content-Disposition: inline


--bMDD5T6Tp9Yu3dvb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 09, 2014 at 07:27:40PM -0700, Dylan Reid wrote:

> I can easily add a flag to the UCM config to hint userspace to divide by 10, so
> I'm not strongly tied to making this change if it isn't bothering anyone else.

I was thinking about just doing this in the driver rather than working
around it in userspace.

--bMDD5T6Tp9Yu3dvb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUO4bGAAoJECTWi3JdVIfQMX0H/0SC4UwpWax6PcxR02zMRw6W
Vw6sTg9CemF9B2UzVhNyhr7fLFArlgeor7Hg66bhwwr1dmmzZUwmSvrdAVv0sLHO
DWnO1XD2X0mMo5p8ZILPyi6sxDm4E32vApxnwPkOkvNh32xC6HjmvQRHMuPNcT3B
/MbEQMliYc+YPGW9Y2V5O3j0U2YkU3w+5pv36fJZs1vQIhDKafVPw+Lg2iK9Ekd8
yzHjd56RDNj9Ma+JFgDNBYn5Jhk45mQMAUqkIv12RhDIlCh3su10TldtOLWasPp5
Ynh9O7OEAwNC3LQMq0+J3j354jqdM7nBn5psatnzld4Cu1uNEhG3TOa4+rAfBWI=
=GD75
-----END PGP SIGNATURE-----

--bMDD5T6Tp9Yu3dvb--

--===============8241137987467005187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8241137987467005187==--
