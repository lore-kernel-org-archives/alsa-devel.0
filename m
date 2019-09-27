Return-Path: <SRS0=P2CN=XW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94A0C4360C
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Sep 2019 07:17:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3A9D2146E
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Sep 2019 07:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="az8ebPF6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qWFM55N7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A9D2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8ECC315E2;
	Fri, 27 Sep 2019 09:16:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8ECC315E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569568624;
	bh=zb0ljwbKnZ5cHrV/o1SVp0AjiUZSE6uhfpXfnZ0LAPY=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=az8ebPF68B9bMjY8Mvfq0xZMpOXR1U9f12CdghDTmOZN9rcE9fwFXKSwC7aYI6b1l
	 I6tIqiCxf8yQjn4CMh5N2kHP6c2W2b7TOPHs8Y/Hy5pBMGbkuJl14M31hgjiQsDCam
	 ZQvn/Z1j6tFmcbPp5R17B4KdJaGGCkXrcRo1DbQM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 17FF7F8044C;
	Fri, 27 Sep 2019 09:16:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5311AF8049A; Fri, 27 Sep 2019 09:16:12 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 00202F80138
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2019 09:16:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 00202F80138
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qWFM55N7"
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8R7G4QR036352;
 Fri, 27 Sep 2019 02:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1569568564;
 bh=cxUX0V9QJgMtxUcWuyqtRvcxSiRtu+Nn5Z4BXj+Qiyk=;
 h=From:To:CC:Subject:Date;
 b=qWFM55N7RXCpWjeQwt/YCtDz4tGPkgLzqwf/xiHL9D9igDjw9aX9Ym8lVkr+b47E3
 ppFIxVke0Ayg3Rc522VGOX6UTTcXKOPdlcrfFuhhS2O3ZEAijaB8qQMMFVrckl0wPx
 pC7Uo3eIhlSFRZ2IjbWHQOPfexVCHKILAoLRAZWI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8R7G49A093113
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 27 Sep 2019 02:16:04 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 27
 Sep 2019 02:16:04 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 27 Sep 2019 02:16:04 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8R7G1fM083442;
 Fri, 27 Sep 2019 02:16:02 -0500
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
Date: Fri, 27 Sep 2019 10:16:46 +0300
Message-ID: <20190927071646.22319-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: tiwai@suse.de, alsa-devel@alsa-project.org,
 pierre-louis.bossart@linux.intel.com, kuninori.morimoto.gx@renesas.com
Subject: [alsa-devel] [PATCH v2] ASoC: soc-pcm: Use different sequence for
	start/stop trigger
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On stream stop currently we stop the DMA first followed by the CPU DAI.
This can cause underflow (playback) or overflow (capture) on the DAI side
as the DMA is no longer feeding data while the DAI is still active.
It can be observed easily if the DAI side does not have FIFO (or it is
disabled) to survive the time while the DMA is stopped, but still can
happen on relatively slow CPUs when relatively high sampling rate is used:
the FIFO is drained between the time the DMA is stopped and the DAI is
stopped.

It can only fixed by using different sequence within trigger for 'stop' and
'start':
case SNDRV_PCM_TRIGGER_START:
case SNDRV_PCM_TRIGGER_RESUME:
case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
	Trigger order: dai_link, DMA, CPU DAI then the codec

case SNDRV_PCM_TRIGGER_STOP:
case SNDRV_PCM_TRIGGER_SUSPEND:
case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
	Trigger order: codec, CPU DAI, DMA then dai_link

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

Changes since v1:
- Rebased on top 'ASoC: soc-component: fix a couple missing error assignments'

Changes since rfc:
- Fixed missing error assignments (copy pasted the error)
- Document the trigger order in the commit message

Regards,
Peter

 sound/soc/soc-pcm.c | 64 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index a1b99ac57d9e..66910500e3b6 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1047,7 +1047,7 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+static int soc_pcm_trigger_start(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_component *component;
@@ -1056,8 +1056,8 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct snd_soc_dai *codec_dai;
 	int i, ret;
 
-	for_each_rtd_codec_dai(rtd, i, codec_dai) {
-		ret = snd_soc_dai_trigger(codec_dai, substream, cmd);
+	if (rtd->dai_link->ops->trigger) {
+		ret = rtd->dai_link->ops->trigger(substream, cmd);
 		if (ret < 0)
 			return ret;
 	}
@@ -1074,6 +1074,42 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	if (ret < 0)
 		return ret;
 
+	for_each_rtd_codec_dai(rtd, i, codec_dai) {
+		ret = snd_soc_dai_trigger(codec_dai, substream, cmd);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int soc_pcm_trigger_stop(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_component *component;
+	struct snd_soc_rtdcom_list *rtdcom;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai;
+	int i, ret;
+
+	for_each_rtd_codec_dai(rtd, i, codec_dai) {
+		ret = snd_soc_dai_trigger(codec_dai, substream, cmd);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = snd_soc_dai_trigger(cpu_dai, substream, cmd);
+	if (ret < 0)
+		return ret;
+
+	for_each_rtdcom(rtd, rtdcom) {
+		component = rtdcom->component;
+
+		ret = snd_soc_component_trigger(component, substream, cmd);
+		if (ret < 0)
+			return ret;
+	}
+
 	if (rtd->dai_link->ops->trigger) {
 		ret = rtd->dai_link->ops->trigger(substream, cmd);
 		if (ret < 0)
@@ -1083,6 +1119,28 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	return 0;
 }
 
+static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	int ret;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		ret = soc_pcm_trigger_start(substream, cmd);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		ret = soc_pcm_trigger_stop(substream, cmd);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
 static int soc_pcm_bespoke_trigger(struct snd_pcm_substream *substream,
 				   int cmd)
 {
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
