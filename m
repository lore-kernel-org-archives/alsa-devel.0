From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.33
Date: Tue, 22 Dec 2009 13:33:46 +0000
Message-ID: <20091222133345.GA19947@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 099C110382D
	for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2009 14:33:47 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 48c03ce72f2665f79a3fe54fc6d71b8cc3d30803:
  Guennadi Liakhovetski (1):
        ASoC: wm8974: fix a wrong bit definition

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2=
.6.33

Guennadi Liakhovetski (1):
      ASoC: add missing parameter to mx27vis_hifi_hw_free()

Uwe Kleine-K=F6nig (1):
      ASoC: sh: FSI:: don't check platform_get_irq's return value against z=
ero

 sound/soc/imx/mx27vis_wm8974.c |    3 ++-
 sound/soc/sh/fsi.c             |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)
