From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch 1/2] ALSA: fireworks: remove some stray checks
Date: Wed, 28 May 2014 19:42:02 +0300
Message-ID: <20140528164202.GB1824@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

We checked "err" earlier.  These things seem to be left over code.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
index a354d26..8e856cc 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -89,8 +89,6 @@ get_hardware_info(struct snd_efw *efw)
 	snprintf(version, sizeof(version), "%u.%u",
 		 (hwinfo->arm_version >> 24) & 0xff,
 		 (hwinfo->arm_version >> 16) & 0xff);
-	if (err < 0)
-		goto end;
 	efw->firmware_version = hwinfo->arm_version;
 
 	strcpy(efw->card->driver, "Fireworks");
@@ -101,8 +99,6 @@ get_hardware_info(struct snd_efw *efw)
 		 hwinfo->vendor_name, hwinfo->model_name, version,
 		 hwinfo->guid_hi, hwinfo->guid_lo,
 		 dev_name(&efw->unit->device), 100 << fw_dev->max_speed);
-	if (err < 0)
-		goto end;
 
 	if (hwinfo->flags & BIT(FLAG_RESP_ADDR_CHANGABLE))
 		efw->resp_addr_changable = true;
