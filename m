From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH RFC 00/11] ALSA: pcm: introduce copy_frame
	operation and SND_PCM_PROXY_DRIVER_SUPPORT
Date: Wed, 24 May 2017 09:52:44 +0900
Message-ID: <20170524005255.31223-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 63AA72671A8
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 02:53:01 +0200 (CEST)
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

This RFC patchset is my concept work of another solution against a series
of issues in ALSA PCM core, for which Iwai Takashi work in his hasty
proposals[2][3]. Included changes are also available in my personal
repository on github.com[4].

The aim of this work is to declare existent issues and to propose solutions
as moderated as possible. Code refactoring is done to assist it.

Patch 01-05: code refactoring phase, with an alias of function prototype.
Patch 06-09: driver API changing phase. The .copy_frames is introduced.
Patch 10-11: integration phase for proxy drivers, to get new configuration.

I need to do this work with a little time (half a day), thus changes are
as minimal as possible, especially two drivers are just modified even if
drivers in below list should be changed:
* drivers/media/pci/solo6x10/solo6x10-g723.c
* sound/drivers/dummy.c
* sound/isa/gus/gus_pcm.c
* sound/isa/sb/emu8000_pcm.c
* sound/pci/es1938.c
* sound/pci/korg1212/korg1212.c
* sound/pci/nm256/nm256.c
* sound/pci/rme32.c
* sound/pci/rme96.c
* sound/pci/rme9652/hdsp.c
* sound/pci/rme9652/rme9652.c
* sound/sh/sh_dac_audio.c
* sound/soc/blackfin/bf5xx-ac97-pcm.c
* sound/soc/blackfin/bf5xx-i2s-pcm.c

Furthermore, I apologize that this is untested. I wish you to check
the concept.

[1] [alsa-devel] [PATCH RFC 00/26] Kill set_fs() in ALSA codes
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-May/120542
[2] [alsa-devel] [PATCH 00/16] ALSA: Convert to new copy_silence PCM ops
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-May/120895.html
[3] [alsa-devel] [PATCH 0/4] ALSA: Extend PCM buffer-copy helpers
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-May/120957.html
[4] takaswie/sound
https://github.com/takaswie/sound/tree/topic/add-pcm-frame-ops

Takashi Sakamoto (11):
  ALSA: pcm: introduce an alias of prototype to copy PCM frames
  ALSA: pcm: use new function alias instead of local one
  ALSA: pcm: refactoring silence operation
  ALSA: pcm: add alternative calls
  ALSA: core: remove duplicated codes to handle PCM frames
  ALSA: pcm: add new operation; copy_frames
  ALSA: rme9652: a sample for drivers which support interleaved buffer
  ALSA: gus: a sample for drivers which support non-interleaved buffer
  ALSA: pcm: remove copy and silence callbacks
  ALSA: pcm: add client_space parameter to runtime of PCM substream for
    PCM proxy drivers
  ALSA: pcm: add new configuration for PCM proxy drivers

 drivers/usb/gadget/Kconfig |   3 +-
 include/sound/pcm.h        |  13 +-
 sound/core/Kconfig         |  15 +-
 sound/core/pcm_lib.c       | 448 +++++++++++++++++++++++++++++----------------
 sound/core/pcm_native.c    |  10 +
 sound/isa/gus/gus_pcm.c    | 100 +++++-----
 sound/pci/rme9652/hdsp.c   |  59 +++---
 7 files changed, 398 insertions(+), 250 deletions(-)

-- 
2.11.0
