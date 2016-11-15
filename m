From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 00/14] SoundWire bus driver
Date: Tue, 15 Nov 2016 19:07:13 +0530
Message-ID: <20161115133713.GL3000@localhost>
References: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
 <20161114121123.xhdrvqn4h6jyd2q6@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="AGZzQgpsuUlWC1xT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161114121123.xhdrvqn4h6jyd2q6@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Hardik Shah <hardik.t.shah@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com, plai@codeaurora.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--AGZzQgpsuUlWC1xT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 14, 2016 at 12:11:23PM +0000, Mark Brown wrote:
> On Fri, Oct 21, 2016 at 06:10:58PM +0530, Hardik Shah wrote:
> > Following RFC series adds SoundWire bus driver interface based on the
> > MIPI SoundWire specification 1.1
>=20
> This is adding a new bus so you should get Greg to review.  It also
> seems implausible that SoundWire is going to be exclusively used by
> audio devices so you should add the bus level code in drivers/ rather
> than sound/, that will make life easier when other users appear.

Yeah he was supposed to be on the CC list, but somehow got missed in the
end. I did ping him though and he wants to review only when it is ready to
merge and not yet..

--=20
~Vinod

--AGZzQgpsuUlWC1xT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYKw+JAAoJEHwUBw8lI4NHbQ4QAJFiwWqcnYKnEuIhDl5+/AB+
5Dtb1DmojlPWu2X6m2UQw3Lw3MGX6Z+R+N0DgppplayZbsIQzyid+ezF5G19LT/N
W4xvKIm+Ab8D6YdNhHdZRIWoFAT2njZOPdhqGI8l4ZpFirvZHwimUr3oa+xfKXWN
HByvkakPTiY5wu3771DTBar/Nrr+HKP/WAELzYQoVRkzTmrVMnqUAKDftXABf7/0
h0ScPyxY7KTxIvkHtDc3uOkFw2zfGOlHGbmpH3xvSmNskk1gwHkwZPjlErY0Iyss
WuiqEYuqu7jfW9l31ok1ZF0/jrGY+gr0jTqPkBhTahxyakWQuuPWXLJNrNNQczXh
5R4rIrl7ABr3PekHtE5eWoXxroNgWm9jENRpXvqDos9nuCQiBy/xCUCEx/YG/IbP
emA9/lbTXShlzJjKzoVhrRoIdlbNAiRJa3IPLLcgkawHizCdzmNR8WS7z0daD6Ow
fjh/HJuH+uaO8PW8ZKwUJEWF7sQQmp+9d890s78RH0nQSh++uAUFVPJMZ6hwM6e5
i51vhudeS3A1rX4tVmMim26LDVspNFA7e4OH7cgj4lMr7IeFZFCzu2dlHH+T0PgJ
wHdtWnr9XIUBVDy/QM+WlIH4wJ8eZvfUHd81Mt1qmENGyJlS0sL5mkSCtcoVUNT8
q57SFnz69cOObkNKa/Rc
=+rcl
-----END PGP SIGNATURE-----

--AGZzQgpsuUlWC1xT--
