From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
Subject: Re: Aureal Vortex PATCH [Fwd: via workaround error]
Date: Tue, 13 Jan 2004 20:47:13 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40044B41.8020707@gmx.at>
References: <1073703888.4419.2.camel@localhost>	<s5hbrp9gtc8.wl@alsa2.suse.de>	<4002E295.3050001@gmx.at> <s5hbrp9auwa.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030303040903020302030204"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbrp9auwa.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: manuel.jander@mat.utfsm.cl, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030303040903020302030204
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
[snip]
> i applied the fixed version to cvs.  please check it later.

the changes are fine.

> 
> could you also provide the patch to INSTALL (document) file?

the patch is attached (against current alsa CVS)...

> 
> 
> thanks,
> 
> Takashi

greetings,
wilfried

--------------030303040903020302030204
Content-Type: text/plain;
 name="alsa-1.0.1-aureal-via-quirks-docs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-1.0.1-aureal-via-quirks-docs.patch"

Index: INSTALL
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/INSTALL,v
retrieving revision 1.154
diff -u -r1.154 INSTALL
--- INSTALL	12 Jan 2004 14:40:21 -0000	1.154
+++ INSTALL	13 Jan 2004 19:39:29 -0000
@@ -261,6 +261,14 @@
            control correctly. If you have problems regarding this, try
            another ALSA compliant mixer (alsamixer works).
 
+    pcifix	- Control PCI workarounds
+		  0 = Disable all workarounds
+		  1 = Force the PCI latency of the Aureal card to 0xff
+		  2 = Force the Extend PCI#2 Internal Master for Efficient
+		      Handling of Dummy Requests on the VIA KT133 AGP Bridge
+		  3 = Force both settings
+		  255 = Autodetect what is required (default)
+
 
 Trouble Shooting
 ================

--------------030303040903020302030204--


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
