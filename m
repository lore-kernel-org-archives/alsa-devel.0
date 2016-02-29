From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hdsp: Fix wrong boolean ctl value
	accesses
Date: Mon, 29 Feb 2016 17:20:06 +0100
Message-ID: <1456762806-2784-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B279265D81
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 17:20:08 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 7DADDADA9
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 16:20:07 +0000 (UTC)
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

snd-hdsp driver accesses enum item values (int) instead of boolean
values (long) wrongly for some ctl elements.  This patch fixes them.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/rme9652/hdsp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 2875b4f6d8c9..7c8941b8b2de 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -2879,7 +2879,7 @@ static int snd_hdsp_get_dds_offset(struct snd_kcontrol *kcontrol, struct snd_ctl
 {
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 
-	ucontrol->value.enumerated.item[0] = hdsp_dds_offset(hdsp);
+	ucontrol->value.integer.value[0] = hdsp_dds_offset(hdsp);
 	return 0;
 }
 
@@ -2891,7 +2891,7 @@ static int snd_hdsp_put_dds_offset(struct snd_kcontrol *kcontrol, struct snd_ctl
 
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
-	val = ucontrol->value.enumerated.item[0];
+	val = ucontrol->value.integer.value[0];
 	spin_lock_irq(&hdsp->lock);
 	if (val != hdsp_dds_offset(hdsp))
 		change = (hdsp_set_dds_offset(hdsp, val) == 0) ? 1 : 0;
-- 
2.7.2
