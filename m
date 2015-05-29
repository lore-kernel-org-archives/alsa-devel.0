From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [BUG, bisect] ALSA: hda - No sound output
Date: Fri, 29 May 2015 00:27:14 -0700
Message-ID: <20150529072714.GA1338@hudson.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi, all,

On several of my machines there is no longer any sound output when
running the latest linux-next (20150528).  Activity can be seen in a
mixer such as pavucontrol suggesting that there should be sound, but
both the speakers and head phones are silent.

I have bisected the kernel and found that the following patch introduced
the bug.

  From 49fb18972581a781658a4637de76e6069ed5964e Mon Sep 17 00:00:00 2001
  From: Takashi Iwai <tiwai@suse.de>
  Date: Wed, 27 May 2015 08:37:19 +0200
  Subject: [PATCH] ALSA: hda - Set stream_pm ops automatically by generic parser
  
  This allows user to test power_save_node feature via sysfs or patch
  firmware even on the codecs that don't specify it.  It'll also save a
  few lines.
  
  Signed-off-by: Takashi Iwai <tiwai@suse.de>
  ---
   sound/pci/hda/hda_generic.c    | 5 ++++-
   sound/pci/hda/patch_realtek.c  | 1 -
   sound/pci/hda/patch_sigmatel.c | 1 -
   sound/pci/hda/patch_via.c      | 1 -
   4 files changed, 4 insertions(+), 4 deletions(-)

-- 
- Jeremiah Mahler
