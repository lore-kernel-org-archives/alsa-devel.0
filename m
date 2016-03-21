From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add max98371 codec driver
Date: Mon, 21 Mar 2016 17:05:36 +0000
Message-ID: <20160321170536.GX2566@sirena.org.uk>
References: <1458525542-2168-1-git-send-email-yesanishhere@gmail.com>
 <20160321145642.GV2566@sirena.org.uk>
 <CAF+MRtkm+OHQHwW4cTihSV5MOnJWiq4XfjoxghYN7eq05e0pWw@mail.gmail.com>
 <20160321155659.GW2566@sirena.org.uk>
 <CAF+MRtm16ThnHwPvmR6oDeZcavvwVvMmvmgq6en-_e6U81hFeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0211422351245561148=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9556626507F
 for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2016 18:05:43 +0100 (CET)
In-Reply-To: <CAF+MRtm16ThnHwPvmR6oDeZcavvwVvMmvmgq6en-_e6U81hFeg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Micka <mickamusset@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0211422351245561148==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S6lVrJQMb5zD9/0X"
Content-Disposition: inline


--S6lVrJQMb5zD9/0X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 21, 2016 at 04:41:43PM +0000, Micka wrote:

> *> Could you tell me how do you control this device/codec with Linux ? What
> is> the command ?*
> *Using any ALSA userspace applications.*

> But How do you find the device in the amixer application ? That the part
> don't I don't get it !

The machine driver that uses the CODEC will create a card.  Probably
it's going to be the only card in the system, if not you might need to
flip between cards using whatever UI you have.  With amixer that's the
-c option.

--S6lVrJQMb5zD9/0X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW8CndAAoJECTWi3JdVIfQEGsH/2DAItfD+LPLgRhMsDjDhaeH
05RUGkcELOdgzEjutSx7ZLklJ35gcK8/5hL6SC7x24txehVuouIxMDPWqLVkekz+
9UNYpyQNMJKJo5OD3NjfkgUPjsE9SJ+23BadU8Q94nWaYlWArrnp+BInqapD4rf2
wuiqWY4A7kEUjvHENJFS8NDF3DjzF2Ww+sH3sf0xdobTOxUfFedhGlsya17W1EnQ
qCT0PC7YZEb1upz86UUmcltwfg/DSlxJT+Tc9biSmLXYPUXh840cmjJVR2+81BR1
5/0yz/W2BGcRf/Gnhz8dqZ8BwqdDsyaxTRd3Dd0pjSpfqyWEAFJQ89GGKWU6f5o=
=qAF6
-----END PGP SIGNATURE-----

--S6lVrJQMb5zD9/0X--

--===============0211422351245561148==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0211422351245561148==--
