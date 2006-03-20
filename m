From: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Subject: [PATCH] AMD Au1x00: make driver build after cleanup
Date: Mon, 20 Mar 2006 21:26:56 +0300
Message-ID: <441EF3F0.9080105@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020900000106040407020808"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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
--------------020900000106040407020808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

      AMD Au1x00 ALSA driver doesn't build after the recent code cleanup:

sound/mips/au1x00.c: In function `au1000_setup_dma_link':
sound/mips/au1x00.c:173: error: `pointer' undeclared (first use in this function)
sound/mips/au1x00.c:173: error: (Each undeclared identifier is reported only once
sound/mips/au1x00.c:173: error: for each function it appears in.)
sound/mips/au1x00.c: In function `snd_au1000_hw_params':
sound/mips/au1x00.c:339: warning: implicit declaration of function `snd_mask_min'

WBR, Sergei


--------------020900000106040407020808
Content-Type: text/plain;
 name="Au1x00-make-ALSA-driver-build-after-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Au1x00-make-ALSA-driver-build-after-cleanup.patch"

diff --git a/sound/mips/au1x00.c b/sound/mips/au1x00.c
index 6d8f8b3..9517686 100644
--- a/sound/mips/au1x00.c
+++ b/sound/mips/au1x00.c
@@ -43,6 +43,7 @@
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/pcm.h>
+#include <sound/pcm_params.h>
 #include <sound/ac97_codec.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1000_dma.h>
@@ -153,6 +154,7 @@ au1000_setup_dma_link(struct audio_strea
 {
 	struct snd_pcm_substream *substream = stream->substream;
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct au1000_period *pointer;
 	unsigned long dma_start;
 	int i;
 



--------------020900000106040407020808--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
