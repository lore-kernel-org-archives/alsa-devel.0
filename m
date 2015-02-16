From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/6] Modernize sequecner device binding
Date: Mon, 16 Feb 2015 17:55:38 +0100
Message-ID: <1424105744-2187-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 00C852606A8
 for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2015 17:55:45 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B9884AD13
 for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2015 16:55:45 +0000 (UTC)
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

this is a series of patches for 3.21 (or whatever the next-to-next)
to sanitze and modernize the device binding code of ALSA sequencer
core.


Takashi

Takashi Iwai (6):
  ALSA: seq: Move EXPORT_SYMBOL() after each function
  ALSA: seq: Don't compile snd_seq_device_load_drivers() for built-in
  ALSA: seq: Rewrite sequencer device binding with standard bus
  ALSA: seq: Clean up device and driver structs
  ALSA: seq: Define driver object in each driver
  ALSA: seq: Drop snd_seq_autoload_lock() and _unlock()

 include/sound/seq_device.h         |  46 +--
 include/sound/seq_kernel.h         |   6 +-
 sound/core/seq/oss/seq_oss.c       |  22 +-
 sound/core/seq/oss/seq_oss_synth.c |   6 +-
 sound/core/seq/oss/seq_oss_synth.h |   4 +-
 sound/core/seq/seq_device.c        | 569 +++++++++----------------------------
 sound/core/seq/seq_dummy.c         |   6 +-
 sound/core/seq/seq_midi.c          |  36 +--
 sound/drivers/opl3/opl3_seq.c      |  34 +--
 sound/drivers/opl4/opl4_seq.c      |  33 +--
 sound/isa/sb/emu8000_synth.c       |  35 +--
 sound/pci/emu10k1/emu10k1_synth.c  |  35 +--
 12 files changed, 256 insertions(+), 576 deletions(-)

-- 
2.3.0
