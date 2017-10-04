From: Tanu Kaskinen <tanuk@iki.fi>
Subject: [PATCH] conf: HdmiLpeAudio: remove the "front" pcm
	definition
Date: Wed,  4 Oct 2017 22:44:00 +0300
Message-ID: <20171004194400.14401-1-tanuk@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id EA490267419
 for <alsa-devel@alsa-project.org>; Wed,  4 Oct 2017 21:45:20 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

PulseAudio assumes that the "front" pcm device always refers to an
analog device, not HDMI. While that assumption is not really valid, the
reality is that without that assumption PulseAudio can't know whether
"front" and "hdmi" refer to a different or the same device.

The HDMI LPE driver doesn't allow audio streaming while the HDMI cable
is unplugged, so PulseAudio has to know when it's plugged in and when
it's not. If both "front" and "hdmi" devices exist, PulseAudio will
notice that HDMI is unplugged, but it doesn't know that "front" refers
to the same device, and PulseAudio will try to use the "front" device
with bad consequences. The kernel driver's refusal to stream any audio
makes PulseAudio enter an infinite loop and then the kernel kills
PulseAudio, because it consumes too much CPU time in a realtime thread.

While the looping in PulseAudio could probably be fixed, that wouldn't
change the fact that PulseAudio thinks that there is an analog device. I
believe it's best to avoid having the same device as both "front" and
"hdmi" in alsa-lib.

I removed also the surround configuration includes. I don't think they
had any effect anyway, so I wonder why they were there in the first
place.

BugLink: https://bugs.freedesktop.org/show_bug.cgi?id=100488
---
 src/conf/cards/HdmiLpeAudio.conf | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/src/conf/cards/HdmiLpeAudio.conf b/src/conf/cards/HdmiLpeAudio.conf
index 9fa30da0..a1e493da 100644
--- a/src/conf/cards/HdmiLpeAudio.conf
+++ b/src/conf/cards/HdmiLpeAudio.conf
@@ -2,30 +2,6 @@
 # Configuration for the Intel HDMI/DP LPE audio
 #
 
-<confdir:pcm/front.conf>
-
-HdmiLpeAudio.pcm.front.0 {
-	@args [ CARD ]
-	@args.CARD {
-		type string
-	}
-	type softvol
-	slave.pcm {
-		type hw
-		card $CARD
-	}
-	control {
-		name "PCM Playback Volume"
-		card $CARD
-	}
-}
-
-<confdir:pcm/surround40.conf>
-<confdir:pcm/surround21.conf>
-<confdir:pcm/surround41.conf>
-<confdir:pcm/surround50.conf>
-<confdir:pcm/surround51.conf>
-
 <confdir:pcm/hdmi.conf>
 
 HdmiLpeAudio.pcm.hdmi.0 {
-- 
2.14.2
