From: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 0/3] ALSA: pcm: implement the anonymous dup
Date: Tue, 29 Jan 2019 18:59:06 +0100
Message-ID: <20190129175909.17423-1-perex@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 36FB72674A3
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2019 18:59:36 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Baolin Wang <baolin.wang@linaro.org>, Leo Yan <leo.yan@linaro.org>
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

Cc: Mark Brown <broonie@kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Baolin Wang <baolin.wang@linaro.org>

Jaroslav Kysela (3):
  ALSA: pcm: implement the anonymous dup (inode file descriptor)
  ALSA: pcm: remove the file member from struct pcm
  ALSA: pcm: implement the ioctl/mmap filter for the anonymous dup

 include/sound/pcm.h         |  10 +--
 include/uapi/sound/asound.h |  12 +++-
 sound/core/oss/pcm_oss.c    |   3 +-
 sound/core/pcm.c            |  48 +++++++++-----
 sound/core/pcm_compat.c     |   1 +
 sound/core/pcm_native.c     | 154 +++++++++++++++++++++++++++++++++++++++++---
 6 files changed, 195 insertions(+), 33 deletions(-)

-- 
2.13.6
