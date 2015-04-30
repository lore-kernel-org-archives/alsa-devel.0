From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH lib 5/5] conf: Add hint descriptions to ctl,
	hwdep, seq and timer devices
Date: Thu, 30 Apr 2015 15:06:18 +0200
Message-ID: <1430399178-15173-6-git-send-email-tiwai@suse.de>
References: <1430399178-15173-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0282426172B
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 15:06:20 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3DB48AC54
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 13:06:19 +0000 (UTC)
In-Reply-To: <1430399178-15173-1-git-send-email-tiwai@suse.de>
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/conf/alsa.conf | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/src/conf/alsa.conf b/src/conf/alsa.conf
index 5c928e8afbcd..f22918fbbf83 100644
--- a/src/conf/alsa.conf
+++ b/src/conf/alsa.conf
@@ -345,6 +345,7 @@ ctl.sysdefault {
 			name defaults.ctl.card
 		}
 	}
+	hint.description "Default control device"
 }
 ctl.default ctl.sysdefault
 
@@ -366,6 +367,7 @@ ctl.hw {
 	}
 	type hw
 	card $CARD
+	hint.description "Direct control device"
 }
 
 ctl.shm {
@@ -408,6 +410,7 @@ rawmidi.default {
 			name defaults.rawmidi.device
 		}
 	}
+	hint.description "Default raw MIDI device"
 }
 
 rawmidi.hw {
@@ -469,6 +472,7 @@ rawmidi.virtual {
 
 seq.default {
 	type hw
+	hint.description "Default sequencer device"
 }
 
 seq.hw {
@@ -502,6 +506,7 @@ hwdep.default {
 			name defaults.hwdep.device
 		}
 	}
+	hint.description "Default hardware dependent device"
 }
 
 hwdep.hw {
@@ -536,6 +541,10 @@ hwdep.hw {
 	type hw
 	card $CARD
 	device $DEV
+	hint {
+		description "Direct hardware dependent device"
+		device $DEV
+	}
 }
 
 #
@@ -572,7 +581,7 @@ timer.default {
 		@func refer
 		name defaults.timer.subdevice
 	}
-	hint.description "Default direct hardware timer device"
+	hint.description "Default timer device"
 }
 
 timer.hw {
@@ -618,4 +627,8 @@ timer.hw {
 	card $CARD
 	device $DEV
 	subdevice $SUBDEV
+	hint {
+		description "Direct timer device"
+		device $DEV
+	}
 }
-- 
2.3.6
