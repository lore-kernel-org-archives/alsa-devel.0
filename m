From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/4] ALSA: Yet more cleanups for procfs
Date: Tue,  5 Feb 2019 17:07:54 +0100
Message-ID: <20190205160758.9172-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A55282678FE
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 17:08:01 +0100 (CET)
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

this is the last part of my procfs cleanup patches.
These are merely cleanups, no functional changes are expected.

The whole patches are found in topic/proc-fixes in sound git tree.


thanks,

Takashi

===

Takashi Iwai (4):
  ALSA: info: Drop unused snd_info_entry.card field
  ALSA: info: Minor optimization
  ALSA: info: Move card id proc creation into info.c
  ALSA: cs46xx: Clean up proc file creations

 include/sound/core.h                |  1 -
 include/sound/info.h                |  1 -
 sound/core/info.c                   | 36 +++++++--------
 sound/core/init.c                   | 31 ++-----------
 sound/pci/cs46xx/cs46xx_dsp_spos.h  |  6 ---
 sound/pci/cs46xx/dsp_spos.c         | 87 ++++++++++++-------------------------
 sound/pci/cs46xx/dsp_spos_scb_lib.c | 13 +++---
 7 files changed, 55 insertions(+), 120 deletions(-)

-- 
2.16.4
