Return-Path: <SRS0=mf6l=XU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E99FC432C1
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:03:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2991E2082F
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UYndfdTq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k8EfU08q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2991E2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6B02F167F;
	Wed, 25 Sep 2019 13:02:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6B02F167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569409424;
	bh=WVgThZVubXvc+Zgx2Z42TFU8DKWba49ZOThfAMLZ3Bs=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UYndfdTqt0AQZYzZBEacTLVrlloN56sH+E4gCJSDlcSt46wp9A9rC3QGVbaN3oYNI
	 lbuPpOWW5OFAbLlwJofYZy99ue6Z3x7TXZQ5xAgXdmmw4QsS1ZH3L8lkRfX0ZVpI8E
	 xmTejaJCDKQNgVjG0LOPvv+RAjLXs7tT1YPx5Kbg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F2868F80323;
	Wed, 25 Sep 2019 13:02:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AD181F8044C; Wed, 25 Sep 2019 13:02:52 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 052C6F802BD
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2019 13:02:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 052C6F802BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k8EfU08q"
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8PB2b5w069377;
 Wed, 25 Sep 2019 06:02:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1569409358;
 bh=sKbKDIfzReG3X1lHQWmhyPo42ERweW/Q3VuikjiW5A4=;
 h=From:To:CC:Subject:Date;
 b=k8EfU08qjcGhkrEQs5UIw81rqfC/RoQ/25I61UR3N71Q7PKklledu7avi7aq0jgOp
 C//DSwDDm3RGlTITwZgkuaoklBD+JctW1/XDzMLOqNP0u666+hUE5kURaPOJia4fj6
 iFKqP4t0X+lW8emQ6OsGjJdNbtXBttY41gP7G9Xc=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8PB2b8K010962
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 25 Sep 2019 06:02:37 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 25
 Sep 2019 06:02:30 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 25 Sep 2019 06:02:30 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8PB2Y16098180;
 Wed, 25 Sep 2019 06:02:35 -0500
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
Date: Wed, 25 Sep 2019 14:03:16 +0300
Message-ID: <20190925110316.5245-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: tiwai@suse.de, alsa-devel@alsa-project.org,
 pierre-louis.bossart@linux.intel.com, kuninori.morimoto.gx@renesas.com
Subject: [alsa-devel] [PATCH] ASoC: soc-pcm: Use different sequence for
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
 sound/soc/soc-pcm.c | 66 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index e163dde5eab1..41e081e95108 100644
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
@@ -1070,10 +1070,46 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 			return ret;
 	}
 
-	snd_soc_dai_trigger(cpu_dai, substream, cmd);
+	ret = snd_soc_dai_trigger(cpu_dai, substream, cmd);
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
