From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC update for v4.2
Date: Wed, 19 Aug 2015 09:29:59 -0700
Message-ID: <20150819162959.GR10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6925930420701358661=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CB726265062
 for <alsa-devel@alsa-project.org>; Wed, 19 Aug 2015 18:31:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6925930420701358661==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GZcHWaa9CKmuhJmS"
Content-Disposition: inline


--GZcHWaa9CKmuhJmS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590:

  Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v4.2-disable-topology

for you to fetch changes up to 8c90503bf246bebb48caa5590d41df755ba08550:

  ASoC: topology: Disable use from userspace (2015-08-18 09:33:21 -0700)

----------------------------------------------------------------
ASoC: Disable topology support for v4.2

The topology code merged in the v4.2 merge window introduced a new ABI
which was believed to be suitable for use but subsequently additional
work by the developers of this feature have revealed some problems that
need to be addressed.  In order to allow this to be done without having
to support the initial ABI add Kconfig to disable the build and also add
some #error statements to the UAPI header so users can't use them.

----------------------------------------------------------------
Mark Brown (2):
      ASoC: topology: Add Kconfig option for topology
      ASoC: topology: Disable use from userspace

 include/sound/soc-topology.h | 12 ++++++++++++
 include/uapi/sound/asoc.h    |  6 ++++++
 sound/soc/Kconfig            |  3 +++
 sound/soc/Makefile           |  3 +++
 4 files changed, 24 insertions(+)

--GZcHWaa9CKmuhJmS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV1K8HAAoJECTWi3JdVIfQ8I0H/AzdvMYz0T+IJx/Z1JPJGWc6
9pT32/KdxjdyAMQzlpymBvSKx1c7HWhnzu3jsqXZPop3/9Tq6yVYqtKALiUeos54
s5P4Us/Ys5KRuQcZwbGHc1pVhOifi6ijt9gMT4wTMBxqc2VZFtF+w2PvZsZyqEne
3CWVMGdcrx5pACZLhFsCYqq73p9fZ/C5Pnh4A1ZCorFN4sNU7KIv41j6odob5Mem
Fueg2ZwzT0EPFcg/pI5sNDP1kFC1oPGf4i/CEUZxKAizi7550oa8jevPSFxvI7Km
7KxdvinMwckY8k84vosLZBAaESFSxviervFl2jxWEVjvyllkvdbj/FEJAhociQY=
=iYfo
-----END PGP SIGNATURE-----

--GZcHWaa9CKmuhJmS--

--===============6925930420701358661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6925930420701358661==--
