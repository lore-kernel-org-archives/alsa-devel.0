From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/5] HD-audio widget power-save fixes
Date: Thu,  9 Apr 2015 10:40:33 +0200
Message-ID: <1428568838-21550-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id ECF6A2651D2
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2015 10:40:39 +0200 (CEST)
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
Cc: Hui Wang <hui.wang@canonical.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi,

this is a series of small fixes for the recently added HD-audio widget
power-save feature.  Especially the last patch should fix the Realtek
codec breakage.

The patches are found in topic/hda branch of sound git tree, too.


Takashi

===

Takashi Iwai (5):
  ALSA: hda/generic - Check power state cap at updating the widget power
  ALSA: hda/generic - Fix wrong initial power state for fixed pins
  ALSA: hda/generic - Make snd_hda_gen_path_power_filter() always
    applicable
  ALSA: hda/generic - Don't override power_filter when power_save_node
    is set
  ALSA: hda/realtek - Fix the regression by widget power-saving

 sound/pci/hda/hda_generic.c   | 23 +++++++++++++++++++----
 sound/pci/hda/patch_realtek.c |  5 +++--
 2 files changed, 22 insertions(+), 6 deletions(-)

-- 
2.3.5
