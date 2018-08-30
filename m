From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "ALSA: hda: move hda_codec.h to
 include/sound" to the asoc tree
Date: Thu, 30 Aug 2018 15:46:54 +0100
Message-ID: <20180830144654.GF7301@sirena.org.uk>
References: <20180828204136.3C86F44007A@finisterre.ee.mobilebroadband>
 <s5hmut65i5c.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2014182685505433428=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 26B24267668
 for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2018 16:46:55 +0200 (CEST)
In-Reply-To: <s5hmut65i5c.wl-tiwai@suse.de>
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
Cc: liam.r.girdwood@linux.intel.com, vkoul@kernel.org, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2014182685505433428==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lIrNkN/7tmsD/ALM"
Content-Disposition: inline


--lIrNkN/7tmsD/ALM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 28, 2018 at 10:51:43PM +0200, Takashi Iwai wrote:

> Mark, can I get this in an immutable branch?  Not needed to be clear
> from other changes, but I'd need to pull it to my tree for the further
> development of HD-audio stuff sooner or later.

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/hda-codec-h-move

for you to fetch changes up to be57bfffb7b5ba72e1293643053f8861fcaa5163:

  ALSA: hda: move hda_codec.h to include/sound (2018-08-30 15:45:10 +0100)

----------------------------------------------------------------
ALSA: Move hda_codec.h to include/sound

For easier sharing with ASoC.

----------------------------------------------------------------
Pierre-Louis Bossart (1):
      ALSA: hda: move hda_codec.h to include/sound

 {sound/pci/hda => include/sound}/hda_codec.h | 0
 sound/pci/hda/hda_auto_parser.c              | 2 +-
 sound/pci/hda/hda_beep.h                     | 2 +-
 sound/pci/hda/hda_bind.c                     | 2 +-
 sound/pci/hda/hda_codec.c                    | 2 +-
 sound/pci/hda/hda_controller.h               | 2 +-
 sound/pci/hda/hda_eld.c                      | 2 +-
 sound/pci/hda/hda_generic.c                  | 2 +-
 sound/pci/hda/hda_hwdep.c                    | 2 +-
 sound/pci/hda/hda_intel.c                    | 2 +-
 sound/pci/hda/hda_jack.c                     | 2 +-
 sound/pci/hda/hda_proc.c                     | 2 +-
 sound/pci/hda/hda_sysfs.c                    | 2 +-
 sound/pci/hda/hda_tegra.c                    | 2 +-
 sound/pci/hda/patch_analog.c                 | 2 +-
 sound/pci/hda/patch_ca0110.c                 | 2 +-
 sound/pci/hda/patch_ca0132.c                 | 2 +-
 sound/pci/hda/patch_cirrus.c                 | 2 +-
 sound/pci/hda/patch_cmedia.c                 | 2 +-
 sound/pci/hda/patch_conexant.c               | 2 +-
 sound/pci/hda/patch_hdmi.c                   | 2 +-
 sound/pci/hda/patch_realtek.c                | 2 +-
 sound/pci/hda/patch_si3054.c                 | 2 +-
 sound/pci/hda/patch_sigmatel.c               | 2 +-
 sound/pci/hda/patch_via.c                    | 2 +-
 25 files changed, 24 insertions(+), 24 deletions(-)
 rename {sound/pci/hda => include/sound}/hda_codec.h (100%)

--lIrNkN/7tmsD/ALM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluIA10ACgkQJNaLcl1U
h9D84Af/QkHmNghlxxguS95YO9qEJAiWr+DAi/A7wtd9BYLBVmO3MgpIMeRe/tVh
ShHPtZb+FS2ErGwbAei7gu66UnRkKkuXXduqzbwfdO8K5yPsZ4TO1u9fg5477RWN
8b4A5yZbhoU42BMe1NDIND8+WdP57cGbVVBzMpFaRK4qBflPzSy2m+TGE42ii3q5
avqIInkM7c5JVZ6/EmpZgHFWgd4mNZDuvkFoFLQ+iWcfEIHeEtPR1jvjAl8d1OLP
aKaNHt/PHjNjUMenBibQ8TeXoRJVKpZfeKZMolkQyq7EEJr/ur0csWmDl06FF5wE
17IbijSQCVIPnR3sR8DH3ZrgavnaYQ==
=gMZg
-----END PGP SIGNATURE-----

--lIrNkN/7tmsD/ALM--

--===============2014182685505433428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2014182685505433428==--
