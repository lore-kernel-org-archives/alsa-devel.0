From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH lib 2/5] namehint: Fix the listing without
	device number
Date: Thu, 30 Apr 2015 15:06:15 +0200
Message-ID: <1430399178-15173-3-git-send-email-tiwai@suse.de>
References: <1430399178-15173-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F1D69261584
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 15:06:20 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3C91FAC50
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 13:06:19 +0000 (UTC)
In-Reply-To: <1430399178-15173-1-git-send-email-tiwai@suse.de>
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

The current code of snd_device_name_hint() has a bug when listing up
devices without the device index (e.g. ctl).  Because it assigns the
default device index 0 unconditionally and it has a check at the later
point to filter entries with dev >= 0, it ended up with empty
outputs.

The fix is simply to remove the bogus assignment of dev = 0.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/control/namehint.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/control/namehint.c b/src/control/namehint.c
index 66de634d3550..6c04143a185c 100644
--- a/src/control/namehint.c
+++ b/src/control/namehint.c
@@ -272,7 +272,6 @@ static int try_config(snd_config_t *config,
 	if (snd_config_search(cfg1, "type", &cfg) >= 0 &&
 	    snd_config_get_string(cfg, &str) >= 0 &&
 	    strcmp(str, "hw") == 0) {
-	    	dev = 0;
 		list->device_input = -1;
 		list->device_output = -1;
 		if (snd_config_search(cfg1, "device", &cfg) >= 0) {
-- 
2.3.6
