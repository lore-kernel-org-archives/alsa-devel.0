From: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 0/2] ALSA: pcm: implement the anonymous dup v2
Date: Wed, 30 Jan 2019 09:47:31 +0100
Message-ID: <20190130084733.979-1-perex@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 2401B26749A
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2019 09:48:05 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, Takashi Iwai <tiwai@suse.de>, Phil Burk <philburk@google.com>, Mark Brown <broonie@kernel.org>, Leo Yan <leo.yan@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patchset contains the anonymous dup implementation with permissions
checking for the ALSA's PCM interface in kernel to enable the restricted
DMA sound buffer sharing for the restricted tasks.

The code was tested through qemu and it seems to be pretty stable.

The initial tinyalsa implementation can be found here:

  https://github.com/perexg/tinyalsa/commits/anondup

The filtering might be refined. It depends on the real requirements.
Perhaps, we may create more ioctl groups. Any comments are more than
welcome.

v2 of the patches:

- change clone parameter to subdevice number for the pcm attach
- change SNDRV_PCM_PERM_MAX to SNDRV_PCM_PERM_MASK
- the tinyalsa implementation was a little updated (restructured)

Cc: Phil Burk <philburk@google.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Baolin Wang <baolin.wang@linaro.org>

Jaroslav Kysela (2):
  ALSA: pcm: implement the anonymous dup (inode file descriptor)
  ALSA: pcm: implement the ioctl/mmap filter for the anonymous dup

 include/sound/pcm.h         |   9 +--
 include/uapi/sound/asound.h |  12 +++-
 sound/core/oss/pcm_oss.c    |   2 +-
 sound/core/pcm.c            |  13 ++--
 sound/core/pcm_compat.c     |   1 +
 sound/core/pcm_native.c     | 153 ++++++++++++++++++++++++++++++++++++++++++--
 6 files changed, 171 insertions(+), 19 deletions(-)

-- 
2.13.6
