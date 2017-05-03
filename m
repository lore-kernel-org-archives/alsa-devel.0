From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] conf: Remove dmix.direct_memory_access
	setup
Date: Wed,  3 May 2017 10:01:17 +0200
Message-ID: <20170503080118.11735-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 332D42668F0
 for <alsa-devel@alsa-project.org>; Wed,  3 May 2017 10:01:25 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id DBFDDAAB2
 for <alsa-devel@alsa-project.org>; Wed,  3 May 2017 08:01:24 +0000 (UTC)
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

The commit [22eca6468b4a: pcm: dmix: Allow disabling x86
optimizations] introduced the new flag for dmix & co,
direct_memory_access.  However, it turned out that such an addition of
the new flag in the default pcm definition causes an error when it's
used with old alsa-lib codes.  Although the code added here is
correct, per se, and it works as expected, it's not wise to break the
configuration with old stuff -- even if the usage is somehow incorrect
and should be avoided.

Since the usage of the new flag is only for HDMI LPE audio, and the
usage of dmix itself should be limited with that hardware, this patch
removes the setup so that it works with the old alsa-lib again.  We
may introduce the dmix behavior change in a smarter way, e.g. passing
some flag from the hardware driver so that it works more generically
without the manual fiddling of config files.

Bugzilla: http://bugzilla.opensuse.org/show_bug.cgi?id=1037021
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/conf/cards/HdmiLpeAudio.conf | 23 -----------------------
 src/conf/pcm/dmix.conf           | 15 ---------------
 2 files changed, 38 deletions(-)

diff --git a/src/conf/cards/HdmiLpeAudio.conf b/src/conf/cards/HdmiLpeAudio.conf
index 61bdfeae2917..dae71facac6d 100644
--- a/src/conf/cards/HdmiLpeAudio.conf
+++ b/src/conf/cards/HdmiLpeAudio.conf
@@ -20,29 +20,6 @@ HdmiLpeAudio.pcm.front.0 {
 	}
 }
 
-# uncached memory reads have a high penalty
-HdmiLpeAudio.dmix.direct_memory_access false
-
-# default with dmix+softvol
-HdmiLpeAudio.pcm.default {
-	@args [ CARD ]
-	@args.CARD {
-		type string
-	}
-	type plug
-	slave.pcm {
-		type softvol
-		slave.pcm {
-			@func concat
-			strings [ "dmix:" $CARD ]
-		}
-		control {
-			name "PCM Playback Volume"
-			card $CARD
-		}
-	}
-}
-
 <confdir:pcm/surround40.conf>
 <confdir:pcm/surround21.conf>
 <confdir:pcm/surround41.conf>
diff --git a/src/conf/pcm/dmix.conf b/src/conf/pcm/dmix.conf
index 2d3b329e533a..7d0aa0158c42 100644
--- a/src/conf/pcm/dmix.conf
+++ b/src/conf/pcm/dmix.conf
@@ -49,21 +49,6 @@ pcm.!dmix {
 		@func refer
 		name defaults.pcm.ipc_perm
 	}
-	direct_memory_access {
-		@func refer
-		name {
-			@func concat
-			strings [
-				"cards."
-				{
-					@func card_driver
-					card $CARD
-				}
-				".dmix.direct_memory_access"
-			]
-		}
-		default true
-	}
 	slave {
 		pcm {
 			type hw
-- 
2.12.2
