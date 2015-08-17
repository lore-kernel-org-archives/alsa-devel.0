From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/4] Minor cleanups to hda code
Date: Mon, 17 Aug 2015 15:44:07 +0200
Message-ID: <1439819051-32166-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 87F97260453
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 15:44:22 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id DDCE3AD9E
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 13:44:21 +0000 (UTC)
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

this is a series of trivial cleanup patches for HDA driver, mostly for
procfs code.

Takashi Iwai (4):
  ALSA: hda - Make some helper functions local
  ALSA: hda/proc - Add const to possible places
  ALSA: hda/proc - Fix racy string access for power states
  ALSA: hda/eld - Add const to possible places

 sound/pci/hda/hda_codec.c |  70 ------------------------------
 sound/pci/hda/hda_codec.h |   7 ---
 sound/pci/hda/hda_eld.c   |  10 ++---
 sound/pci/hda/hda_proc.c  | 107 +++++++++++++++++++++++++++++++++++-----------
 4 files changed, 86 insertions(+), 108 deletions(-)

-- 
2.5.0
