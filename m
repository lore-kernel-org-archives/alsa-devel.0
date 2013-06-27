From: Przemek Rudy <prudy1@o2.pl>
Subject: [PATCH - microII 1/1] conf/cards: add Audio Advantage
	Micro II
Date: Thu, 27 Jun 2013 23:52:34 +0200
Message-ID: <1372369954-32403-2-git-send-email-prudy1@o2.pl>
References: <1372369954-32403-1-git-send-email-prudy1@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moh2-ve3.go2.pl (moh2-ve3.go2.pl [193.17.41.208])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AE6026564C
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2013 23:52:41 +0200 (CEST)
Received: from moh2-ve3.go2.pl (unknown [10.0.0.208])
 by moh2-ve3.go2.pl (Postfix) with ESMTP id D76933705F7
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2013 23:52:40 +0200 (CEST)
Received: from unknown (unknown [10.0.0.74])
 by moh2-ve3.go2.pl (Postfix) with SMTP
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2013 23:52:40 +0200 (CEST)
In-Reply-To: <1372369954-32403-1-git-send-email-prudy1@o2.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Przemek Rudy <prudy1@o2.pl>
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Przemek Rudy <prudy1@o2.pl>

diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.conf
index 0d93175..8a6d9ca 100644
--- a/src/conf/cards/USB-Audio.conf
+++ b/src/conf/cards/USB-Audio.conf
@@ -101,6 +101,41 @@ USB-Audio."Audiophile USB (tm)".pcm.iec958 {
 	}
 }
 
+# For this card we can (and must to get IEC61937) set AES bits
+USB-Audio."MicroII".pcm.iec958 "cards.USB-Audio.Audio Advantage MicroII.pcm.iec958"
+USB-Audio."Audio Advantage MicroII".pcm.iec958 {
+	@args [ CARD AES0 AES1 AES2 AES3 ]
+	@args.CARD { type string }
+	@args.AES0 { type integer }
+	@args.AES1 { type integer }
+	@args.AES2 { type integer }
+	@args.AES3 { type integer }
+
+    type hooks
+    slave.pcm {
+		type hw
+		card $CARD
+    }
+
+    hooks.0 {
+		type ctl_elems
+		hook_args [
+			{
+				interface PCM
+				name "IEC958 Playback Default"
+				preserve true
+				optional true
+				value [ $AES0 $AES1 $AES2 $AES3 ]
+			}
+			{
+				name "IEC958 Playback Switch"
+				lock true
+				preserve true
+				value 1
+			}
+		]
+	}
+}
 
 ################################################################################
 
-- 
1.8.1.4
