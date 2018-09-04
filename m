From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/5] Set SNDRV_PCM_INFO_SYNC_APPLPTR to
	indirect PCM usages
Date: Tue,  4 Sep 2018 08:18:46 +0200
Message-ID: <20180904061851.1934-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D4312678CB
 for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2018 08:18:56 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id D87D5AFC4
 for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2018 06:18:55 +0000 (UTC)
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

this is a patch set to pass the missing SNDRV_PCM_INFO_SYNC_APPLPTR
flag to the drivers using the indirect PCM helpers.  Also, one cleanup
of the indirect PCM helper usage in mips/hal2 driver is included.


Takashi

===

Takashi Iwai (5):
  ALSA: rme32: Use SNDRV_PCM_INFO_SYNC_APPLPTR info flag
  ALSA: mips: Use SNDRV_PCM_INFO_SYNC_APPLPTR info flag
  ALSA: emu10k1: Use SNDRV_PCM_INFO_SYNC_APPLPTR info flag
  ALSA: cs46xx: Use SNDRV_PCM_INFO_SYNC_APPLPTR info flag
  ALSA: mips: Cleanup indirect PCM helper usages

 sound/mips/hal2.c             | 13 +++++--------
 sound/pci/cs46xx/cs46xx_lib.c |  6 ++++--
 sound/pci/emu10k1/emupcm.c    |  3 ++-
 sound/pci/rme32.c             | 22 ++++++++--------------
 4 files changed, 19 insertions(+), 25 deletions(-)

-- 
2.18.0
