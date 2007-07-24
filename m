From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [PATCH] s3c24xx-pcm: fix hw_params dma handling
Date: Tue, 24 Jul 2007 10:56:29 +0200
Message-ID: <854pjufade.fsf@Orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.duckcorp.org (orfeo.duckcorp.org [195.5.254.194])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D2532449E
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Jul 2007 10:56:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: laforge@openmoko.org, gg@opensource.wolfsonmicro.com, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

--=-=-=

Hi,

While testing the recently merged driver for the neo1973, I found out
that it was not working due to dma allocation failure. The problem is
that there's only one dma channel available on s3c2410 and there may be
more than one call to pcm_ops->hw_params(), resulting in dma request
failures. This patch from Harald Welte fix this.

Arnaud


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=asoc-platform-hw_init-pcm_emulation-fix.patch

Since the PCM emulation can call multiple times to hw_setup(), but we 
can only once allocate/request the DMA channel, we have to handle
this gracefully.

Signed-off-by: Harald Welte <laforge@openmoko.org>
Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>

Index: linux-2.6.20/sound/soc/s3c24xx/s3c24xx-pcm.c
===================================================================
--- linux-2.6.20.orig/sound/soc/s3c24xx/s3c24xx-pcm.c	2007-02-15 21:50:25.000000000 +0100
+++ linux-2.6.20/sound/soc/s3c24xx/s3c24xx-pcm.c	2007-02-15 22:25:10.000000000 +0100
@@ -155,18 +155,22 @@
 	if (!dma)
 		return 0;
 
-	/* prepare DMA */
-	prtd->params = dma;
-
-	DBG("params %p, client %p, channel %d\n", prtd->params,
-		prtd->params->client, prtd->params->channel);
-
-	ret = s3c2410_dma_request(prtd->params->channel,
-				  prtd->params->client, NULL);
-
-	if (ret) {
-		DBG(KERN_ERR "failed to get dma channel\n");
-		return ret;
+	/* this may get called several times by oss emulation
+	 * with different params -HW */
+	if (prtd->params == NULL) {
+		/* prepare DMA */
+		prtd->params = dma;
+
+		DBG("params %p, client %p, channel %d\n", prtd->params,
+			prtd->params->client, prtd->params->channel);
+
+		ret = s3c2410_dma_request(prtd->params->channel,
+					  prtd->params->client, NULL);
+
+		if (ret) {
+			DBG(KERN_ERR "failed to get dma channel\n");
+			return ret;
+		}
 	}
 
 	/* channel needs configuring for mem=>device, increment memory addr,

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-=-=--
