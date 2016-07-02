From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] drm: mediatek: fix prototypes after API change
Date: Sat, 2 Jul 2016 10:25:03 +0200
Message-ID: <20160702082503.GE6247@sirena.org.uk>
References: <20160629145129.315931-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0235943499=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20160629145129.315931-1-arnd@arndb.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, Junzhi Zhao <junzhi.zhao@mediatek.com>, Jie Qiu <jie.qiu@mediatek.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Matthias Brugger <matthias.bgg@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0235943499==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NWFdL9cNbHaIJHRV"
Content-Disposition: inline


--NWFdL9cNbHaIJHRV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 29, 2016 at 04:51:29PM +0200, Arnd Bergmann wrote:

> b) efc9194bcff8 gets merged into drm-next along with my change
>    in the merge commit. It is currently a standalone patch
>    in its own branch in the ASoC tree.

This would be the ideal thing obviously:

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-hdmi-codec-pdata

for you to fetch changes up to efc9194bcff84666832c6493bafa92029ac6634c:

  ASoC: hdmi-codec: callback function will be called with private data (2016-06-27 18:53:15 +0100)

----------------------------------------------------------------
ASoC: Add private data for HDMI CODEC callbacks

Allow the HDMI CODECs to get private data passed in in callbacks.

----------------------------------------------------------------
Kuninori Morimoto (1):
      ASoC: hdmi-codec: callback function will be called with private data

 include/sound/hdmi-codec.h    | 13 ++++++++-----
 sound/soc/codecs/hdmi-codec.c | 15 ++++++++-------
 2 files changed, 16 insertions(+), 12 deletions(-)

--NWFdL9cNbHaIJHRV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXd3pdAAoJECTWi3JdVIfQgbEH/0ZKLyBJqcvvrURVppUvpgr8
pQ0qEtXNHLzOfY3TqfbkbbuWrGGVcA6awazID7EYDBL/iQpo9xw5ZSanGl4pumyj
gRi+9GMKy6Zy/VA+WzN+8BxJ9sgTLsoV5nspcx4lA7mE8nLEhENwT8CnCaO2Rbi1
ESQn43ASukue/fLhFzijuBG9CRCbFLwerhyv2kKxK/w+trDDm5se6+tizA6M1aX/
ZaAw80eWlVdHHE7y8xbL7wSu85pgWYK0Hjgd0oyde0pQ1Bp/g2jgauykIqJTimY/
VM6PIuCKoGZPYZI5TzdZ/bRyTToZvHy4cvB1Dy0OCZPrazxJwn64AGvqrE5fybo=
=+b8A
-----END PGP SIGNATURE-----

--NWFdL9cNbHaIJHRV--

--===============0235943499==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0235943499==--
