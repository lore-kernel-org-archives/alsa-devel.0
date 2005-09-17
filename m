From: Lee Revell <rlrevell@joe-job.com>
Subject: [PATCH] use dmix/dsnoop for default PCM on ca0106
Date: Sat, 17 Sep 2005 15:03:11 -0400
Message-ID: <1126983792.27211.6.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This chipset lacks hardware mixing so needs to use dmix/dsnoop by
default.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

Index: alsa/alsa-lib/src/conf/cards/CA0106.conf
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/conf/cards/CA0106.conf,v
retrieving revision 1.4
diff -u -r1.4 CA0106.conf
--- alsa/alsa-lib/src/conf/cards/CA0106.conf	3 Aug 2005 12:50:32 -0000	1.4
+++ alsa/alsa-lib/src/conf/cards/CA0106.conf	17 Sep 2005 19:02:16 -0000
@@ -2,6 +2,29 @@
 # Configuration for the CA0106 chip
 #
 
+# default with dmix & dsnoop
+CA0106.pcm.default {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type asym
+	playback.pcm {
+		type plug
+		slave.pcm {
+			@func concat
+			strings [ "dmix:" $CARD ]
+		}
+	}
+	capture.pcm {
+		type plug
+		slave.pcm {
+			@func concat
+			strings [ "dsnoop:" $CARD ]
+		}
+	}
+}
+
 <confdir:pcm/front.conf>
 
 CA0106.pcm.front.0 {




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
