From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: [PATCH] Audigy LS SPDIF output.
Date: Wed, 23 Jun 2004 19:37:11 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40D9CDD7.9010402@superbug.demon.co.uk>
References: <40D72EBF.80108@superbug.demon.co.uk>	<40D7463C.5090406@ait.nrl.navy.mil>	<40D75C54.7010700@superbug.demon.co.uk>	<40D7AF33.5030405@superbug.demon.co.uk>	<40D84EE9.6000405@superbug.demon.co.uk>	<s5hsmcnlia7.wl@alsa2.suse.de>	<40D885BB.80502@superbug.demon.co.uk> <s5h1xk6jijh.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050305030002080203040009"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h1xk6jijh.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050305030002080203040009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> At Tue, 22 Jun 2004 20:17:15 +0100,
> James Courtier-Dutton wrote:
> 
>>See attachements.
> 
> 
> The patch to alsa-lib seems empty (invalid).
> Could you regenerate it?
> 
> Meanwhile, I applied the patch to alsa-driver.
> 
> 
> thanks,
> 
> Takashi
> 
> 

Sorry, correct version attached.


--------------050305030002080203040009
Content-Type: text/plain;
 name="alsa-lib.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-lib.diff.txt"

Index: alsa-lib/src/conf/cards/AudigyLS.conf
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/conf/cards/AudigyLS.conf,v
retrieving revision 1.1
diff -u -r1.1 AudigyLS.conf
--- alsa-lib/src/conf/cards/AudigyLS.conf	18 Jun 2004 14:29:03 -0000	1.1
+++ alsa-lib/src/conf/cards/AudigyLS.conf	22 Jun 2004 18:10:47 -0000
@@ -146,21 +146,20 @@
 	slave.pcm {
 		type hw
 		card $CARD
-		device 2
+		device 3
 	}
 	hooks.0 {
 		type ctl_elems
 		hook_args [
 			{
-				name "IEC958 Output Switch"
+				name "Analog/Digital Output Jack"
 				lock true
 				preserve true
-				value 1
+				value 0
 			}
 			{
-				interface PCM
-				name "IEC958 Playback PCM Stream"
-				device 0
+				name "IEC958 Playback Default"
+				index 0
 				lock true
 				preserve true
 				value [ $AES0 $AES1 $AES2 $AES3 ]

--------------050305030002080203040009--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
