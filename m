From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm5102: Use put_unaligned_be16
Date: Mon, 29 Dec 2014 15:53:57 +0000
Message-ID: <20141229155357.GL17800@sirena.org.uk>
References: <20141226044457.GA12777@vaishali-Ideapad-Z570>
 <CAK-LDb+i8ATb5GrA6=dx5Y6EZSct+A6epXwNdEoVN4797Yzmqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3059907523391939817=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DAD0266717
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 16:54:57 +0100 (CET)
In-Reply-To: <CAK-LDb+i8ATb5GrA6=dx5Y6EZSct+A6epXwNdEoVN4797Yzmqw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3059907523391939817==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="08mGw3CZk5wypUJm"
Content-Disposition: inline


--08mGw3CZk5wypUJm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 28, 2014 at 04:35:00PM +0530, Vaishali Thakkar wrote:
> On Fri, Dec 26, 2014 at 10:14 AM, Vaishali Thakkar
> <vthakkar1994@gmail.com> wrote:
> > This patch introduces the use of function put_unaligned_be16.

> Hello...Can someone please review my patch so that I can have idea
> about I am on a right way or not??
> I think this is missed by developers.

You sent this on the 26th, two days later on the 28th you're demanding a
review and complaining that we've missed this with a top posted quote.
Even during a normal working period this would not be a reasnoable
demand (a couple of weeks is normally a good *lower* limit, people have
vacations and other things to do), and right now we're in the middle of
the time of year when people from western societies typically take
vacation.

This is not a good way to get people to pay attention, and since I don't
want to create the impression that it works I'd not be expecting a quick
response...

--08mGw3CZk5wypUJm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUoXkUAAoJECTWi3JdVIfQXBEH/A4FhaetcrrGHqHLygT7+6eB
/gr1R9ZzmWmo7aUtxppl0/DdUOsOKWRvd3ET1qXgBdSwOo1ovRYe+3RmnJ6/YoHb
McULYwJ4DWwcE6Y01WZqBYcliqbEaCDaAFQFoINIirMqRzMVagKhV0spzfmX+2IY
BhlBQ1AbMFxN+12cNT8wONsmKiIG4G2SLVl8vLZK+W3MMifg/jvCHmh2mPyfLy98
9TgXddNrHbS097/c8qERVncbNxleGzSq+3iHzkBgZ6RW83rr4D3c9MQdfEBrAtf+
5N1neWxrRopprDMmijrgfHog/3+G5yxaU5pw/jPxOFK7/NWt41r1+ISwUYZKoik=
=nxyz
-----END PGP SIGNATURE-----

--08mGw3CZk5wypUJm--

--===============3059907523391939817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3059907523391939817==--
