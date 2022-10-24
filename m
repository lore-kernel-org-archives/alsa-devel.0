Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9DB0FA373F
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Oct 2022 16:30:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B1255703A;
	Mon, 24 Oct 2022 18:29:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B1255703A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666629045;
	bh=DBTpTJtTbSrqhS6RbOJuyYYG4JFCfrhBiLcqpsg0wMA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vSEqZ8ExdY9KtejeleArvTIkZJsnQa0S9UFX+LHmfZXsvbh1UhpOTMz0R8hPhxwc6
	 yjbAqVWmUb87FvrFnUgMUVX/F0FM8ZxH5SptowpuAVQm3eKqhXKBLvDL907g0pQV58
	 SdDuutkrTq3pd3eC4ci6pnUI/RUpSAPsbMQd107s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9E1FBF80548;
	Mon, 24 Oct 2022 18:29:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 24CFEF80552; Mon, 24 Oct 2022 18:29:49 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 68D37F80548
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2022 18:29:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68D37F80548
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com
 header.b="ETLhNSfS"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2207FB8149C;
 Mon, 24 Oct 2022 16:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24361C433C1;
 Mon, 24 Oct 2022 16:29:40 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
 dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com
 header.b="ETLhNSfS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105; 
 t=1666628977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qnKFjujepPdHfbu6wRQ2lttGCtGZBN1T6S7yDpV4J5A=;
 b=ETLhNSfSiAmLj+AZrLmp7/4zcstrELM+f+w78HntrC8J42WcHfhT1NyCLCMKdrbxlPL7dw
 a2cXXQvMyOueS+Y1ewL6sMriom1YBMXTu+SZV19/6PXXJYqbfeQ2tUoflGdM8HI6yRaINw
 FYkss2wQ/Z4MEHcOLzL60m+i2kM+HYA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8bdfdced
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Mon, 24 Oct 2022 16:29:37 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: au88x0: use explicitly signed char
Date: Mon, 24 Oct 2022 18:29:29 +0200
Message-Id: <20221024162929.536004-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

With char becoming unsigned by default, and with `char` alone being
ambiguous and based on architecture, signed chars need to be marked
explicitly as such. This fixes warnings like:

sound/pci/au88x0/au88x0_core.c:2029 vortex_adb_checkinout() warn: signedness bug returning '(-22)'
sound/pci/au88x0/au88x0_core.c:2046 vortex_adb_checkinout() warn: signedness bug returning '(-12)'
sound/pci/au88x0/au88x0_core.c:2125 vortex_adb_allocroute() warn: 'vortex_adb_checkinout(vortex, (0), en, 0)' is unsigned
sound/pci/au88x0/au88x0_core.c:2170 vortex_adb_allocroute() warn: 'vortex_adb_checkinout(vortex, stream->resources, en, 4)' is unsigned

As well, since one function returns errnos, return an `int` rather than
a `signed char`.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 sound/pci/au88x0/au88x0.h      | 6 +++---
 sound/pci/au88x0/au88x0_core.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/au88x0/au88x0.h b/sound/pci/au88x0/au88x0.h
index 0aa7af049b1b..6cbb2bc4a048 100644
--- a/sound/pci/au88x0/au88x0.h
+++ b/sound/pci/au88x0/au88x0.h
@@ -141,7 +141,7 @@ struct snd_vortex {
 #ifndef CHIP_AU8810
 	stream_t dma_wt[NR_WT];
 	wt_voice_t wt_voice[NR_WT];	/* WT register cache. */
-	char mixwt[(NR_WT / NR_WTPB) * 6];	/* WT mixin objects */
+	s8 mixwt[(NR_WT / NR_WTPB) * 6];	/* WT mixin objects */
 #endif
 
 	/* Global resources */
@@ -235,8 +235,8 @@ static int vortex_alsafmt_aspfmt(snd_pcm_format_t alsafmt, vortex_t *v);
 static void vortex_connect_default(vortex_t * vortex, int en);
 static int vortex_adb_allocroute(vortex_t * vortex, int dma, int nr_ch,
 				 int dir, int type, int subdev);
-static char vortex_adb_checkinout(vortex_t * vortex, int resmap[], int out,
-				  int restype);
+static int vortex_adb_checkinout(vortex_t * vortex, int resmap[], int out,
+				 int restype);
 #ifndef CHIP_AU8810
 static int vortex_wt_allocroute(vortex_t * vortex, int dma, int nr_ch);
 static void vortex_wt_connect(vortex_t * vortex, int en);
diff --git a/sound/pci/au88x0/au88x0_core.c b/sound/pci/au88x0/au88x0_core.c
index 2ed5100b8cae..f217c02dfdfa 100644
--- a/sound/pci/au88x0/au88x0_core.c
+++ b/sound/pci/au88x0/au88x0_core.c
@@ -1998,7 +1998,7 @@ static const int resnum[VORTEX_RESOURCE_LAST] =
  out: Mean checkout if != 0. Else mean Checkin resource.
  restype: Indicates type of resource to be checked in or out.
 */
-static char
+static int
 vortex_adb_checkinout(vortex_t * vortex, int resmap[], int out, int restype)
 {
 	int i, qty = resnum[restype], resinuse = 0;
-- 
2.38.1

