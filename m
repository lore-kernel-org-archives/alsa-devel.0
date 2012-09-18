From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH v2 1/4] ALSA: usb-audio: set period_bytes in
	substream.
Date: Tue, 18 Sep 2012 09:49:46 -0700
Message-ID: <1347986988-11382-2-git-send-email-dgreid@chromium.org>
References: <1347986988-11382-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f201.google.com (mail-wi0-f201.google.com
 [209.85.212.201])
 by alsa0.perex.cz (Postfix) with ESMTP id 5471D2650E2
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2012 18:49:53 +0200 (CEST)
Received: by wibhm2 with SMTP id hm2so2553wib.2
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2012 09:49:53 -0700 (PDT)
In-Reply-To: <1347986988-11382-1-git-send-email-dgreid@chromium.org>
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Set the peiod_bytes member of snd_usb_substream.  It was no longer being
set, but will be needed to resume properly in a future commit.

Change-Id: I4cf4681f16f8a71d26c586520afed9e8c27433b2
Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/usb/pcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index f782ce1..786f7a0 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -486,6 +486,8 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (changed) {
+		subs->period_bytes = params_period_bytes(hw_params);
+
 		mutex_lock(&subs->stream->chip->shutdown_mutex);
 		/* format changed */
 		stop_endpoints(subs, 0, 0, 0);
-- 
1.7.12.146.g16d26b1
