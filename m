From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix cancel_work_sync() stall from
	jackpoll work
Date: Thu, 30 Aug 2018 15:23:44 +0200
Message-ID: <20180830132344.27787-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BAC9B267668
 for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2018 15:23:50 +0200 (CEST)
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
Cc: Lukas Wunner <lukas@wunner.de>
List-Id: alsa-devel@alsa-project.org

On AMD/ATI controllers, the HD-audio controller driver allows a bus
reset upon the error recovery, and its procedure includes the
cancellation of pending jack polling work as found in
snd_hda_bus_codec_reset().  This works usually fine, but it becomes a
problem when the reset happens from the jack poll work itself; then
calling cancel_work_sync() from the work being processed tries to wait
the finish endlessly.

As a workaround, this patch adds the check of current_work() and
applies the cancel_work_sync() only when it's not from the
jackpoll_work.

This doesn't fix the root cause of the reported error below, but at
least, it eases the unexpected stall of the whole system.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=200937
Cc: <stable@vger.kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 0a5085537034..26d348b47867 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3935,7 +3935,8 @@ void snd_hda_bus_reset_codecs(struct hda_bus *bus)
 
 	list_for_each_codec(codec, bus) {
 		/* FIXME: maybe a better way needed for forced reset */
-		cancel_delayed_work_sync(&codec->jackpoll_work);
+		if (current_work() != &codec->jackpoll_work.work)
+			cancel_delayed_work_sync(&codec->jackpoll_work);
 #ifdef CONFIG_PM
 		if (hda_codec_is_power_on(codec)) {
 			hda_call_codec_suspend(codec);
-- 
2.18.0
