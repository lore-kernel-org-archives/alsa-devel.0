From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: [PATCH 2/5] TerraTec DMX 6Fire USB updates
Date: Mon, 04 Apr 2011 11:47:50 +0200
Message-ID: <12f1fe94164.2149959721155252826.2622803794267683702@zoho.com>
References: <12d995c1fa0.477955495632923443.5387390398635058860@zoho.com>
	<s5hr5c7bjmr.wl%tiwai@suse.de>
	<12da59486cd.-2882799020629445819.-7235974021966893201@zoho.com>
	<s5hmxmuiqgw.wl%tiwai@suse.de>
	<12da867d460.-8772675728917411279.-4777530225625691984@zoho.com>
	<12f0d60921e.7616534511239462585.4849758772336073987@zoho.com>
	<s5hr59mw2u5.wl%tiwai@suse.de>
	<12f1b580363.6419672029244585187.-6233154609191024090@zoho.com>
	<s5hwrjamq64.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id 840541038FD
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 11:47:52 +0200 (CEST)
In-Reply-To: <s5hwrjamq64.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Completion of signedness bug for pcm_runtime.rate: variable will never get assigned a negative value now.

Signed-off-by: Torsten Schenk <torsten.schenk@zoho.com>

diff -Nur a/sound/usb/6fire/pcm.c b/sound/usb/6fire/pcm.c
--- a/sound/usb/6fire/pcm.c	2011-04-04 11:17:56.469832999 +0200
+++ b/sound/usb/6fire/pcm.c	2011-04-04 11:23:12.993833002 +0200
@@ -456,7 +456,7 @@
 		/* all substreams closed? if so, stop streaming */
 		if (!rt->playback.instance && !rt->capture.instance) {
 			usb6fire_pcm_stream_stop(rt);
-			rt->rate = -1;
+			rt->rate = ARRAY_SIZE(rates);
 		}
 	}
 	mutex_unlock(&rt->stream_mutex);
@@ -480,7 +480,6 @@
 	struct pcm_runtime *rt = snd_pcm_substream_chip(alsa_sub);
 	struct pcm_substream *sub = usb6fire_pcm_get_substream(alsa_sub);
 	struct snd_pcm_runtime *alsa_rt = alsa_sub->runtime;
-	int i;
 	int ret;
 
 	if (rt->panic)
@@ -493,12 +492,10 @@
 	sub->period_off = 0;
 
 	if (rt->stream_state == STREAM_DISABLED) {
-		for (i = 0; i < ARRAY_SIZE(rates); i++)
-			if (alsa_rt->rate == rates[i]) {
-				rt->rate = i;
+		for (rt->rate = 0; rt->rate < ARRAY_SIZE(rates); rt->rate++)
+			if (alsa_rt->rate == rates[rt->rate])
 				break;
-			}
-		if (i == ARRAY_SIZE(rates)) {
+		if (rt->rate == ARRAY_SIZE(rates)) {
 			mutex_unlock(&rt->stream_mutex);
 			snd_printk("invalid rate %d in prepare.\n",
 					alsa_rt->rate);
@@ -613,7 +610,7 @@
 
 	rt->chip = chip;
 	rt->stream_state = STREAM_DISABLED;
-	rt->rate = -1;
+	rt->rate = ARRAY_SIZE(rates);
 	init_waitqueue_head(&rt->stream_wait_queue);
 	mutex_init(&rt->stream_mutex);
