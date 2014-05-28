From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch 2/2] ALSA: fireworks: small leak on error path
Date: Wed, 28 May 2014 19:42:46 +0300
Message-ID: <20140528164246.GC1824@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

There was a typo here so we return directly instead of freeing "hwinfo".

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
index 8e856cc..996fdc4 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -157,7 +157,7 @@ get_hardware_info(struct snd_efw *efw)
 	/* Hardware metering. */
 	if (hwinfo->phys_in_grp_count  > HWINFO_MAX_CAPS_GROUPS ||
 	    hwinfo->phys_out_grp_count > HWINFO_MAX_CAPS_GROUPS) {
-		return -EIO;
+		err = -EIO;
 		goto end;
 	}
 	efw->phys_in = hwinfo->phys_in;
