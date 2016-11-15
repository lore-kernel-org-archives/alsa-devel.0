From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/3] ALSA: emu10k1: EMU1010 dock code cleanup
Date: Tue, 15 Nov 2016 08:24:06 +0100
Message-ID: <20161115072409.29531-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CE12266FC8
 for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2016 08:24:19 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id AD1A0ACDA
 for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2016 07:24:19 +0000 (UTC)
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

this is a short series of patches to clean up the EMU1010 dock
handling code.  The primary goal is to replace kthread usage with
work, but it resulted in a couple of more useful cleanups / fixes.


Takashi

===

Takashi Iwai (3):
  ALSA: emu10k1: Fix emu1010 dock attach check
  ALSA: emu10k1: Simplify firmware loader code
  ALSA: emu10k1: Use workqueue instead of kthread for emu1010 fw polling

 include/sound/emu10k1.h          |   3 +-
 sound/pci/emu10k1/emu10k1.c      |   9 ++
 sound/pci/emu10k1/emu10k1_main.c | 228 ++++++++++++++++-----------------------
 3 files changed, 104 insertions(+), 136 deletions(-)

-- 
2.10.2
