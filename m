From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/4] Be ecologist; save more bits in AZX_DCAPS_*
Date: Thu, 17 Dec 2015 08:35:42 +0100
Message-ID: <1450337746-4580-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C53332654BF
 for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2015 08:35:46 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 878B8AC6F
 for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2015 07:35:44 +0000 (UTC)
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

this patchset cleans up messy AZX_DCAPS_* definitions and remove a few
usages there.


Takashi

===

Takashi Iwai (4):
  ALSA: hda - Merge RIRB_PRE_DELAY into CTX_WORKAROUND caps
  ALSA: hda - Move Nvidia-specific check into hda_intel.c
  ALSA: hda - Drop AZX_DCAPS_POSFIX_VIA bit
  ALSA: hda - Drop unused AZX_DCAPS_REVERSE_ASSIGN

 sound/pci/hda/hda_controller.c |  7 +------
 sound/pci/hda/hda_controller.h |  8 ++++----
 sound/pci/hda/hda_intel.c      | 20 +++++++++++---------
 3 files changed, 16 insertions(+), 19 deletions(-)

-- 
2.6.4
