From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/8] ALSA: hda - Don't release firmware when
	CONFIG_PM is set
Date: Thu, 22 Nov 2012 17:54:56 +0100
Message-ID: <1353603300-3217-5-git-send-email-tiwai@suse.de>
References: <1353603300-3217-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EF97260744
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2012 17:55:09 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 18447A3991
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2012 17:55:09 +0100 (CET)
In-Reply-To: <1353603300-3217-1-git-send-email-tiwai@suse.de>
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

The new firmware code tries to re-read the formerly read firmware
files before suspend.  Thus it's wiser to keep the "patch" firmware in
the driver for avoiding this unnecessary re-reading.

Of course, this will consume a bit of memory for unused stuff, but
the patch fw is supposed to be fairly small, so it's more benefit in
the end.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 83be855..4bb52da 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -3507,8 +3507,10 @@ static int DELAYED_INIT_MARK azx_probe_continue(struct azx *chip)
 					 chip->fw->data);
 		if (err < 0)
 			goto out_free;
+#ifndef CONFIG_PM
 		release_firmware(chip->fw); /* no longer needed */
 		chip->fw = NULL;
+#endif
 	}
 #endif
 	if ((probe_only[dev] & 1) == 0) {
-- 
1.8.0
