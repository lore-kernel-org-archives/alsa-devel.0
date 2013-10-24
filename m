From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix unbalanced runtime PM refcount
	after S3/S4
Date: Thu, 24 Oct 2013 09:22:13 +0200
Message-ID: <1382599333-7808-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 354332608D9
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 09:19:19 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id AB1A9A591F
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 09:19:18 +0200 (CEST)
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

When a machine goes to S3/S4 after power-save is enabled, the runtime
PM refcount might be incorrectly decreased because the power-down
triggered soon after resume assumes that the controller was already
powered up, and issues the pm_notify down.

This patch fixes the incorrect pm_notify call simply by checking the
current value properly.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 5b6c4e3..748c6a9 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -4864,8 +4864,8 @@ static void hda_power_work(struct work_struct *work)
 	spin_unlock(&codec->power_lock);
 
 	state = hda_call_codec_suspend(codec, true);
-	codec->pm_down_notified = 0;
-	if (!bus->power_keep_link_on && (state & AC_PWRST_CLK_STOP_OK)) {
+	if (!codec->pm_down_notified &&
+	    !bus->power_keep_link_on && (state & AC_PWRST_CLK_STOP_OK)) {
 		codec->pm_down_notified = 1;
 		hda_call_pm_notify(bus, false);
 	}
-- 
1.8.4
