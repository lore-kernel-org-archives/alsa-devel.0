From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4-resend 1/7] ASoC: sirf: Add SiRF
 internal audio codec driver
Date: Wed, 5 Mar 2014 11:34:19 +0800
Message-ID: <20140305033419.GX13126@sirena.org.uk>
References: <1393399342-31177-1-git-send-email-rongjun.ying@csr.com>
 <1393399342-31177-2-git-send-email-rongjun.ying@csr.com>
 <20140227053339.GU9383@sirena.org.uk>
 <86130EF012BDF348AA0D464A4F449478012AE51755@SHAASIEXM01.ASIA.ROOT.PRI>
 <20140301031646.GJ29849@sirena.org.uk>
 <86130EF012BDF348AA0D464A4F449478012AE52440@SHAASIEXM01.ASIA.ROOT.PRI>
 <20140303050745.GP2411@sirena.org.uk>
 <CAGsJ_4xjCsVuySJdarevvJ5qgMxKFNyDZi_nb_Gh6+DBd4uKrQ@mail.gmail.com>
 <20140304045815.GL2411@sirena.org.uk>
 <CAByv0RPTqUrB_8ojMWKAXk8H_GChryWHuK0NW+e=-Srx2L31sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2926960863169973983=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 538C1264F02
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 04:34:41 +0100 (CET)
In-Reply-To: <CAByv0RPTqUrB_8ojMWKAXk8H_GChryWHuK0NW+e=-Srx2L31sA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: RongJun Ying <rjying@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Barry Song <21cnbao@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Rongjun Ying <Rongjun.Ying@csr.com>
List-Id: alsa-devel@alsa-project.org


--===============2926960863169973983==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hEi834+foqWOL7fK"
Content-Disposition: inline


--hEi834+foqWOL7fK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 04, 2014 at 01:11:50PM +0800, RongJun Ying wrote:
> 2014-03-04 12:58 GMT+08:00 Mark Brown <broonie@kernel.org>:
> > On Mon, Mar 03, 2014 at 03:48:02PM +0800, Barry Song wrote:

> >> here the clock is an internal clock in the internal codec. the
> >> external clock of audio controller is managed in system suspend/resume
> >> as you see. but they are not managed in runtime suspend/resume here
> >> because the external clock is always enabled to make sure the charge
> >> pump to be working to make the board have stable current and voltage.
> >> otherwise, touchscreen ADC will not be accurate.

> > Why aren't these drivers keeping the clock enabled themselves?

> The charge pump register is a part of  the audio controller.
> But this register is impacted the touchscreen ADC stable.
> So when the audio codec driver probe, It always enable the audio
> controller's clock,
> and must be set the charge pump register.

I'm sorry but I just can't follow what you're talking about at all.  In
one mail above you were talking about an external clock but here you're
talking about the charge pump.

--hEi834+foqWOL7fK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFps4AAoJELSic+t+oim9SYsP/0Y8TYb4E5mivMvMEOM5yLFq
TiVR7Ws7GUFgPehlBeoo+oYxX9Dw6m+MXuyrgPOGcrohpIQrlf0Af6uaT2xbWiYc
vWvHsdY8sJ5pszii8WbG5ZTqBsS/KzjULlqT4zCwTm8uaFs2Feu7AYU3y+RkZ9DU
JbDmYSFvlmtj2AcStbQLqlkD+qaLgxLX3R9HQA5clvLP7X7YFzwXOB1IXX80L5jz
PdRHeGInOIGVCzVXJCV52XB3PAvDbxGHKv42v8Z6N+34wX6vEVuxHr0PvhljzDYF
8z6H3wDQ7/KSd3gWm2F/ihcaMcsiyoOJ6SATpZG0oUrqKYHFSUxc9Bn5d95nc4us
gyQtCFb69IBQHukiKCIi16wj84TEdpfSEpizYmJMhOoiQNtvWsJvbzdd3dBIRt2J
E5t6nmobHqwxn8gydM2EFwKWeQ52hUhtmEu4dn/i5LcLFsh0rPVwVuQT4RdpvKKe
4tIVGBbzuyf+SH17P/Z3hh7a8NFNSZKyF3dwa72efbWMKq2WqFe6wEQ1+KFws7Yb
x4xSI0gHKrH3yeP1rNtPXtFUwQN5d9GhiUSsprE2Mj3BE8eUzvb/oby2vRKhNeXl
ID9+szwjXjRo75EIDJEIPBvcqUjpXuW7CUdo8KbTRad8w7LCHb2dO2IBi/cd7JGc
FF0IcEMr8GC6/jCLiyks
=1+5w
-----END PGP SIGNATURE-----

--hEi834+foqWOL7fK--

--===============2926960863169973983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2926960863169973983==--
