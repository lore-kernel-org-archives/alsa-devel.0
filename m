From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/6 v3] ASoC: rsnd: Add Volume Ramp support
Date: Thu, 6 Nov 2014 16:58:29 +0000
Message-ID: <20141106165829.GQ8509@sirena.org.uk>
References: <87egtp2g05.wl%kuninori.morimoto.gx@gmail.com>
 <87egti46j7.wl%kuninori.morimoto.gx@gmail.com>
 <8761eu46cz.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5624026049729265146=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 729F2265275
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 17:58:53 +0100 (CET)
In-Reply-To: <8761eu46cz.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============5624026049729265146==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BEpf3/qOw8tl8wP0"
Content-Disposition: inline


--BEpf3/qOw8tl8wP0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 04, 2014 at 08:29:53PM -0800, Kuninori Morimoto wrote:

> amixer set "DVC Out" 100%      // = Normal Volume
> amixer set "DVC Out Ramp Up Rate"   "0.125 dB/64 steps"
> amixer set "DVC Out Ramp Down Rate" "0.125 dB/512 steps"
> amixer set "DVC Out Ramp" 0%   // Mute = Normal Volume x 0%
> amixer set "DVC Out Ramp" on   // Volume Ramp ON
> aplay xxx.wav &
> amixer set "DVC Out Ramp" 100% // Mute to Normal Volume x 100%
> amixer set "DVC Out Ramp" 0%   // Normal Volume x 100% to Mute

Correct me if I'm wrong but I think what's confusing me here is that
what I'd expect to happen is that setting the ramp rate would cause any
volume change done by the user to ramp to the target volume (or mute)
but it looks like what's actually happening is that the ramp control is
providing an additional layer of volume control on top of the normal
volume control.

--BEpf3/qOw8tl8wP0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUW6i0AAoJECTWi3JdVIfQBwwH/Rpo5h5k5YDwaqcCh8/rYLyW
aOmO15WnAdhjPy1WmgmFmwO21MMtr84R6FLnNzgOju4Pf+erouZrrTiAn8lT+KnE
oS05LQD+X4T/IVyc5ljfCvDNaCNrVqg8vw7rr63NOxXFBGsPU1q9eRR8tKtDtqNW
eLgMEMHfn9GdvjV77DfGkUXYAnZME3sCAFX0OZPALceYGwujFJHquFnGqIfPvcqD
/RMJa8KINesUOiUoK1n/1/DXuMlv9ZKqCOAQu44RZWVrqPfhxWGZJ+ISIB0lgk00
S0rwZSrQMU1xxuSOf6fbdSdBSp4YYX4B0wfkwShSQHet+tfxu6+NRYtbCJEK4E8=
=Iba2
-----END PGP SIGNATURE-----

--BEpf3/qOw8tl8wP0--

--===============5624026049729265146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5624026049729265146==--
