From: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 0/2 v4] ALSA: pcm: anonymous dup implementation
Date: Mon,  4 Feb 2019 10:39:08 +0100
Message-ID: <20190204093910.23878-1-perex@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CBD32674D6
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 10:39:42 +0100 (CET)
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
Cc: Baolin Wang <baolin.wang@linaro.org>, Takashi Iwai <tiwai@suse.de>, Phil Burk <philburk@google.com>, Zach Riggle <riggle@google.com>, Mark Brown <broonie@kernel.org>, Leo Yan <leo.yan@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patchset contains the anonymous dup implementation with permissions
checking for the ALSA's PCM interface in kernel to enable the restricted
DMA sound buffer sharing for the restricted tasks.

The code was tested through qemu and it seems to be pretty stable.

The initial tinyalsa implementation can be found here:

  https://github.com/perexg/tinyalsa/commits/anondup

v2 of the patches:

- change clone parameter to subdevice number for the pcm attach
- change SNDRV_PCM_PERM_MAX to SNDRV_PCM_PERM_MASK
- the tinyalsa implementation was a little updated (restructured)

v3 of the patches:

- group integer declarations in snd_pcm_anonymous_dup()
- replaced substream->pcm with pcm in snd_pcm_anonymous_dup()
- added SNDRV_PCM_PERM_RW check for read/write/readv/writev syscalls

v4 of the patches:

- more simple restriction control (only two modes - full/buffer)
- the tinyalsa implementation follows this change

Cc: Phil Burk <philburk@google.com>
Cc: Zach Riggle <riggle@google.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Baolin Wang <baolin.wang@linaro.org>

Jaroslav Kysela (2):
  ALSA: pcm: implement the anonymous dup (inode file descriptor)
  ALSA: pcm: implement the mmap buffer mode for the anonymous dup

 include/sound/pcm.h         | 10 +++--
 include/uapi/sound/asound.h |  6 ++-
 sound/core/oss/pcm_oss.c    |  2 +-
 sound/core/pcm.c            | 13 +++---
 sound/core/pcm_compat.c     |  1 +
 sound/core/pcm_native.c     | 97 ++++++++++++++++++++++++++++++++++++++++++---
 6 files changed, 110 insertions(+), 19 deletions(-)

-- 
2.13.6
