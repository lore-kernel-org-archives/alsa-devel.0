From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: [PATCH] emu10k1.h
Date: Wed, 25 Feb 2004 01:29:15 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <403BFA6B.3020208@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080301010700070504090402"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080301010700070504090402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Adds some info to /usr/src/linux/include/sound/emu10k1.h

Cheers
James

--------------080301010700070504090402
Content-Type: text/x-patch;
 name="emu10k1.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="emu10k1.h.diff"

--- emu10k1.h.org	2004-02-25 01:08:35.129501584 +0000
+++ emu10k1.h	2004-02-25 01:26:34.617394480 +0000
@@ -644,9 +644,13 @@
 #define SOLEH			0x5d		/* Stop on loop enable high register		*/
 
 #define SPBYPASS		0x5e		/* SPDIF BYPASS mode register			*/
-#define SPBYPASS_ENABLE		0x00000001	/* Enable SPDIF bypass mode			*/
+#define SPBYPASS_SPDIF0_MASK	0x00000003	/* SPDIF 0 bypass mode				*/
+#define SPBYPASS_SPDIF1_MASK	0x0000000c	/* SPDIF 1 bypass mode				*/
+/* bypass mode: 0 - DSP; 1 - SPDIF A, 2 - SPDIF B, 3 - SPDIF C					*/
+#define SPBYPASS_FORMAT		0x00000f00      /* If 1, SPDIF XX uses 24 bit, if 0 - 20 bit	*/
 
 #define AC97SLOT		0x5f            /* additional AC97 slots enable bits		*/
+#define AC97SLOT_10K2		0x03
 #define AC97SLOT_CNTR		0x10            /* Center enable */
 #define AC97SLOT_LFE		0x20            /* LFE enable */
 

--------------080301010700070504090402--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
