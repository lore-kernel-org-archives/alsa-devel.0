From: Benny Sjostrand <gorm@cucumelo.org>
Subject: [PATCH] alsa-lib: added surround51 configuration for CS46xx cards
Date: Mon, 31 Mar 2003 00:24:28 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E876E9C.1070905@cucumelo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080706020503090100070807"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080706020503090100070807
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

With the latest cs46xx patches it's finally posible to have surround51 
with cs46xx soundcards (only dual CODEC's).
This patch just updates the alsa-lib/src/conf/cards/CS46xx.conf file.

$ aplay -D plug:surround51 ... seems to work fine!

/Benny

--------------080706020503090100070807
Content-Type: text/plain;
 name="alsa-lib.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-lib.patch"

--- alsa-lib/src/conf/cards/CS46xx.conf	Fri Nov 29 15:50:58 2002
+++ ../cvs/alsa-lib/src/conf/cards/CS46xx.conf	Mon Mar 31 00:09:46 2003
@@ -26,6 +26,18 @@
 	device 1
 }	
 
+<confdir:pcm/center_lfe.conf>
+
+CS46xx.pcm.center_lfe.0 {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type hw
+	card $CARD
+	device 3
+}	
+
 <confdir:pcm/surround40.conf>
 
 CS46xx.pcm.surround40.0 {
@@ -59,6 +71,53 @@
 		{ slave 0 channel 1 }
 		{ slave 1 channel 0 }
 		{ slave 1 channel 1 }
+	]
+}
+
+<confdir:pcm/surround51.conf>
+
+CS46xx.pcm.surround51.0 {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type multi
+	slaves [
+		{
+			pcm {
+				@func concat
+				strings [
+					"cards.CS46xx.pcm.front.0:CARD=" $CARD
+				]
+			}
+			channels 2
+		}
+		{
+			pcm {
+				@func concat
+				strings [
+					"cards.CS46xx.pcm.rear.0:CARD=" $CARD
+				]
+			}
+			channels 2
+		}
+		{
+			pcm {
+				@func concat
+				strings [
+					"cards.CS46xx.pcm.center_lfe.0:CARD=" $CARD
+				]
+			}
+			channels 2
+		}
+	]
+	bindings [
+		{ slave 0 channel 0 }
+		{ slave 0 channel 1 }
+		{ slave 1 channel 0 }
+		{ slave 1 channel 1 }
+		{ slave 2 channel 0 }
+		{ slave 2 channel 1 }
 	]
 }
 

--------------080706020503090100070807--



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
