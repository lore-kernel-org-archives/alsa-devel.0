From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 0/7] constify pci snd_pcm_ops structures
Date: Thu, 10 Aug 2017 17:17:31 +0530
Message-ID: <1502365658-24723-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

snd_pcm_ops are not supposed to change at runtime. All functions
working with snd_pcm_ops provided by <sound/pcm.h> work with
const snd_pcm_ops. So mark the non-const structs as const.

Arvind Yadav (7):
  [PATCH 1/7] ALSA: ali5451: constify snd_pcm_ops structures
  [PATCH 2/7] ALSA: au88x0: constify snd_pcm_ops structures
  [PATCH 3/7] ALSA: echoaudio: constify snd_pcm_ops structures
  [PATCH 4/7] ALSA: intel8x0: constify snd_pcm_ops structures
  [PATCH 5/7] ALSA: intel8x0m: constify snd_pcm_ops structures
  [PATCH 6/7] ALSA: sis7019: constify snd_pcm_ops structures
  [PATCH 7/7] ALSA: trident: constify snd_pcm_ops structures

 sound/pci/ali5451/ali5451.c      | 12 ++++++------
 sound/pci/au88x0/au88x0_pcm.c    |  2 +-
 sound/pci/echoaudio/echoaudio.c  |  8 ++++----
 sound/pci/intel8x0.c             | 24 ++++++++++++------------
 sound/pci/intel8x0m.c            |  8 ++++----
 sound/pci/sis7019.c              |  4 ++--
 sound/pci/trident/trident_main.c |  4 ++--
 7 files changed, 31 insertions(+), 31 deletions(-)

-- 
1.9.1
