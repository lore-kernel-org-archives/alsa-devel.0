From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/4] ALSA: HD-audio HDMI binding fixes
Date: Wed, 28 Jun 2017 14:58:50 +0200
Message-ID: <20170628125854.13022-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F23DC2670D7
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 14:58:55 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 8A036AEE6
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 12:58:55 +0000 (UTC)
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

this is a patch serires to address the issue recently reported by
Intel gfx people.  The first patch is the critical one, and it'll go
to for-linus branch, possibly for 4.12, while others are some
following works and cleanups.


Takashi

===

Takashi Iwai (4):
  ALSA: hda - Fix endless loop of codec configure
  ALSA: hda - Skip card registration when no codec is found
  ALSA: hda - Bind with i915 component before codec binding
  ALSA: hda - Minor code refactoring for Intel HDMI codec parsers

 sound/pci/hda/hda_codec.h      |  2 +
 sound/pci/hda/hda_controller.c | 11 ++++-
 sound/pci/hda/hda_intel.c      |  4 +-
 sound/pci/hda/patch_hdmi.c     | 94 +++++++++++++++---------------------------
 4 files changed, 47 insertions(+), 64 deletions(-)

-- 
2.13.2
