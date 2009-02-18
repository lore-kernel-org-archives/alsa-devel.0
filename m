From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] Remove documentation for OSS CS4232 driver
Date: Wed, 18 Feb 2009 19:07:18 +0100
Message-ID: <20090218190718.ca4af94a.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7315410997048742837=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id 96C1224156
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2009 19:02:35 +0100 (CET)
Received: from poczta.interia.pl (mi02.poczta.interia.pl [10.217.12.2])
	by smtp239.poczta.interia.pl (INTERIA.PL) with ESMTP id CF02629A1C5
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2009 19:02:30 +0100 (CET)
Received: from krzysio.net (93-181-133-4.as.kn.pl [93.181.133.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id A9D2D2BC3BB
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2009 19:02:30 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--===============7315410997048742837==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Krzysztof Helt <krzysztof.h1@wp.pl>

There is no OSS cs4232 driver in the kernel
any more and this documentation does not
contain any info useful for ALSA driver.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 Documentation/sound/oss/CS4232 |   23 -----------------------
 1 files changed, 0 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/sound/oss/CS4232

diff --git a/Documentation/sound/oss/CS4232 b/Documentation/sound/oss/CS4232
deleted file mode 100644
index 7d6af7a..0000000
--- a/Documentation/sound/oss/CS4232
+++ /dev/null
@@ -1,23 +0,0 @@
-To configure the Crystal CS423x sound chip and activate its DSP functions,
-modules may be loaded in this order:
-  
-	modprobe sound
-	insmod ad1848
-	insmod uart401
-	insmod cs4232 io=* irq=* dma=* dma2=*
-  
-This is the meaning of the parameters:
-  
-	io--I/O address of the Windows Sound System (normally 0x534)
-	irq--IRQ of this device
-	dma and dma2--DMA channels (DMA2 may be 0)
-  
-On some cards, the board attempts to do non-PnP setup, and fails.  If you
-have problems, use Linux' PnP facilities. 
-  
-To get MIDI facilities add
-  
-	insmod opl3 io=*
-  
-where "io" is the I/O address of the OPL3 synthesizer. This will be shown
-in /proc/sys/pnp and is normally 0x388.
-- 
1.5.2.2


----------------------------------------------------------------------
Promocja w Speak Up. Kurs angielskiego za darmo. 
Liczba miejsc ograniczona. Sprawd¼!>> http://link.interia.pl/f205c


--===============7315410997048742837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7315410997048742837==--
