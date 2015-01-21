From: =?UTF-8?B?UmljaGFyZCBLw7ZyYmVy?= <alsa@ml.shredzone.de>
Subject: [PATCH] USB-audio: Sound Blaster HD iec958 is on
	device 1
Date: Wed, 21 Jan 2015 01:02:34 +0100
Message-ID: <54BEEC9A.8070805@ml.shredzone.de>
References: <5341C8DF.9020604@ml.shredzone.de> <s5hk3b1ms1f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arrietty.shredzone.net (arrietty.shredzone.net
 [213.133.102.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 59999260710
 for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2015 01:02:35 +0100 (CET)
Received: from xdsl-78-35-152-201.netcologne.de ([78.35.152.201]
 helo=ronja.home)
 by arrietty.shredzone.net with esmtpsa (UNKNOWN:AES128-SHA:128)
 (Exim 4.72) (envelope-from <alsa@ml.shredzone.de>)
 id 1YDikk-0001TA-No
 for alsa-devel@alsa-project.org; Wed, 21 Jan 2015 01:02:34 +0100
In-Reply-To: <s5hk3b1ms1f.wl%tiwai@suse.de>
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

Creative Sound Blaster X-Fi HD uses device 1 for iec958 output.
---
 src/conf/cards/USB-Audio.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.conf
index 05e5d09..bae7669 100644
--- a/src/conf/cards/USB-Audio.conf
+++ b/src/conf/cards/USB-Audio.conf
@@ -36,6 +36,7 @@ USB-Audio.pcm.surround40_type {
 # number for the iec958 device can be changed here.
 USB-Audio.pcm.iec958_device {
        # "NoiseBlaster 3000" 42
+        "USB Sound Blaster HD" 1
 
        # The below don't have digital in/out, so prevent them from being opened.
        "Andrea PureAudio USB-SA Headset" 999
-- 
2.1.0
