From: Frank Mandarino <fmandarino@endrelia.com>
Subject: [PATCH] ASoC at91 - Fix NULL pointer dereference in
	at91_i2s_shutdown
Date: Fri, 29 Dec 2006 13:52:27 -0500
Message-ID: <459563EB.1050304@endrelia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010309090302050109060805"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010309090302050109060805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes a NULL pointer exception which occurs when a
substream is opened and immediately closed.

Signed-off-by: Frank Mandarino <fmandarino@endrelia.com>
Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>

-- 
Frank Mandarino                                fmandarino(a)endrelia.com
Endrelia Technologies Inc.
Toronto, Ontario, Canada

--------------010309090302050109060805
Content-Type: text/plain;
 name="asoc-at91-i2s-nullptr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="asoc-at91-i2s-nullptr.patch"

# HG changeset patch
# User fam@procyon
# Date 1167417628 18000
# Node ID db7345e709ceb94df2cce3ea8ea7d32cc83d789e
# Parent  4eae1a19406e9e14c38efdef7fb1bd603200485d
ASoC at91 - Fix NULL pointer dereference in at91_i2s_shutdown

at91_i2s_shutdown() depends on the snd_soc_cpu_dai dma_data field
being NULL if the substream's DMA parameters were not set up.

However, if a substream was started, then shutdown before the DMA
parameters were setup, the dma_data field would still contain the
value that was set for a previous substream, which pointed to an
invalid at91_pcm_dma_params structure.

The fix is to initialize the dma_data field to NULL when the
substream is started.

Signed-off-by: Frank Mandarino <fmandarino@endrelia.com>
Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>

diff -r 4eae1a19406e -r db7345e709ce soc/at91/at91-i2s.c
--- a/soc/at91/at91-i2s.c	Thu Dec 28 13:56:48 2006 +0100
+++ b/soc/at91/at91-i2s.c	Fri Dec 29 13:40:28 2006 -0500
@@ -295,6 +295,13 @@ static int at91_i2s_startup(struct snd_p
 	}
 	ssc_p->dir_mask |= dir_mask;
 	spin_unlock_irq(&ssc_p->lock);
+
+	/*
+	 * dma_data is not set until hw_params() is called and
+	 * shutdown() depends on this value being NULL if hw_params()
+	 * was not called.
+	 */
+	rtd->cpu_dai->dma_data = NULL;
 
 	return 0;
 }

--------------010309090302050109060805
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------010309090302050109060805
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------010309090302050109060805--
