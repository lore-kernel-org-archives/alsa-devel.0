From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/2] ALSA: pcm: remove unused local commands
Date: Wed, 14 Jun 2017 19:30:02 +0900
Message-ID: <20170614103004.6205-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 36752266F1C
 for <alsa-devel@alsa-project.org>; Wed, 14 Jun 2017 12:30:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

A callback of 'struct snd_pcm_ops.ioctl' is internally used for ALSA
pcm core to communicate to each drivers for some purposes; e.g. ask the
size of FIFO in handled devices. However, in 'include/sound/pcm.h',
there're some commands for the callback, which has never been used.

This commit removes the unused commands to prevent developers from
undocumented and unreferenced features.

Takashi Sakamoto (2):
  ALSA: pcm: remove SNDRV_PCM_IOCTL1_INFO internal command
  ALSA: pcm: remove SNDRV_PCM_IOCTL1_GSTATE internal command

 include/sound/pcm.h     | 4 ++--
 sound/core/pcm_lib.c    | 2 --
 sound/core/pcm_native.c | 6 +-----
 3 files changed, 3 insertions(+), 9 deletions(-)

-- 
2.11.0
