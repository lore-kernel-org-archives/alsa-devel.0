From: Martin Langer <martin-langer@gmx.de>
Subject: [PATCH] rme32 fullduplex fix
Date: Sat, 17 Jul 2004 21:05:54 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040717190554.GA513@tuba.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
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
To: alsa-devel@lists.sourceforge.net
Cc: pilo.c@wanadoo.fr
List-Id: alsa-devel@alsa-project.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Kudos to Takashi and Pilo!

Fullduplex (using module option 'fullduplex=1') works now on rme32 :)
Please commit the attached patch, which fixes a strange bug.


Thanks!
martin


-- 
                                     Living on earth may be expensive,
                   but it includes an annual free trip around the sun. 

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fix.diff"

--- alsa-kernel/pci/rme32.c.ORIGINAL	Sat Jul 17 18:48:43 2004
+++ alsa-kernel/pci/rme32.c	Sat Jul 17 20:37:58 2004
@@ -1,7 +1,8 @@
 /*
  *   ALSA driver for RME Digi32, Digi32/8 and Digi32 PRO audio interfaces
  *
- *	Copyright (c) 2002, 2003 Martin Langer <martin-langer@gmx.de>
+ *      Copyright (c) 2002-2004 Martin Langer <martin-langer@gmx.de>,
+ *                              Pilo Chambert <pilo.c@wanadoo.fr>
  *
  *      Thanks to :        Anders Torger <torger@ludd.luth.se>,
  *                         Henk Hesselink <henk@anda.nl>
@@ -101,7 +102,7 @@
 MODULE_PARM_DESC(enable, "Enable RME Digi32 soundcard.");
 module_param_array(fullduplex, bool, boot_devs, 0444);
 MODULE_PARM_DESC(fullduplex, "Support full-duplex mode.");
-MODULE_AUTHOR("Martin Langer <martin-langer@gmx.de>");
+MODULE_AUTHOR("Martin Langer <martin-langer@gmx.de>, Pilo Chambert <pilo.c@wanadoo.fr>");
 MODULE_DESCRIPTION("RME Digi32, Digi32/8, Digi32 PRO");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{RME,Digi32}," "{RME,Digi32/8}," "{RME,Digi32 PRO}}");
@@ -153,7 +154,7 @@
 #define RME32_WCR_BITPOS_INP_1 7
 
 /* Read control register bits */
-#define RME32_RCR_AUDIO_ADDR_MASK 0x10001
+#define RME32_RCR_AUDIO_ADDR_MASK 0x1ffff
 #define RME32_RCR_LOCK      (1 << 23)   /* 1=locked, 0=not locked */
 #define RME32_RCR_ERF       (1 << 26)   /* 1=Error, 0=no Error */
 #define RME32_RCR_FREQ_0    (1 << 27)   /* CS841x frequency (record) */

--0OAP2g/MAC+5xKAE--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
