From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: [PATCH] final issues in snd-usb-6fire concerning
	signedness bug
Date: Thu, 16 Jun 2011 21:06:27 +0200
Message-ID: <13099d8e809.-433657093718378069.6298655438333370759@zoho.com>
References: <12d995c1fa0.477955495632923443.5387390398635058860@zoho.com>	<s5hr5c7bjmr.wl%tiwai@suse.de>	<12da59486cd.-2882799020629445819.-7235974021966893201@zoho.com>	<s5hmxmuiqgw.wl%tiwai@suse.de>	<12da867d460.-8772675728917411279.-4777530225625691984@zoho.com>	<12f0d60921e.7616534511239462585.4849758772336073987@zoho.com>
	<s5hr59mw2u5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id 2428E2445D
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Jun 2011 21:06:29 +0200 (CEST)
In-Reply-To: <s5hr59mw2u5.wl%tiwai@suse.de>
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

Fixed remaining issues of the signedness bug discovered by Dan Carpenter. A check was remaining that tests if unsigned rt->rate is >= 0. Changed that so that rt->rate now consistently uses ARRAY_SIZE(rates) as invalid rate value and not -1.


Signed-off-by: Torsten Schenk <torsten.schenk@zoho.com>

diff -Nur a/sound/usb/6fire/pcm.c b/sound/usb/6fire/pcm.c
--- a/sound/usb/6fire/pcm.c	2011-06-16 20:49:55.859600014 +0200
+++ b/sound/usb/6fire/pcm.c	2011-06-16 20:48:07.000000000 +0200
@@ -395,12 +395,12 @@
 	alsa_rt->hw = pcm_hw;
 
 	if (alsa_sub->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		if (rt->rate >= 0)
+		if (rt->rate < ARRAY_SIZE(rates))
 			alsa_rt->hw.rates = rates_alsaid[rt->rate];
 		alsa_rt->hw.channels_max = OUT_N_CHANNELS;
 		sub = &rt->playback;
 	} else if (alsa_sub->stream == SNDRV_PCM_STREAM_CAPTURE) {
-		if (rt->rate >= 0)
+		if (rt->rate < ARRAY_SIZE(rates))
 			alsa_rt->hw.rates = rates_alsaid[rt->rate];
 		alsa_rt->hw.channels_max = IN_N_CHANNELS;
 		sub = &rt->capture;
