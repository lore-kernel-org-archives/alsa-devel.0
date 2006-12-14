From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] snd-aoa: fix onyx resume
Date: Thu, 14 Dec 2006 15:27:48 +0100
Message-ID: <1166106468.3161.6.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0CA022B3
	for <alsa-devel@alsa-project.org>; Thu, 14 Dec 2006 15:31:52 +0100 (MET)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, ALSA development <alsa-devel@alsa-project.org>, Paul Mackerras <paulus@samba.org>
List-Id: alsa-devel@alsa-project.org

When the machine resumes the onyx codec might be in a weird state. Hence,
simply fully reset it once (and keep the code to take it out of suspend in
case the suspend of the codec chip survives a reset).

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
There's another problem with i2sbus suspend, namely that the i2sbus code
doesn't really handle a suspend well at all, it needs to re-init the
hardware during resume. I noticed because firmware on the quad powermac
doesn't set the i2sbus to 44.1kHz but 42kHz or something like that so
when I was playing a song across suspend/resume it ended up slower...

I don't want to fix this until that i2sbus control rewrite/fix though
because it'll most likely collide.

Takashi, please apply this fix. 

--- linux-2.6-git.orig/sound/aoa/codecs/snd-aoa-codec-onyx.c	2006-12-13 19:32:38.520763489 +0100
+++ linux-2.6-git/sound/aoa/codecs/snd-aoa-codec-onyx.c	2006-12-13 19:34:58.597763489 +0100
@@ -825,7 +825,16 @@ static int onyx_resume(struct codec_info
 	int err = -ENXIO;
 
 	mutex_lock(&onyx->mutex);
-	/* take codec out of suspend */
+
+	/* reset codec */
+	onyx->codec.gpio->methods->set_hw_reset(onyx->codec.gpio, 0);
+	msleep(1);
+	onyx->codec.gpio->methods->set_hw_reset(onyx->codec.gpio, 1);
+	msleep(1);
+	onyx->codec.gpio->methods->set_hw_reset(onyx->codec.gpio, 0);
+	msleep(1);
+
+	/* take codec out of suspend (if it still is after reset) */
 	if (onyx_read_register(onyx, ONYX_REG_CONTROL, &v))
 		goto out_unlock;
 	onyx_write_register(onyx, ONYX_REG_CONTROL, v & ~(ONYX_ADPSV | ONYX_DAPSV));



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
