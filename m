From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/3]: ALSA: compress: sampling rate updates
Date: Sat,  4 Jan 2014 16:59:10 +0530
Message-ID: <1388834953-3200-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 21C47261A84
 for <alsa-devel@alsa-project.org>; Sat,  4 Jan 2014 13:29:37 +0100 (CET)
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Here are three patches which add more comments for sampling rate usage, fix the
descriptor usage and lastly remove a check for SNDRV_PCM_RATE_xxx check

Thanks

Vinod Koul (3):
  ALSA: compress: remove the sample rate check
  ALSA: compress: update comment for sample rate in snd_codec
  ALSA: compress: update struct snd_codec_desc for sample rate

 include/uapi/sound/compress_params.h |    6 ++++--
 sound/core/compress_offload.c        |    3 ---
 2 files changed, 4 insertions(+), 5 deletions(-
