From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] sbawe: fix memory detection
Date: Sun, 20 Dec 2009 20:15:19 +0100
Message-ID: <20091220201519.7ebba477.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 747AF1037FB
	for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2009 20:12:49 +0100 (CET)
Received: from poczta.interia.pl (mi04.poczta.interia.pl [10.217.12.4])
	by smtp240.poczta.interia.pl (INTERIA.PL) with ESMTP id 56214270511
	for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2009 20:12:43 +0100 (CET)
Received: from krzysio.net (93-181-133-4.as.kn.pl [93.181.133.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id CFCDF36B10A
	for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2009 20:12:42 +0100 (CET)
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

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Memory amount is increased before a successful write-read
sequence is done. Thus, 512 kB of onboard memory is detected
on memoryless cards like SB32.

Move the increasing of memory counter after successful read
is done.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 sound/isa/sb/emu8000.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/isa/sb/emu8000.c b/sound/isa/sb/emu8000.c
index 96678d5..751762f 100644
--- a/sound/isa/sb/emu8000.c
+++ b/sound/isa/sb/emu8000.c
@@ -393,8 +393,6 @@ size_dram(struct snd_emu8000 *emu)
 
 	while (size < EMU8000_MAX_DRAM) {
 
-		size += 512 * 1024;  /* increment 512kbytes */
-
 		/* Write a unique data on the test address.
 		 * if the address is out of range, the data is written on
 		 * 0x200000(=EMU8000_DRAM_OFFSET).  Then the id word is
@@ -414,7 +412,9 @@ size_dram(struct snd_emu8000 *emu)
 		/*snd_emu8000_read_wait(emu);*/
 		EMU8000_SMLD_READ(emu); /* discard stale data  */
 		if (EMU8000_SMLD_READ(emu) != UNIQUE_ID2)
-			break; /* we must have wrapped around */
+			break; /* no memory at this address */
+
+		size += 512 * 1024;  /* increment 512kbytes */
 
 		snd_emu8000_read_wait(emu);
 
-- 
1.6.4


----------------------------------------------------------------------
Sypie, sypie, ale czy sypac bedzie nadal?
Sprawdz pogode >> http://link.interia.pl/f2530
