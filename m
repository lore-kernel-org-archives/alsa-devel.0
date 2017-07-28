From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 0/5] ALSA: constify snd_timer_hardware structures
Date: Fri, 28 Jul 2017 18:38:25 +0530
Message-ID: <1501247311-19803-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Declare snd_timer_hardware structures as const.

Bhumika Goyal (5):
  ALSA: sound/core: constify snd_timer_hardware structures
  ALSA: isa: constify snd_timer_hardware structures
  ALSA: pci: constify snd_timer_hardware structures
  ALSA: sparc: constify snd_timer_hardware structure
  ALSA: opl3: constify snd_timer_hardware structures

 sound/core/hrtimer.c            | 2 +-
 sound/core/pcm_timer.c          | 2 +-
 sound/core/timer.c              | 2 +-
 sound/drivers/opl3/opl3_lib.c   | 4 ++--
 sound/isa/ad1816a/ad1816a_lib.c | 2 +-
 sound/isa/gus/gus_timer.c       | 4 ++--
 sound/isa/wss/wss_lib.c         | 2 +-
 sound/pci/emu10k1/timer.c       | 2 +-
 sound/pci/ymfpci/ymfpci_main.c  | 2 +-
 sound/sparc/cs4231.c            | 2 +-
 10 files changed, 12 insertions(+), 12 deletions(-)

-- 
1.9.1
