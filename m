From: Janek Hiis <janek@tartu.cv.ee>
Subject: ALSA-0.9.0rc3 from CVS and VIA686a
Date: Thu, 12 Sep 2002 11:23:48 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0209121120160.26926-100000@cat.cvo>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I still don't seem to be able to get sound out of my Asus K7M motherboard 
which has VT82C686a AC97 Audio Controller.

I'm using linux kernel 2.4.19. And all that the driver can produce is 
noise and errors :

ALSA ../alsa-kernel/core/pcm_lib.c:123: Unexpected hw_pointer value 
(stream = 0, delta: -64, max jitter = 4096): wrong interrupt acknowledge?

Also after merging the two drivers (via686 and via8233) the
alsa-driver/utils/insert does not work. Included patch fixes that ...


Janek Hiis


diff -u -3 -p -u -r1.104 insert
--- utils/insert        26 Aug 2002 10:56:51 -0000      1.104
+++ utils/insert        12 Sep 2002 08:23:05 -0000
@@ -361,8 +361,8 @@ case "$1" in
     basic
     insert snd-ac97-codec.o
     insert snd-mpu401-uart.o
-    insert snd-via686.o snd_mpu_port=0x330
-    restore via686.conf
+    insert snd-via82xx.o snd_mpu_port=0x330
+    restore via82xx.conf
     ;;
   ymfpci|yamaha)
     basic



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
