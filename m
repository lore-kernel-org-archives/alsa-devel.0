From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH BAT V1 0/7] BAT: Add Basic Audio Tester
 command line tool
Date: Thu, 17 Sep 2015 18:42:42 +0100
Message-ID: <20150917174242.GF12027@sirena.org.uk>
References: <cover.1442298607.git.han.lu@intel.com>
 <CAG5mAdwkSn4975waeUrpp6Bm5yBk2217Oa6+gQH-=toLu7OMxQ@mail.gmail.com>
 <1442403626.10528.50.camel@loki>
 <CAG5mAdzt-zYX7mp5Nhnmdr_874KhtoRdBMXSmG1JkMvTTB54rA@mail.gmail.com>
 <1442486431.2520.34.camel@loki>
 <CAG5mAdw1jjVGeTi2k0QLCTVv+Qr-Hy3UMZLuT1M=f2uHje32kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0336398660012794924=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DB2BB265872
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 19:42:53 +0200 (CEST)
In-Reply-To: <CAG5mAdw1jjVGeTi2k0QLCTVv+Qr-Hy3UMZLuT1M=f2uHje32kw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, bernard.gautier@intel.com, han.lu@intel.com
List-Id: alsa-devel@alsa-project.org


--===============0336398660012794924==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ywSK4AnVQWpBmKmF"
Content-Disposition: inline


--ywSK4AnVQWpBmKmF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 17, 2015 at 06:29:58AM -0700, Caleb Crome wrote:

> > Yes, PM suspend and resume of device. We have some scripts (to be
> > upstreamed later) that would play audio, suspend the device, resume the
> > device and then retest the audio.

> That seems particularly likely to result in multiple codecs getting
> out of phase alignment.  i.e. when restarting, you want to be sure to
> follow the same startup procedure as the first time to make sure all
> codecs are aligned.

Why should resume be any different from initial system power up?

--ywSK4AnVQWpBmKmF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV+vuSAAoJECTWi3JdVIfQy1gH/1iOA7ez/hqPML+gknk2HZWp
/0mkBfO3mcwjnhzgdP+ypMoMuls6SFs8bIq88HSkf6luVjACNQiw1RzF8duR1v6w
4BhoEJSbloBzG/mA5ag5dxdqJlSIPGetuah858OKUgV+VehHWut9wHrRz/O6bYQr
PLwFicl2nk5RAneUCp6rtp/AyZIyNUdBMpPoKeMCp/m/TEtRoJz8tHX4DL9pfb7K
2GDy06DIKpeuc08Mbj1iZRkqF/mb5LuoaK9nEJLuM7CSIKQsmSYvB2kI+qEJdYN+
824v+IRXrfrxEqtBVo+Wv8ok/AS5OrH5Ol8e48Dv9Ty9qiKjXM2FE3Uqg6zWwxk=
=/hUM
-----END PGP SIGNATURE-----

--ywSK4AnVQWpBmKmF--

--===============0336398660012794924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0336398660012794924==--
