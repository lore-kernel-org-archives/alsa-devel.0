From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.6
Date: Mon, 23 Jul 2012 13:32:00 +0100
Message-ID: <20120723123200.GQ4435@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2322386570629083022=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AC23D265CC2
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 14:31:59 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2322386570629083022==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fu8LepSeDvpxVgv6"
Content-Disposition: inline


--fu8LepSeDvpxVgv6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 409b78cc17a4a3d07a541037575da648ced99437:

  ASoC imx-audmux: add MX31_AUDMUX_PORT7_SSI_PINS_7 define (2012-07-18 22:0=
9:40 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-3.6

for you to fetch changes up to 15d47763b354256053c390a9b7bc9f2b4f197711:

  Merge branch 'for-3.5' into for-3.6 (2012-07-23 10:45:07 +0100)

Diffstat looks a bit odd with the HDA stuff but as far as I can tell
this is due to it showing up some diffs due to commits you've added.

----------------------------------------------------------------

ASoC: Additional updates for 3.6

A few more fixes for 3.6, some of which are relatively important -
they've all been in -next for at least some time.

- DAPM fixes for the recent locking changes.
- Fix for _PRE and _POST widgets (which have been broken for a few
  releases now).
- A couple of minor driver updates.

----------------------------------------------------------------
Beno=EEt Th=E9baudeau (1):
      ASoC: dapm: Fix dapm_set_path_status() connect

Liam Girdwood (2):
      ASoC: dapm: Fix locking during codec shutdown
      ASoC: dapm: Make sure all dapm contexts are updated

Mark Brown (2):
      ASoC: dapm: Fix _PRE and _POST events for DAPM performance improvemen=
ts
      Merge branch 'for-3.5' into for-3.6

Peter Ujfalusi (1):
      ASoC: omap-mcpdm: Add missing MODULE_ALIAS

Robert Jarzmik (1):
      ASoC: mioa701: convert to snd_soc_register_card API

 sound/pci/hda/Kconfig           |   13 -------------
 sound/pci/hda/hda_auto_parser.c |    1 -
 sound/pci/hda/hda_auto_parser.h |   10 ++++++++++
 sound/pci/hda/hda_codec.c       |    4 ++++
 sound/pci/hda/patch_conexant.c  |    6 +++++-
 sound/pci/hda/patch_realtek.c   |   15 +++++++++------
 sound/pci/hda/patch_sigmatel.c  |    7 ++++++-
 sound/soc/codecs/tlv320aic3x.c  |    4 +---
 sound/soc/codecs/tlv320aic3x.h  |    1 +
 sound/soc/codecs/wm2200.c       |    1 +
 sound/soc/codecs/wm8994.c       |    3 ---
 sound/soc/omap/omap-mcpdm.c     |    1 +
 sound/soc/pxa/mioa701_wm9713.c  |   33 ++++++++++++---------------------
 sound/soc/soc-dapm.c            |   28 ++++++++++++++++++++--------
 sound/usb/mixer_maps.c          |    8 ++++++++
 sound/usb/quirks-table.h        |   30 ++++++++++++++++++++++++++++++
 16 files changed, 108 insertions(+), 57 deletions(-)

--fu8LepSeDvpxVgv6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQDUPJAAoJEBus8iNuMP3dXewP/0QcDkJXOaOhDHvxSHnOBehp
ZijPhy/se/7W0lzYdCXaggOFHH3LWMBRJz3N/LryN/XXbUmQM/CSjh6JkWRjCLPO
g+nwdZpIweLOcFh4tUcMBvRq/TDYtKULs4yK/q2oUowqbSHKx77h0xfSIgkU5Cfj
RRme/Z5AUL16GKxdSnMxIxoux37kNowmcWiMpPxqUrqQwKIroS3d3UISVoBe+lcg
xmv8jC5nu59sKpUhU1g62GEbiDIyCpg3CjoF5LVsCOIkjuFQT/MP7YcdBbPjNaHY
3T56VZ9mFRnjN/8bv6nseJdGW3oR3FUJuN1Zlyo7A1Yya9RV4nyTKGVOmNL6TkFE
M6xiUdPjgiaX30EllK8hrchE1c1RoYMAPhaSRRZuJIGpabCcu06eXIQw3/RfGC0y
PzESHZYIDz+c76LbluFbJZM4dtIZaEtULDyiY83uKRXxa3bGkRRoOKlZLj6OrO0T
ew2tstXiEJkn9P2hZK1QipFmJtIQPlZCiwluQkXy9MCCmh+u8961PO7HIVy9xo3/
WdcFWHe1mnBFUCgT0q4T1JW/vvJk+STOaO39O25Gg9fu+zBCAsNtG4nMF9ddjMbB
nWS7O4VN3275WGJJLxL+nppdJpmw/SV5V9fIWCBChiOGTZ1drG6Q7B5c111IAamC
lbReC4jPTmUNydTD2ftX
=KSOT
-----END PGP SIGNATURE-----

--fu8LepSeDvpxVgv6--

--===============2322386570629083022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2322386570629083022==--
