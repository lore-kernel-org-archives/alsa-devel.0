From: Nick Begg <quentin@student.usyd.edu.au>
Subject: [PATCH] add additional PnP id to sb16.c for sb16 'value'
Date: 27 Jan 2003 00:20:33 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1043587236.10200.7.camel@rover>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

Hello All,

I had to add an additional id to the list in sb16.c to get it to
recognise my Creative Soundblaster 16 PnP 'value' (i'd never heard of it
before the other day).. Does this seem correct? Patch is against alsa
0.9.0rc6

Cheers,
nick

--- alsa-driver-0.9.0rc6/alsa-kernel/isa/sb/sb16.c	2002-10-24 05:07:44.000000000 +1000
+++ alsa-driver-0.9.0rc6.new/alsa-kernel/isa/sb/sb16.c	2003-01-26 18:36:58.000000000 +1100
@@ -202,6 +202,9 @@
 	ISAPNP_SB16('C','T','L',0x0070,0x0001),
 	/* Sound Blaster Vibra16CL - added by ctm@ardi.com */
 	ISAPNP_SB16('C','T','L',0x0080,0x0041),
+	/* Sound Blaster 16 'value' PnP. It says model ct4130 on the pcb, */
+	/* but ct4131 on a sticker on the board.. */
+	ISAPNP_SB16('C','T','L',0x0086,0x0041),
 	/* Sound Blaster Vibra16X */
 	ISAPNP_SB16('C','T','L',0x00f0,0x0043),
 #else  /* SNDRV_SBAWE defined */



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
