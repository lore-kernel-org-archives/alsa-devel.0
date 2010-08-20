From: Pierre-Louis Bossart <bossart.nospam@gmail.com>
Subject: [PATCH - HDA-Intel.conf 1/1] HDA-Intel: do not lock
	IEC958 Playback switch
Date: Thu, 19 Aug 2010 20:42:30 -0500
Message-ID: <1282268550-3584-1-git-send-email-pierre-louis.bossart@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id AAE79243ED
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 03:42:47 +0200 (CEST)
Received: by gwb17 with SMTP id 17so1106801gwb.38
	for <alsa-devel@alsa-project.org>; Thu, 19 Aug 2010 18:42:46 -0700 (PDT)
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

As discussed with Takashi, removing the lock allows apps to mute
the output using the mixer interface.
Other AES controls remain locked.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@intel.com>

diff --git a/src/conf/cards/HDA-Intel.conf b/src/conf/cards/HDA-Intel.conf
index 726e8c9..f7eecb4 100644
--- a/src/conf/cards/HDA-Intel.conf
+++ b/src/conf/cards/HDA-Intel.conf
@@ -111,8 +111,6 @@ HDA-Intel.pcm.iec958.0 {
 			}
 			{
 				name "IEC958 Playback Switch"
-				lock true
-				preserve true
 				value true
 			}
 			]
@@ -184,8 +182,6 @@ HDA-Intel.pcm.hdmi.common {
 		{
 			name "IEC958 Playback Switch"
 			index $CTLINDEX
-			lock true
-			preserve true
 			value true
 		}
 		]
-- 
1.7.2.1
