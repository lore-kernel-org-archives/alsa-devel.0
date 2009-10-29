From: Arno Schuring <aelschuring@hotmail.com>
Subject: RFC: ice1712 virtual devices
Date: Thu, 29 Oct 2009 18:48:46 +0100
Message-ID: <4AE9D57E.5090105@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-4.concepts.nl (smtp-4.concepts.nl [213.197.30.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C6CC103818
	for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2009 18:48:57 +0100 (CET)
Received: from d594e6a3.dsl.concepts.nl ([213.148.230.163] helo=[172.22.21.58])
	by smtp-4.concepts.nl with esmtp (Exim 4.69)
	(envelope-from <aelschuring@hotmail.com>) id 1N3Z7D-0005KW-KM
	for alsa-devel@alsa-project.org; Thu, 29 Oct 2009 18:48:51 +0100
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

Hello list,

This is basically a resend of
http://thread.gmane.org/gmane.linux.alsa.devel/59481/focus=59672 , which
 fixed the front: device of ice1712 cards to accept two-channel input.
Currently, the front: device is exposed through the route plugin, which
requires all clients to mmap all 10 channels, even though the front
device is supposed to be a stereo device.

This patch changes the front: device definition such that it matches the
definition of iec958 in the same file. Additionally, I'm tempted to
remove the surround* definitions because the chip does not really offer
surround-style multichannel: it basically just offers multiple stereo
channels, and does not provide any channel mapping beyond stereo.

Finally, I'm also experimenting with the dshare plugin to allow
applications to access the iec958: and front: devices simultaneously.
Can anyone point me to a working example for this? From reading the
alsa-lib documentation, it is not clear to me how I should nest the
different plugins.


Many thanks,
Arno Schuring


--

diff --git a/src/conf/cards/ICE1712.conf b/src/conf/cards/ICE1712.conf
index 01e50d2..d7acb81 100644
--- a/src/conf/cards/ICE1712.conf
+++ b/src/conf/cards/ICE1712.conf
@@ -32,12 +32,28 @@ ICE1712.pcm.front.0 {
        @args.CARD {
                type string
        }
-       type route
-       ttable.0.0 1
-       ttable.1.1 1
-       slave.pcm {
-               type hw
-               card $CARD
+       type asym
+       playback.pcm {
+               type route
+               ttable.0.0 1
+               ttable.1.1 1
+               slave.pcm {
+                       type hw
+                       card $CARD
+               }
+               slave.format S32_LE
+               slave.channels 10
+       }
+       capture.pcm {
+               type route
+               ttable.0.0 1
+               ttable.1.1 1
+               slave.pcm {
+                       type hw
+                       card $CARD
+               }
+               slave.format S32_LE
+               slave.channels 12
        }
 }
