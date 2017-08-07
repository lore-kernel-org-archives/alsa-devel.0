From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: [PATCH RESEND1 00/12] ALSA: vsnd: Add Xen para-virtualized frontend driver
Date: Mon,  7 Aug 2017 15:22:45 +0300
Message-ID: <1502108577-8099-1-git-send-email-andr2000@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, xen-devel@lists.xen.org, linux-kernel@vger.kernel.org
Cc: perex@perex.cz, tiwai@suse.com, andr2000@gmail.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

This patch series adds support for Xen [1] para-virtualized
sound frontend driver. It implements the protocol from
include/xen/interface/io/sndif.h with the following limitations:
- mute/unmute is not supported
- get/set volume is not supported
Volume control is not supported for the reason that most of the
use-cases (at the moment) are based on scenarious where
unprivileged OS (e.g. Android, AGL etc) use software mixers.

Both capture and playback are supported.

Thank you,
Oleksandr

Resending because of rebase onto [2] + added missing patch

[1] https://xenproject.org/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/log/?h=for-next

Oleksandr Andrushchenko (12):
  ALSA: vsnd: Introduce Xen para-virtualized sound frontend driver
  ALSA: vsnd: Implement driver's probe/remove
  ALSA: vsnd: Implement Xen bus state handling
  ALSA: vsnd: Read sound driver configuration from Xen store
  ALSA: vsnd: Implement Xen event channel handling
  ALSA: vsnd: Implement handling of shared buffers
  ALSA: vsnd: Introduce ALSA virtual sound driver
  ALSA: vsnd: Initialize virtul sound card
  ALSA: vsnd: Add timer for period interrupt emulation
  ALSA: vsnd: Implement ALSA PCM operations
  ALSA: vsnd: Implement communication with backend
  ALSA: vsnd: Introduce Kconfig option to enable Xen PV sound

 sound/drivers/Kconfig     |   12 +
 sound/drivers/Makefile    |    2 +
 sound/drivers/xen-front.c | 2107 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 2121 insertions(+)
 create mode 100644 sound/drivers/xen-front.c

-- 
2.7.4
