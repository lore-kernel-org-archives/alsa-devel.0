From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [PATCH]usx2yloader hotplugging in HEAD
Date: Tue, 2 Dec 2003 09:31:32 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312020931.32523.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi Takashi,

Please commit this to reenable usx2yloader hotplugging:
>>>
Index: alsa-tools/usx2yloader/tascam_fw
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/usx2yloader/tascam_fw,v
retrieving revision 1.1
diff -u -r1.1 tascam_fw
--- alsa-tools/usx2yloader/tascam_fw	23 Sep 2003 14:16:23 -0000	1.1
+++ alsa-tools/usx2yloader/tascam_fw	2 Dec 2003 07:46:08 -0000
@@ -3,7 +3,7 @@
 # load the firmware into Tascam USB devices
 
 FIRMWARE=
-FIRMWAREDIR=/usr/local/share/alsa/firmware
+FIRMWAREDIR=/usr/local/share/alsa/firmware/usx2yloader
 FLAGS=
 LOADER=/sbin/fxload
 LOADERFIRMWARE=$FIRMWAREDIR/tascam_loader.ihx
<<<

Later there should also be some magic to (not) include the "/local" substring, 
I don't know yet how to do that; anybody?

Thanks, 
Karsten




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
