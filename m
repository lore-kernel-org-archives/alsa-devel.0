Return-Path: <SRS0=SdJe=AI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96327C433DF
	for <alsa-devel@archiver.kernel.org>; Sat, 27 Jun 2020 05:04:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F22E206C0
	for <alsa-devel@archiver.kernel.org>; Sat, 27 Jun 2020 05:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dIB/8rZi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ODeC6E/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F22E206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AEDAF167B;
	Sat, 27 Jun 2020 07:03:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AEDAF167B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593234254;
	bh=5w0+IewaRLRs1jvC+S2eCq7RU+sLVeZ6WKC55cimqhA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dIB/8rZiXEMpkY82PYj2MJyGRxVzgJF4w3gURZYT+byeqVnp5MOvaIiBjIfYK+jKk
	 XgK6ELTOZnGRJQP9nvcGAjVRvUznH3gs0xpEARyck6LElAwPoVqF3u57wZWMH6Tnsq
	 +r1/RLWBAghKcee4lJqu57gxQmtSmWLML6Y7edgM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 552AEF80350;
	Sat, 27 Jun 2020 06:55:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 674FDF80351; Sat, 27 Jun 2020 06:55:41 +0200 (CEST)
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 181C2F8033E
 for <alsa-devel@alsa-project.org>; Sat, 27 Jun 2020 06:55:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 181C2F8033E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="ODeC6E/p"
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5ef6d1370000>; Fri, 26 Jun 2020 21:55:19 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 26 Jun 2020 21:55:32 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 26 Jun 2020 21:55:32 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 27 Jun
 2020 04:55:32 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 27 Jun 2020 04:55:32 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by
 hqnvemgw03.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5ef6d13f0000>; Fri, 26 Jun 2020 21:55:31 -0700
From: Sameer Pujar <spujar@nvidia.com>
To: <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
 <kuninori.morimoto.gx@renesas.com>, <robh+dt@kernel.org>,
 <lgirdwood@gmail.com>
Subject: [PATCH v4 14/23] ASoC: soc-core: Probe auxiliary component before
 others
Date: Sat, 27 Jun 2020 10:23:36 +0530
Message-ID: <1593233625-14961-15-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593233625-14961-1-git-send-email-spujar@nvidia.com>
References: <1593233625-14961-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1593233719; bh=kupu78+RlIzVp6swUHdt7ySzHcwXFYGpxZH6mlh5V08=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Type;
 b=ODeC6E/pm6bVQyWRVxz1At0w/yx8+MIF7i+jrqRFkq2WnVRWV6lPmZx0tn89UKOY+
 /4jE47M6aV81IX45h0fFvYKxX2p/hTik1PueRQZ5ywJlMg5Iy6ZgGBnzskMxrJ0R38
 RfSy0fbpnNILRMK5kC9v5JbIWaWtjPfeOtMB8ElKsjqeyaXXTa3rC/LKscMOBMWj80
 p8C2f5DrPr1k76GJNuoYOl4s+nPgPZ30ZE14egl7JSfKFImCk71pg5ny0uUIx41FQj
 xcXfv6V2sgZLlt+rrXRJ0roeynemEaBNXgWaliiutHM5JaeOtl1q0sYJ31EXSU9uHK
 11aqOCJFRpY4g==
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org, swarren@nvidia.com,
 Sameer Pujar <spujar@nvidia.com>, nwartikar@nvidia.com,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com, viswanathl@nvidia.com,
 sharadg@nvidia.com, thierry.reding@gmail.com, atalambedu@nvidia.com,
 linux-tegra@vger.kernel.org, digetx@gmail.com, rlokhande@nvidia.com,
 mkumard@nvidia.com, dramesh@nvidia.com
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

A router component can be added as an auxiliary device to the sound card
to help with audio routing across multiple components. DPCM dai links
use CPU<->Dummy or Dummy<->Codec style of links in simple-card driver and
hence do not have required DAI connections by default. Usually machine
driver can do the necessary mapping.

But if there is a crossbar switch HW which can connect multiple components,
it is expected to provide required user space configurability via MUX
controls. In such a case the crossbar can be represented as an independent
component and can be added as an auxiliary device. The exposed routing
interfaces can be used by other components in the system, thus probing it
first can avoid probe failures.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 sound/soc/soc-core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 8faca60..9041a03 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1850,19 +1850,19 @@ static int snd_soc_bind_card(struct snd_soc_card *card)
 	if (ret < 0)
 		goto probe_end;
 
-	/* probe all components used by DAI links on this card */
-	ret = soc_probe_link_components(card);
+	/* probe auxiliary components */
+	ret = soc_probe_aux_devices(card);
 	if (ret < 0) {
 		dev_err(card->dev,
-			"ASoC: failed to instantiate card %d\n", ret);
+			"ASoC: failed to probe aux component %d\n", ret);
 		goto probe_end;
 	}
 
-	/* probe auxiliary components */
-	ret = soc_probe_aux_devices(card);
+	/* probe all components used by DAI links on this card */
+	ret = soc_probe_link_components(card);
 	if (ret < 0) {
 		dev_err(card->dev,
-			"ASoC: failed to probe aux component %d\n", ret);
+			"ASoC: failed to instantiate card %d\n", ret);
 		goto probe_end;
 	}
 
-- 
2.7.4

