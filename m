From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/7] ALSA: Fix/improve PCM ack callback
Date: Sun, 21 May 2017 21:02:51 +0200
Message-ID: <20170521190258.1178-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: alsa-devel@alsa-project.org
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Lee Jones <lee@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>, Eric Anholt <eric@anholt.net>, linux-rpi-kernel@lists.infradead.org, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi,

this is a series of patches to fix the potential bugs in PCM ack
callback using the pcm-indirect helper functions, and also to enhance
the ack callback to be called properly in all appl_ptr updates, as
similarly done by Pierre and Subhransu's patches.

The changes in the pcm-indirect helper code and its users are fairly
trivial, just passing the error code back.

ARM/R-Pi people are Cc'ed because of bcm2835-audio driver.


Takashi

===

Takashi Iwai (7):
  ALSA: pcm: Fix negative appl_ptr handling in pcm-indirect helpers
  ALSA: mips: Deliver indirect-PCM transfer error
  ALSA: cs46xx: Deliver indirect-PCM transfer error
  ALSA: emu10k1: Deliver indirect-PCM transfer error
  ALSA: rme32: Deliver indirect-PCM transfer error
  staging: bcm2835-audio: Deliver indirect-PCM transfer error
  ALSA: pcm: Call ack() whenever appl_ptr is updated

 .../vc04_services/bcm2835-audio/bcm2835-pcm.c      |  5 +--
 include/sound/pcm-indirect.h                       | 10 ++++-
 sound/core/pcm_native.c                            | 46 +++++++++++++++++-----
 sound/mips/hal2.c                                  | 14 +++----
 sound/pci/cs46xx/cs46xx_lib.c                      |  8 ++--
 sound/pci/emu10k1/emupcm.c                         |  4 +-
 sound/pci/rme32.c                                  | 10 ++---
 7 files changed, 63 insertions(+), 34 deletions(-)

-- 
2.13.0
