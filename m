From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: [GIT PULL] unify two pxa sound drivers
Date: Mon, 8 Sep 2008 12:53:39 +0400
Message-ID: <20080908085339.GA31573@doriath.ww600.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.183])
	by alsa0.perex.cz (Postfix) with ESMTP id BBF96244FC
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 10:56:44 +0200 (CEST)
Received: by ik-out-1112.google.com with SMTP id c30so909643ika.0
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 01:56:43 -0700 (PDT)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Please consider this changeset. It was partially tested, but additional
testing will be appreciated. pxa3xx was only compile tested.

The following changes since commit 6a55617ed5d1aa62b850de2cf66f5ede2eef4825:
  Linus Torvalds (1):
        Linux v2.6.27-rc4

are available in the git repository at:

  git://git.infradead.org/users/dbaryshkov/zaurus-2.6.git pxa2xx-asoc-cleanup

Dmitry Baryshkov (4):
      Permit simultaneous compilation of both PXA AC97 drivers
      Separate common pxa2xx-ac97 code
      Make pxa-ac97-lib separate module
      Separate common pxa2xx-pcm code

Russ Dill (1):
      pxa2xx-lib: support building for several pxa's

 arch/arm/mach-pxa/include/mach/pxa-regs.h |    4 +-
 include/sound/pxa2xx-lib.h                |   45 +++++
 sound/arm/Kconfig                         |    9 +-
 sound/arm/Makefile                        |    4 +
 sound/arm/pxa2xx-ac97-lib.c               |  297 +++++++++++++++++++++++++++++
 sound/arm/pxa2xx-ac97.c                   |  247 ++----------------------
 sound/arm/pxa2xx-pcm-lib.c                |  277 +++++++++++++++++++++++++++
 sound/arm/pxa2xx-pcm.c                    |  252 +-----------------------
 sound/arm/pxa2xx-pcm.h                    |   13 +-
 sound/soc/pxa/Kconfig                     |    3 +
 sound/soc/pxa/pxa2xx-ac97.c               |  272 +-------------------------
 sound/soc/pxa/pxa2xx-i2s.c                |   26 ++-
 sound/soc/pxa/pxa2xx-pcm.c                |  265 +-------------------------
 sound/soc/pxa/pxa2xx-pcm.h                |   15 --
 14 files changed, 707 insertions(+), 1022 deletions(-)
 create mode 100644 include/sound/pxa2xx-lib.h
 create mode 100644 sound/arm/pxa2xx-ac97-lib.c
 create mode 100644 sound/arm/pxa2xx-pcm-lib.c

-- 
With best wishes
Dmitry
