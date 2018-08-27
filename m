From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/8] ALSA: non-cached memalloc helper
Date: Mon, 27 Aug 2018 10:59:45 +0200
Message-ID: <20180827085953.10614-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CF231267849
 for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2018 11:00:00 +0200 (CEST)
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
Cc: Hans Hu <HansHu@zhaoxin.com>
List-Id: alsa-devel@alsa-project.org

Hi,

this is a patchset to add the non-cached page handling in the memory
allocation helpers, which have been implemented individually in
several driver codes.  This also fixes a long-time bug of HD-audio
non-mmap behavior in the non-snoop mode, which was reported recently.


Takashi

===

Takashi Iwai (8):
  ALSA: memalloc: Don't align the size to power-of-two
  ALSA: memalloc: Simplify snd_malloc_dev_pages() calls
  ALSA: memalloc: Add non-cached buffer type
  ALSA: hda: Check the non-cached stream buffers more explicitly
  ALSA: hda: Use new non-cached allocation for non-snoop mode
  ALSA: hda: Remove substream allocation/free ops
  ALSA: intel8x0: Use the new non-cached allocation for 440MX workaround
  ALSA: intel_hdmi: Use the new non-cached allocation

 include/sound/memalloc.h       |   3 +
 sound/core/memalloc.c          |  40 ++++++++-----
 sound/core/sgbuf.c             |  15 ++++-
 sound/pci/hda/hda_controller.c |  13 +++--
 sound/pci/hda/hda_controller.h |   7 +--
 sound/pci/hda/hda_intel.c      | 103 ++++-----------------------------
 sound/pci/hda/hda_tegra.c      |  18 +-----
 sound/pci/intel8x0.c           |  89 ++++------------------------
 sound/x86/intel_hdmi_audio.c   |  29 +---------
 9 files changed, 75 insertions(+), 242 deletions(-)

-- 
2.18.0
