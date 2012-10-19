From: joseph.salisbury@canonical.com
Subject: [PATCH 0/1] ALSA: hda - add quirk for Thinkpad T430
Date: Fri, 19 Oct 2012 10:32:29 -0400
Message-ID: <cover.1350570761.git.joseph.salisbury__49018.2936228395$1350657193$gmane$org@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, perex@perex.cz, tiwai@suse.de, david.henningsson@canonical.com, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Joseph Salisbury <joseph.salisbury@canonical.com>

BugLink: https://bugs.launchpad.net/bugs/1060372

This patch is to enable audio on T430 Thinkpads.  There is no audo from the headphone jack without this patch.  This patch adds a quirk for the T430 model.  


== Test Case ==
A test kernel was built with this patch and tested by a bug reporter at the following bug: 
BugLink: https://bugs.launchpad.net/bugs/1060372



Joseph Salisbury (1):
  ALSA: hda - add quirk for Thinkpad T430

 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

-- 
1.7.9.5
