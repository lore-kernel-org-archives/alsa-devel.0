From: Javier Conti <av@labcc.ch>
Subject: Re: Fix for dell inspiron 8100 maestro3
Date: Sat, 17 May 2003 04:45:12 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305170445.13074.av@labcc.ch>
References: <200305161632.46562.av@labcc.ch> <s5hhe7vdjgc.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4Iax+/Rp3tEc1EJ"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhe7vdjgc.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_4Iax+/Rp3tEc1EJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 16 May 2003 17:01, Takashi Iwai wrote:
> are you sure that the patch is correct?
> your patch adds the same vendor an device id with the existing
> inspiron 8000 (1028:00a4).

Ok, I found the correct values, repatched and now the modules tells me the 
hack is enabled. With the other values, that didn't happen. Seen that, I 
tried to recompile a vanilla alsa-driver version, to see if my previous patch 
was doing some difference. The weird thing is that it still didn't work!
I'm puzzled, since the wrong patch fixed the problem anyway...

I'm sorry for the "noise" but hope to be helpful by sending this patch which 
includes the correct values.

Bye, Javier
-- 
Javier Conti - Labcc
Tel: +41(0)91 690 0703
Fax: +41(0)91 690 0702

--Boundary-00=_4Iax+/Rp3tEc1EJ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="maestro3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="maestro3.patch"

--- maestro3.c	2003-04-23 12:06:36.000000000 +0200
+++ /usr/src/modules/alsa-driver/alsa-kernel/pci/maestro3.c	2003-05-17 04:37:29.000000000 +0200
@@ -947,8 +947,14 @@
 		.amp_gpio = -1,
 		.irda_workaround = 1,
 	},
-	/* FIXME: Inspiron 8100 id should probably be here, too
-	 * (8200 irrelevant: has intel8x0 with CS4205) */
+	/* Dell Inspiron 8100 */
+	{
+		.name = "Dell Inspiron 8100",
+		.vendor = 0x1028,
+		.device = 0x00e6,
+		.amp_gpio = -1,
+		.irda_workaround = 1,
+	},
 	/* NEC LM800J/7 */
 	{
 		.name = "NEC LM800J/7",

--Boundary-00=_4Iax+/Rp3tEc1EJ--



-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
