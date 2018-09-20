From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/7] Add devres support to card resources
Date: Thu, 20 Sep 2018 17:54:55 +0200
Message-ID: <20180920155502.7534-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 360CC26787F
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2018 17:55:05 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 2414FACE3
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2018 15:55:05 +0000 (UTC)
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

here is the patchset containing the changes to support a
device-managed resource management for ALSA card and memory pages.
The actual code changes are identical with the previous RFC series,
but a few documentation updates are included in this official set.


Takashi

===

Takashi Iwai (7):
  ALSA: core: Add device-managed page allocator helper
  ALSA: core: Add managed card creation
  ALSA: intel8x0: Allocate resources with device-managed APIs
  ALSA: atiixp: Allocate resources with device-managed APIs
  ALSA: hda: Allocate resources with device-managed APIs
  ALSA: doc: Brush up the old writing-an-alsa-driver
  ALSA: doc: Add device-managed resource section

 .../kernel-api/writing-an-alsa-driver.rst     | 340 ++++++++++--------
 include/sound/core.h                          |   5 +
 include/sound/memalloc.h                      |   4 +
 sound/core/init.c                             |  95 ++++-
 sound/core/memalloc.c                         |  88 ++++-
 sound/pci/atiixp.c                            | 104 ++----
 sound/pci/atiixp_modem.c                      | 104 ++----
 sound/pci/hda/hda_controller.h                |   1 -
 sound/pci/hda/hda_intel.c                     |  43 +--
 sound/pci/intel8x0.c                          | 143 +++-----
 sound/pci/intel8x0m.c                         | 143 +++-----
 11 files changed, 514 insertions(+), 556 deletions(-)

-- 
2.18.0
