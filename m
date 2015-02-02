From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 00/14] Refactoring ALSA core device management
Date: Mon,  2 Feb 2015 11:24:24 +0100
Message-ID: <1422872678-4815-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F85E2604D8
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 11:24:41 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id AD0ACAC16
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 10:24:39 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

Hi,

this is a series of relatively small patches for refactoring the ALSA
core device management.  I experimented a similar thing some time ago
but didn't merge it in the end due to too intrusive changes.  At this
time, the approach is rather minimalistic: only the device
registration part is replaced by embedding the struct device into
each ALSA device object.

To the outside of ALSA core, there shouldn't be many visible changes.
The only possible breakage would be an access to some renamed /
dropped fields by a downstream driver.  But it must be easy to
correct.

Some patches in the series are merely cleanup patches that can be
applied individually, but included just for completeness.

The whole patches are found in test/snd-device branch of sound git
tree, too.


Takashi

===

Takashi Iwai (14):
  ALSA: Allow to pass the device object to snd_register_device*()
  ALSA: control: Provide a helper to look for the preferred subdevice
  ALSA: Add a helper to initialize device
  ALSA: control: Embed struct device
  ALSA: hwdep: Embed struct device
  ALSA: pcm: Embed struct device
  ALSA: rawmidi: Embed struct device
  ALSA: rawmidi: Use rawmidi device file for kernel messages
  ALSA: timer: Propagate the error at initialization
  ALSA: timer: Handle the device directly
  ALSA: seq: Handle the device directly
  ALSA: compress: Embed struct device
  ALSA: Simplify snd_device_register() variants
  ALSA: Drop snd_get_device() helper

 include/sound/compress_driver.h         |   4 +-
 include/sound/control.h                 |  11 +++-
 include/sound/core.h                    |  41 ++----------
 include/sound/hwdep.h                   |   3 +-
 include/sound/pcm.h                     |   2 +-
 include/sound/rawmidi.h                 |   4 +-
 sound/aoa/soundbus/i2sbus/pcm.c         |   5 +-
 sound/core/compress_offload.c           |  26 ++++++--
 sound/core/control.c                    |  66 +++++++++++--------
 sound/core/hwdep.c                      |  88 ++++++++++---------------
 sound/core/init.c                       |  19 ++++++
 sound/core/pcm.c                        |  70 ++++++--------------
 sound/core/rawmidi.c                    |  47 +++++++-------
 sound/core/seq/seq_clientmgr.c          |  14 +++-
 sound/core/sound.c                      | 112 ++++++++++----------------------
 sound/core/timer.c                      |  42 ++++++++----
 sound/pci/hda/hda_controller.c          |   3 +-
 sound/pci/hda/hda_hwdep.c               |   7 +-
 sound/soc/intel/sst-mfld-platform-pcm.c |   1 -
 19 files changed, 265 insertions(+), 300 deletions(-)

-- 
2.2.2
