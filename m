From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/5] ALSA: usb-audio: process pending stop at
	PCM hw_free and close
Date: Wed, 21 Nov 2012 17:04:39 +0100
Message-ID: <1353513879-401-6-git-send-email-tiwai@suse.de>
References: <1353513879-401-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BF046265D91
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 17:04:47 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id BD344A3A5C
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 17:04:46 +0100 (CET)
In-Reply-To: <1353513879-401-1-git-send-email-tiwai@suse.de>
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

PCM hw_free and close should wait until all the pending stop
operations have been finished.  Basically only PCM trigger callback
should use non-wait calls.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 4750d3d..bc3c9ac 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -446,7 +446,7 @@ static int configure_endpoint(struct snd_usb_substream *subs)
 	int ret;
 
 	/* format changed */
-	stop_endpoints(subs, false);
+	stop_endpoints(subs, true);
 	ret = snd_usb_endpoint_set_params(subs->data_endpoint,
 					  subs->pcm_format,
 					  subs->channels,
@@ -1012,7 +1012,7 @@ static int snd_usb_pcm_close(struct snd_pcm_substream *substream, int direction)
 	struct snd_usb_stream *as = snd_pcm_substream_chip(substream);
 	struct snd_usb_substream *subs = &as->substream[direction];
 
-	stop_endpoints(subs, false);
+	stop_endpoints(subs, true);
 
 	if (!as->chip->shutdown && subs->interface >= 0) {
 		usb_set_interface(subs->dev, subs->interface, 0);
-- 
1.8.0
