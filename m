From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH] ALSA: hda - Don't power up when not powered
	down.
Date: Thu, 21 Jun 2012 21:51:22 -0700
Message-ID: <1340340682-29695-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f201.google.com (mail-lb0-f201.google.com
	[209.85.217.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 34B21245FE
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jun 2012 05:30:37 +0200 (CEST)
Received: by lbdb5 with SMTP id b5so147213lbd.2
	for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2012 21:51:50 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

After cancel_delayed_work_sync returns, the power down work either never
started (power_on == 1) or finished (power_on == 0).  In the former case
there is no need to power up again.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/hda_codec.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 604699c..045b5e7 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -4444,6 +4444,13 @@ static void __snd_hda_power_up(struct hda_codec *codec, bool wait_power_down)
 	cancel_delayed_work_sync(&codec->power_work);
 
 	spin_lock(&codec->power_lock);
+	/* If the power down delayed work was cancelled above before starting,
+	 * then there is no need to go through power up here.
+	 */
+	if (codec->power_on) {
+		spin_unlock(&codec->power_lock);
+		return;
+	}
 	trace_hda_power_up(codec);
 	snd_hda_update_power_acct(codec);
 	codec->power_on = 1;
-- 
1.7.9.rc0
