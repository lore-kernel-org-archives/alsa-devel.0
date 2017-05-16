From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/2] Remove set_fs() from drivers
Date: Tue, 16 May 2017 09:31:58 +0200
Message-ID: <20170516073200.29504-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FCF02674CC
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 09:32:02 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id D2BA4ABBD
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 07:32:01 +0000 (UTC)
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

this is again a resubmission of a part of the previous RFC patchset.
No changes for them, just submitted as the official patches for
merging to 4.13.


Takashi

===

Takashi Iwai (2):
  ALSA: opl3: Kill unused set_fs()
  ALSA: emu10k1: Get rid of set_fs() usage

 sound/drivers/opl3/opl3_oss.c |  14 -----
 sound/pci/emu10k1/emufx.c     | 127 ++++++++++++++++++++++++------------------
 2 files changed, 73 insertions(+), 68 deletions(-)

-- 
2.12.2
