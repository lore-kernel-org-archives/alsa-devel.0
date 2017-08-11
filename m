From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 0/9] constify isa snd_pcm_ops structures
Date: Fri, 11 Aug 2017 17:27:58 +0530
Message-ID: <1502452687-8202-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

snd_pcm_ops are not supposed to change at runtime. All functions
working with snd_pcm_ops provided by <sound/pcm.h> work with
const snd_pcm_ops. So mark the non-const structs as const.

Arvind Yadav (9):
  [PATCH 1/9] ALSA: ad1816a: constify snd_pcm_ops structures
  [PATCH 2/9] ALSA: es1688: constify snd_pcm_ops structures
  [PATCH 3/9] ALSA: es18xx: constify snd_pcm_ops structures
  [PATCH 4/9] ALSA: gus: constify snd_pcm_ops structures
  [PATCH 5/9] ALSA: msnd: constify snd_pcm_ops structures
  [PATCH 6/9] ALSA: emu8000: constify snd_pcm_ops structures
  [PATCH 7/9] ALSA: sb16: constify snd_pcm_ops structures
  [PATCH 8/9] ALSA: sb8: constify snd_pcm_ops structures
  [PATCH 9/9] ALSA: wss: constify snd_pcm_ops structures

 sound/isa/ad1816a/ad1816a_lib.c | 4 ++--
 sound/isa/es1688/es1688_lib.c   | 4 ++--
 sound/isa/es18xx.c              | 4 ++--
 sound/isa/gus/gus_pcm.c         | 4 ++--
 sound/isa/msnd/msnd.c           | 4 ++--
 sound/isa/sb/emu8000_pcm.c      | 2 +-
 sound/isa/sb/sb16_main.c        | 4 ++--
 sound/isa/sb/sb8_main.c         | 4 ++--
 sound/isa/wss/wss_lib.c         | 4 ++--
 9 files changed, 17 insertions(+), 17 deletions(-)

-- 
1.9.1
