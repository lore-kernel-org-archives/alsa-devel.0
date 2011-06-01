From: Mathieu Bouffard <mbouffard@strangequarks.org>
Subject: HDA Intel/ALC269 microphone problem
Date: Tue, 31 May 2011 21:16:10 -0400
Message-ID: <4DE592DA.8070307@fedoraproject.org>
Reply-To: mbouffard@fedoraproject.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060703090104050607030309"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 41AD42439F
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jun 2011 03:16:14 +0200 (CEST)
Received: by gwj17 with SMTP id 17so2330485gwj.38
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2011 18:16:12 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060703090104050607030309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Read a few bug reports (going back to 2009!) around where users couldn't 
use their microphone with HDA Intel/ALC269. I had one set up JACK for 2 
playback channels and 1 capture channel, make an .asoundrc to route 
everything to pulse which is started with a configuration only using 
module-jack-sink and module-jack-source, start it up and the microphone 
and the whole setup worked. But that's quite a hassle for a workaround!

I had suspicions that it was the stereo mic causing problem and forcing 
mono would work and it seems to be the case. I attached a patch, hoping 
that the fix might be as simple as forcing mono at the ALSA level, but I 
don't think it'll be that simple... Can someone more experienced see if 
more is needed, and if not then commit it?

(orig file is from 3.0-rc1 source)

-- 
Mathieu Bouffard<mbouffard fedoraproject org>


--------------060703090104050607030309
Content-Type: text/plain;
 name="realtek.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="realtek.patch"

Changelog: this is probably not the only fix needed here, see the FIXME comment. I don't have the hardware
to test this.
Signed-off-by: Mathieu Bouffard <mbouffard@fedoraproject.org>
--- sound/pci/hda/patch_realtek.c	2011-05-29 20:43:36.000000000 -0400
+++ sound/pci/hda/fixed_patch_realtek.c	2011-05-31 20:48:43.621911836 -0400
@@ -14659,8 +14659,14 @@
 
 static const struct hda_pcm_stream alc269_44k_pcm_analog_capture = {
 	.substreams = 1,
-	.channels_min = 2,
-	.channels_max = 2,
+	.channels_min = 1,
+	.channels_max = 1,
+	/* FIXME I read multiple bug reports where ALC269 users couldn't use their microphone. I had
+	 * one set up JACK with two channels for output, and only one for input then route
+	 * pulseaudio's sink/source to JACK as a test. It worked, it would seem as if this
+	 * ALC269 does not support stereo capture? The above is probably not the only fix needed
+	 * here, leaving it up to somebody more experienced.
+	*/
 	.rates = SNDRV_PCM_RATE_44100, /* fixed rate */
 	/* NID is set in alc_build_pcms */
 };

--------------060703090104050607030309
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------060703090104050607030309--
