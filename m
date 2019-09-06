Return-Path: <SRS0=qBPI=XB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E877EC43331
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Sep 2019 05:56:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0821A2081B
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Sep 2019 05:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TbDi3qnr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gsAiXqp5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0821A2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB4BE74C;
	Fri,  6 Sep 2019 07:55:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB4BE74C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567749362;
	bh=TkgN8KbTWniKWOsrio7solIiaNyOWrqeP0tzI9Kz95M=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TbDi3qnrUzG0l8WY9Au4k7IJsHmKNyoxvpvyMGSs72DRBkBIkLsPzmilrC9F1ReyY
	 mkvOZ5+6z4yK2RCN+pRhpWcArYFJS1tAl2c3fxcIFPLars+9IKfXrdLVsCrgoXw2fd
	 epQY06ta3V34rF5hP7yoVb5TnAd9mI2EHg8tkaYk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D05BDF80390;
	Fri,  6 Sep 2019 07:55:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 66E8CF80394; Fri,  6 Sep 2019 07:55:09 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 184FDF80214
 for <alsa-devel@alsa-project.org>; Fri,  6 Sep 2019 07:55:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 184FDF80214
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gsAiXqp5"
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x865swV5087402;
 Fri, 6 Sep 2019 00:54:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1567749298;
 bh=Vep51iM/zlBAmxTXn3JZO3WNV9FVkPBD9LlnvYsjub4=;
 h=From:To:CC:Subject:Date;
 b=gsAiXqp5mrMg28j8QM++HJ6EkwqEKo6EFdYteiMaWjlxZDDTs0wwV+YXysqeoDDdG
 a4n5COmOCPjtzBWE1+ZIe6kTk//PeAnb801+N6L/Zt3EScoDu+JjT5fLq5CI43nRf3
 TAnVt86ciaoPzV1P4hXY5VCWYAh1eXo8lpxdYZZ4=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x865swl7121656
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 6 Sep 2019 00:54:58 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 6 Sep
 2019 00:54:57 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 6 Sep 2019 00:54:58 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x865stga105682;
 Fri, 6 Sep 2019 00:54:56 -0500
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
Date: Fri, 6 Sep 2019 08:55:24 +0300
Message-ID: <20190906055524.7393-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, arthur.she@linaro.org
Subject: [alsa-devel] [PATCH] ASoC: dmaengine: Make the pcm->name equal to
	pcm->id if the name is not set
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

Some tools use the snd_pcm_info_get_name() to try to identify PCMs or for
other purposes.

Currently it is left empty with the dmaengine-pcm, in this case copy the
pcm->id string as pcm->name.

For example IGT is using this to find the HDMI PCM for testing audio on it.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reported-by: Arthur She <arthur.she@linaro.org>
---
Hi,

this was actually reported for 4.14 kernel with omap-pcm (replaced by sdma-pcm
in v4.18), since then we only use the generic dmaengine PCM but the same issue
applies today.

Regards,
Peter

 sound/soc/soc-generic-dmaengine-pcm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 748f5f641002..d93db2c2b527 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -306,6 +306,12 @@ static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
 
 		if (!dmaengine_pcm_can_report_residue(dev, pcm->chan[i]))
 			pcm->flags |= SND_DMAENGINE_PCM_FLAG_NO_RESIDUE;
+
+		if (rtd->pcm->streams[i].pcm->name[0] == '\0') {
+			strncpy(rtd->pcm->streams[i].pcm->name,
+				rtd->pcm->streams[i].pcm->id,
+				sizeof(rtd->pcm->streams[i].pcm->name));
+		}
 	}
 
 	return 0;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
