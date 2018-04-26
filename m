From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/4] ALSA: Fix year 2038 issue for sound
	subsystem, alternative
Date: Thu, 26 Apr 2018 14:44:18 +0200
Message-ID: <20180426124422.2921744-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by alsa0.perex.cz (Postfix) with ESMTP id 31BEC2677F6
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 14:45:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Baolin Wang <baolin.wang@linaro.org>, tiwai@suse.com, lgirdwood@gmail.com, o-takashi@sakamocchi.jp, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

I've tried the suggestion from Jaroslaw, doing a minimal change to the
UAPI headers to keep the existing binary interface. As he predicted,
this is a much simpler set of kernel changes, but we will pay for that
with added complexity in alsa-lib.

The first two patches in this series are taken from Baolin's patch
set, with a small bugfix folded in to avoid a compile-time regression.

The other two patches are to redefine the UAPI and to deprecate
the support for CLOCK_REALTIME time stamps, which we can no longer
allow with user space that we expect to survive beyond 2038.

Overall, I'd still be happier with Baolin's approach since it allows
us to keep compatiblity with CLOCK_REALTIME users and requires
fewer changes in user space, but this would work as well.

	Arnd

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: tiwai@suse.com
Cc: lgirdwood@gmail.com
Cc: broonie@kernel.org
Cc: o-takashi@sakamocchi.jp
Cc: y2038@lists.linaro.org
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Cc: Baolin Wang <baolin.wang@linaro.org>

Arnd Bergmann (2):
  ALSA: replace timespec types in uapi headers
  ALSA: Deprecate CLOCK_REALTIME timestamps

Baolin Wang (2):
  ALSA: Replace timespec with timespec64
  ALSA: Avoid using timespec for struct snd_ctl_elem_value

 include/sound/asound.h            |  8 +++++
 include/sound/pcm.h               | 22 +++++++-----
 include/sound/timer.h             |  4 +--
 include/uapi/sound/asound.h       | 53 +++++++++++++++++++++--------
 sound/core/Kconfig                | 11 ++++++
 sound/core/compat.h               | 11 ++++++
 sound/core/pcm.c                  |  3 ++
 sound/core/pcm_compat.c           | 70 ++++++++++++++++++++++-----------------
 sound/core/pcm_lib.c              | 36 ++++++++++++--------
 sound/core/pcm_native.c           | 25 ++++++++++----
 sound/core/rawmidi_compat.c       | 12 +++----
 sound/core/timer.c                | 28 ++++++++--------
 sound/core/timer_compat.c         |  4 ++-
 sound/pci/hda/hda_controller.c    | 14 +++++---
 sound/soc/intel/skylake/skl-pcm.c |  4 +--
 15 files changed, 203 insertions(+), 102 deletions(-)
 create mode 100644 sound/core/compat.h

-- 
2.9.0
