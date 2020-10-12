Return-Path: <SRS0=KIty=DT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530FAC2D0A1
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Oct 2020 14:20:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 864F42087E
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Oct 2020 14:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="E2VzC7yv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aeOapAa8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 864F42087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9C1911681;
	Mon, 12 Oct 2020 16:19:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9C1911681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602512427;
	bh=3ulG6U2sw9bZhlzrRm51TWflIWae4pvw9z+rp09VqJs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=E2VzC7yvBPt8XKmrDXWLlJWsttmHVUoYc29IFNEY/wgdryTJNEpLKgbCbT0UTgBht
	 qkBT8W1q9k83tdNrDyrT9yRCXhtzcpm6KDLBc1yngKyDraeN+rdROK4PRPYLlhVDOa
	 VFnvkPwTxyQq+uIAad2+73mpua/cskFwBh+0A0eA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 35B47F8020D;
	Mon, 12 Oct 2020 16:19:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9C13AF80217; Mon, 12 Oct 2020 16:19:35 +0200 (CEST)
Received: from esa3.microchip.iphmx.com (esa3.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 21138F800D8
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2020 16:19:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 21138F800D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.b="aeOapAa8"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1602512370; x=1634048370;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=3ulG6U2sw9bZhlzrRm51TWflIWae4pvw9z+rp09VqJs=;
 b=aeOapAa8VrnuSSAh5uqDbCT+Dqzit4BwUp9CpYfjlruspYVWLLrRZzQl
 sSbaxc11bNf3xI3CxwUaaYAv37zb7gP5jgUlgc531gbiugH8mKBFNqkmA
 tZzmJ/cUArP+HH7kNw6DD6zcgEprDlf6ZFe5uhp0L7F1j81ZS7Le5tvxO
 y9q+Dx+N2tDIgWAxLIC3PlT3aKzIgfxPqBfce7jIS8b+YdyEQ3Kuxm6dD
 tCFGjA52pnt44uJzzsVhlp9PewOuU9t+Zk3+Aoku6rMVXWS6+G/4eNWi7
 2tpuhhw3pA2TnbcqLMQ4m2qcddqskRnxGSg4j9tMnLK1SVwVdldeAW6JO w==;
IronPort-SDR: Rskd0N6eBXq3JGNtMY8g5/EBEivDeHBx9G8ELiv0ZE6I7LXTbKm4nZyau2x+WK7wAbh67R/X2B
 l2PwWpMhgLHrijNuKJNfGuZScnHIr5TnJW0OAirWBCo4Zd7pxT4xwW33VxNcOO0VcH8ol6jQpm
 LyeDyO9etjLRZAZzf9mVaGDIDINQXa0qkUv3EdD/d8Ri36gq0pzRrzZlcgWR0WTXKzFhFfsRFM
 Y263uk+1wkFt0MzRa0Ow8ZUHtFZ8Pc7pOFzXY5RK1mTTsL42QOoy5SrNUHKh/DbYp4lxvi+f9U
 LKw=
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; d="scan'208";a="95020754"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256;
 12 Oct 2020 07:19:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 12 Oct 2020 07:19:25 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 12 Oct 2020 07:19:20 -0700
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To: <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: pcm5102a: Make codec selectable
Date: Mon, 12 Oct 2020 17:19:11 +0300
Message-ID: <20201012141911.3150996-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Cc: tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org,
 florian.meier@koalo.de, kernel@martin.sperl.org,
 Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
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

The TI PCM5102A codec driver can be used with the generic sound card
drivers, so it should be selectable. For example, with the addition
of #sound-dai-cells = <0> property in DT, it can be used with simple/graph
card drivers.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 34c6dd04b85a..5791b7056af6 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1003,7 +1003,7 @@ config SND_SOC_PCM3168A_SPI
 	select REGMAP_SPI
 
 config SND_SOC_PCM5102A
-	tristate
+	tristate "Texas Instruments PCM5102A CODEC"
 
 config SND_SOC_PCM512x
 	tristate
-- 
2.25.1

