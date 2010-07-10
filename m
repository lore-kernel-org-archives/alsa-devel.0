From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/3] further BKL removal
Date: Sat, 10 Jul 2010 23:51:38 +0200
Message-ID: <1278798701-11171-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Ingo Molnar <mingo@redhat.com>, Jaroslav Kysela <perex@perex.cz>, "J. Bruce Fields" <bfields@fieldses.org>, Matthew Wilcox <willy@linux.intel.com>, Miklos Szeredi <mszeredi@suse.cz>, Takashi Iwai <tiwai@suse.de>, Trond Myklebust <trond.myklebust@fys.uio.no>, alsa-devel@alsa-project.org, linux-fsdevel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

With the ioctl, block, tty, vfs and llseek series
on their way into linux-next, these three patches
are attacking the hardest remaining issues.

If we get these ready for 2.6.36, the kernel should
be almost usable with the BKL disabled. In all three
cases, I'm cheating a bit, because the BKL still
remains lurking in the dark corners of the three
subsystems (i810/i830 for drm, OSS for sound and
lockd for fs/locks.c).

	Arnd

Cc: Christoph Hellwig <hch@lst.de>
Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: "J. Bruce Fields" <bfields@fieldses.org>
Cc: John Kacur <jkacur@redhat.com>
Cc: Matthew Wilcox <willy@linux.intel.com>
Cc: Miklos Szeredi <mszeredi@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: alsa-devel@alsa-project.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Arnd Bergmann (2):
  drm: kill BKL from common code
  sound: push BKL into open functions

Matthew Wilcox (1):
  Remove BKL from fs/locks.c

 arch/um/drivers/hostaudio_kern.c   |    6 ++
 drivers/gpu/drm/drm_drv.c          |    4 +-
 drivers/gpu/drm/drm_fops.c         |   23 ++++----
 drivers/gpu/drm/i810/i810_dma.c    |   44 +++++++++-----
 drivers/gpu/drm/i810/i810_drv.c    |    2 +-
 drivers/gpu/drm/i810/i810_drv.h    |    1 +
 drivers/gpu/drm/i830/i830_dma.c    |   42 +++++++++----
 drivers/gpu/drm/i830/i830_drv.c    |    2 +-
 drivers/gpu/drm/i830/i830_drv.h    |    1 +
 fs/Kconfig                         |    4 +
 fs/locks.c                         |  116 ++++++++++++++++++++++--------------
 include/drm/drmP.h                 |    2 +-
 sound/core/hwdep.c                 |   14 +++-
 sound/core/oss/mixer_oss.c         |   19 ++++---
 sound/oss/au1550_ac97.c            |   26 +++++---
 sound/oss/dmasound/dmasound_core.c |   28 +++++++--
 sound/oss/msnd_pinnacle.c          |   10 ++-
 sound/oss/sh_dac_audio.c           |    9 ++-
 sound/oss/soundcard.c              |   20 ++++---
 sound/oss/swarm_cs4297a.c          |   17 +++++-
 sound/oss/vwsnd.c                  |    8 +++
 sound/sound_core.c                 |    6 +--
 22 files changed, 267 insertions(+), 137 deletions(-)
