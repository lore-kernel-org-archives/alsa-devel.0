From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: OSS vs ALSA war :-)
Date: Fri, 13 Aug 2004 14:21:28 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0408131418340.29000-100000@studcom.urz.uni-halle.de>
References: <200408101716.SAA04883@liam2.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mlucom10.urz.uni-halle.de (mlucom10.urz.uni-halle.de [141.48.3.4])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 792C328C
	for <alsa-devel@alsa-project.org>; Fri, 13 Aug 2004 14:21:58 +0200 (MEST)
In-reply-to: <200408101716.SAA04883@liam2.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: William <walsac3@liam2.demon.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

William wrote:
> One big problem is that some parts of ALSA's OSS emulation have been buggy
> for a long time, especially its /dev/sequencer emulation:
> https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=28

Please check if the patch below helps.


HTH
Clemens

-- 
diff -ur rosegarden-2.1pl4/mapper/src/Mapper_OSS.c rosegarden-2.1pl4/mapper/src/Mapper_OSS.c
--- rosegarden-2.1pl4/mapper/src/Mapper_OSS.c	Mon Jul  2 13:54:58 2001
+++ rosegarden-2.1pl4/mapper/src/Mapper_OSS.c	Fri Aug 13 13:27:25 2004
@@ -957,6 +957,7 @@
     static byte LastStatus   = 0x90;
     static byte NumOperands  = 0;
     static byte OperandsLeft = 0;
+    static int LastTime = 0;

     unsigned char InBytes[4];
     int out, pass;
@@ -977,8 +978,8 @@
                /* for the moment we'll just start recording from
                   a normalised "zero" */

-                ReturnEvent->Time = ((InBytes[3]<<16)|(InBytes[2]<<8)|
-                                      InBytes[1]);
+                LastTime = ((InBytes[3]<<16)|(InBytes[2]<<8)|
+                            InBytes[1]);

                 break;

@@ -998,8 +999,8 @@
                         NumOperands = 0; /* no timing info */
                         fprintf(stderr, "SYSTEM MESSAGE\n");
                     }
-                    else if (MessageType(InBytes[1]) == MIDI_CTRL_CHANGE ||
-                               MessageType(InBytes[1]) == MIDI_PROG_CHANGE)
+                    else if (MessageType(InBytes[1]) == MIDI_PROG_CHANGE ||
+                             MessageType(InBytes[1]) == MIDI_CHNL_AFTERTOUCH)
                     {
                         NumOperands = 1;
                     }
@@ -1040,6 +1041,8 @@
                         {
                             OperandsLeft = 2;
                         }
+
+                        ReturnEvent->Time = LastTime;

                         RETURN_BOOL(True);
                     }




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
