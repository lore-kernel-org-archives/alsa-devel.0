From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Don't clear the power state at
	snd_hda_codec_reset()
Date: Wed, 13 Nov 2013 17:03:22 +0100
Message-ID: <1384358602-18897-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D407261671
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2013 17:03:23 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id EA83AA7A39
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2013 17:03:22 +0100 (CET)
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

snd_hda_codec_reset() is called either in resetting the whole setup at
error paths or hwdep clear/reconfig sysfs triggers.  But all of these
don't assume that the power has to be off, rather they want to keep
the power state unchanged (e.g. reconfig_codec() calls the power
up/down by itself).  Thus, unconditionally clearing the power state in
snd_hda_codec_reset() leads to the inconsistency, confuses the further
operation.   This patch gets rid of the lines doing that bad thing.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index dd5403d40830..afb90f48867f 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2579,9 +2579,6 @@ int snd_hda_codec_reset(struct hda_codec *codec)
 	cancel_delayed_work_sync(&codec->jackpoll_work);
 #ifdef CONFIG_PM
 	cancel_delayed_work_sync(&codec->power_work);
-	codec->power_on = 0;
-	codec->power_transition = 0;
-	codec->power_jiffies = jiffies;
 	flush_workqueue(bus->workq);
 #endif
 	snd_hda_ctls_clear(codec);
-- 
1.8.4.2
