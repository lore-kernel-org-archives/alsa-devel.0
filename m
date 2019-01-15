From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/14] ALSA: usb: Remove superfluous
	snd_pcm_suspend*() calls
Date: Tue, 15 Jan 2019 17:21:47 +0100
Message-ID: <20190115162155.6308-7-tiwai@suse.de>
References: <20190115162155.6308-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BA2426744A
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 17:21:58 +0100 (CET)
In-Reply-To: <20190115162155.6308-1-tiwai@suse.de>
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
Cc: Libin Yang <libin.yang@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The call of snd_pcm_suspend_all() & co became superfluous since we
call it in the PCM PM ops.  Let's remove them.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/card.c         | 1 -
 sound/usb/line6/driver.c | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index a105947eaf55..dfa38b78c494 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -811,7 +811,6 @@ static int usb_audio_suspend(struct usb_interface *intf, pm_message_t message)
 		snd_power_change_state(chip->card, SNDRV_CTL_POWER_D3hot);
 	if (!chip->num_suspended_intf++) {
 		list_for_each_entry(as, &chip->pcm_list, list) {
-			snd_pcm_suspend_all(as->pcm);
 			snd_usb_pcm_suspend(as);
 			as->substream[0].need_setup_ep =
 				as->substream[1].need_setup_ep = true;
diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index c1376bfdc90b..7afe8fae4939 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -849,10 +849,8 @@ int line6_suspend(struct usb_interface *interface, pm_message_t message)
 	if (line6->properties->capabilities & LINE6_CAP_CONTROL)
 		line6_stop_listen(line6);
 
-	if (line6pcm != NULL) {
-		snd_pcm_suspend_all(line6pcm->pcm);
+	if (line6pcm != NULL)
 		line6pcm->flags = 0;
-	}
 
 	return 0;
 }
-- 
2.20.1
