From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 0/3] ALSA: Add rewind disable support
Date: Tue, 16 May 2017 06:31:55 +0530
Message-ID: <1494896518-23399-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F4BE266B38
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 03:15:49 +0200 (CEST)
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Rewinds can be disabled when data written in ring buffer will never be
validated. This allows for new HDaudio SPIB DMA functionality(allow fetch
up to the application pointer, no rewind supported). Skylake driver
changes using SPIB will be posted once the core changes are merged.

Based on discussion on community, .ack callback is extended with new
attribute argument, to allow fetch up to the application pointer. Also
drop the mmap of status and control if SPIB functionality is reported by
driver.  There may be some slight performance downside, but it's likely
very small.

Verified the changes with tinyalsa and alsa-lib, with both mmap and
without mmap support and it works fine.

Pierre-Louis Bossart (3):
  ALSA: core: let low-level driver or userspace disable rewinds
  ALSA: core: modify .ack callback to take arguments for updating appl
    ptr
  ALSA: pcm: conditionally avoid mmap of control data

 include/sound/pcm-indirect.h  |  4 ++--
 include/sound/pcm.h           |  9 +++++++-
 include/uapi/sound/asound.h   |  2 ++
 sound/core/pcm_lib.c          |  6 ++++--
 sound/core/pcm_native.c       | 49 ++++++++++++++++++++++++++++++++++++++++++-
 sound/mips/hal2.c             | 14 ++++++++++---
 sound/pci/cs46xx/cs46xx_lib.c | 18 ++++++++++++----
 sound/pci/emu10k1/emupcm.c    |  8 +++++--
 sound/pci/rme32.c             | 15 ++++++++++---
 9 files changed, 107 insertions(+), 18 deletions(-)

-- 
1.9.1
