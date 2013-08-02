From: "Felipe F. Tonello" <eu@felipetonello.com>
Subject: [PATCH v2 0/2] ALSA: Implement core jack support for
	kcontrol
Date: Fri,  2 Aug 2013 00:59:23 -0700
Message-ID: <1375430365-13232-1-git-send-email-eu@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f170.google.com (mail-pd0-f170.google.com
 [209.85.192.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E0A526563F
 for <alsa-devel@alsa-project.org>; Fri,  2 Aug 2013 09:59:39 +0200 (CEST)
Received: by mail-pd0-f170.google.com with SMTP id x10so386968pdj.29
 for <alsa-devel@alsa-project.org>; Fri, 02 Aug 2013 00:59:38 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, "Felipe F. Tonello" <eu@felipetonello.com>
List-Id: alsa-devel@alsa-project.org

From: "Felipe F. Tonello" <eu@felipetonello.com>

On this second version I made sure that the patch series can be bisected.
Also, since HDA codec has it's own jack infrastructure, I just disabled the
support of the core ALSA jack in it. Why? Because it's causing duplication of
controls, although the input events works fine. A HDA codec developer might
give us more information about it.

Patch 1) Is the actual implementation and fixes for users that uses the API.
Patch 2) Name fixes. Just to make sure no jack has " Jack" duplicated at the
end of its name.

Felipe F. Tonello (2):
  ALSA: Added jack detection KControl support
  ALSA: SoC: Fix jack names according new API

 include/sound/control.h            |  2 +-
 include/sound/jack.h               |  8 ++--
 include/sound/soc.h                |  2 +-
 sound/core/Kconfig                 |  1 +
 sound/core/ctljack.c               | 15 ++++++-
 sound/core/jack.c                  | 88 +++++++++++++++++++++++++++++++++++---
 sound/pci/hda/Kconfig              |  8 ----
 sound/pci/oxygen/xonar_wm87x6.c    |  2 +-
 sound/soc/fsl/wm1133-ev1.c         |  4 +-
 sound/soc/mid-x86/mfld_machine.c   |  6 +--
 sound/soc/omap/ams-delta.c         |  2 +-
 sound/soc/omap/omap-abe-twl6040.c  |  4 +-
 sound/soc/omap/omap-twl4030.c      |  4 +-
 sound/soc/omap/rx51.c              |  6 +--
 sound/soc/pxa/hx4700.c             |  4 +-
 sound/soc/pxa/palm27x.c            |  4 +-
 sound/soc/pxa/ttc-dkb.c            | 10 ++---
 sound/soc/pxa/z2.c                 |  4 +-
 sound/soc/samsung/goni_wm8994.c    |  7 +--
 sound/soc/samsung/h1940_uda1380.c  |  4 +-
 sound/soc/samsung/littlemill.c     | 10 ++---
 sound/soc/samsung/lowland.c        |  6 +--
 sound/soc/samsung/rx1950_uda1380.c |  4 +-
 sound/soc/samsung/smartq_wm8987.c  |  4 +-
 sound/soc/samsung/speyside.c       |  6 +--
 sound/soc/samsung/tobermory.c      |  4 +-
 sound/soc/soc-jack.c               |  5 ++-
 sound/soc/tegra/tegra_alc5632.c    |  4 +-
 sound/soc/tegra/tegra_rt5640.c     |  4 +-
 sound/soc/tegra/tegra_wm8903.c     |  8 ++--
 30 files changed, 163 insertions(+), 77 deletions(-)

-- 
1.8.3.1
