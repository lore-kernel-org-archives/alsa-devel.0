From: Imre Deak <imre.deak@intel.com>
Subject: [PATCH 11/11] sound/oxygen_io: take msecs_to_jiffies_min into use
Date: Fri, 10 May 2013 15:13:29 +0300
Message-ID: <1368188011-23661-11-git-send-email-imre.deak@intel.com>
References: <1368188011-23661-1-git-send-email-imre.deak@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1368188011-23661-1-git-send-email-imre.deak@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use msecs_to_jiffies_min instead of open-coding the same.

Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 sound/pci/oxygen/oxygen_io.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/oxygen/oxygen_io.c b/sound/pci/oxygen/oxygen_io.c
index 521eae4..132ecbe 100644
--- a/sound/pci/oxygen/oxygen_io.c
+++ b/sound/pci/oxygen/oxygen_io.c
@@ -108,7 +108,7 @@ static int oxygen_ac97_wait(struct oxygen *chip, unsigned int mask)
 	wait_event_timeout(chip->ac97_waitqueue,
 			   ({ status |= oxygen_read8(chip, OXYGEN_AC97_INTERRUPT_STATUS);
 			      status & mask; }),
-			   msecs_to_jiffies(1) + 1);
+			   msecs_to_jiffies_min(1));
 	/*
 	 * Check even after a timeout because this function should not require
 	 * the AC'97 interrupt to be enabled.
-- 
1.7.10.4
