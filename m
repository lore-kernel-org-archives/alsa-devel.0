From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/6] Cleanup and removal of set_fs() from
	HD-audio
Date: Tue, 16 May 2017 09:23:44 +0200
Message-ID: <20170516072350.25070-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C7D32674CC
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 09:23:52 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 10925AAF2
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 07:23:52 +0000 (UTC)
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

this is the resubmission of a part of the previous RFC patchset.
There is no change since then for them, it's just officially submitted
for merging to 4.13.


Takashi

===

Takashi Iwai (6):
  ALSA: hda - Simplify bound-beep mute control for ALC268
  ALSA: hda - Move bind-mixer switch codes to generic parser
  ALSA: hda - Remove the generic bind ctl helpers
  ALSA: hda - Remove the use of set_fs()
  ALSA: hda - Fix a typo in comment
  ALSA: hda - Remove superfluous header inclusions

 sound/pci/hda/hda_codec.c     | 251 ++++++------------------------------------
 sound/pci/hda/hda_generic.c   |  46 +++++++-
 sound/pci/hda/hda_local.h     |  61 ----------
 sound/pci/hda/patch_realtek.c |  37 +++++--
 4 files changed, 103 insertions(+), 292 deletions(-)

-- 
2.12.2
