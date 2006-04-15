From: Thibault Le Meur <Thibault.LeMeur@supelec.fr>
Subject: Re: [patch] Audiophile-Usb.txt update
Date: Sat, 15 Apr 2006 17:19:56 +0200
Message-ID: <20060415171956.z6wbfpaeas4gcgs8@webmail.supelec.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_32j3600runsw"
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
To: alsa-devel@lists.sourceforge.net
Cc: kouzinopoulos@gmail.com
List-Id: alsa-devel@alsa-project.org

This message is in MIME format.

--=_32j3600runsw
Content-Type: text/plain;
	charset=UTF-8;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

> Thanks a lot. I am attaching a small patch fixing a couple more typos 
> (it is against the patched Audiophile-Usb.txt

Shame on me... I added 2 more typos but Charis has seen them and sent 
me a new small patch against the very last version and here it is.

I promise, next time I'll try to double check my spelling ;-)

Summary: Fix typos (again)

Signed-Of-By: Charis Kouzinopoulos <kouzinopoulos@gmail.com>

Regards,
Thibault




--=_32j3600runsw
Content-Type: text/plain;
	charset=UTF-8;
	name="audiophile-documentation2.patch"
Content-Disposition: inline;
	filename="audiophile-documentation2.patch"
Content-Transfer-Encoding: 7bit

--- Audiophile-Usb.txt	2006-04-15 13:12:01.000000000 +0000
+++ new.txt	2006-04-15 13:20:15.000000000 +0000
@@ -62,7 +62,7 @@
  * snd-usb-audio
  * snd-seq-midi
 
-No additionnal setting is required.
+No additional setting is required.
 
 2.2 - Audio ports
 -----------------
@@ -289,7 +289,7 @@
    is not connected
 
 When device_setup is given as a parameter to the snd-usb-audio module, the 
-parse_audio_enpoint function uses a quirk called 
+parse_audio_endpoints function uses a quirk called 
 "audiophile_skip_setting_quirk" in order to prevent AltSettings not 
 corresponding to device_setup from being registered in the driver.
 
@@ -338,7 +338,7 @@
 This is due to the following restrictions:
 * Jack can only open one capture device and one playback device at a time
 * The Audiophile USB is seen as 2 (or three) Alsa devices: hw:1,0, hw:1,1
-  (and optionnally hw:1,2)
+  (and optionally hw:1,2)
 If you want to get Ai+Di and/or Ao+Do support with Jack, you would need to
 combine the Alsa devices into one logical "complex" device.
 

--=_32j3600runsw--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
