Return-Path: <SRS0=ofM/=CT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CF0C43461
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 12:42:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C78E220BED
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 12:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aKOyEvQl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MpjF/hY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78E220BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 265E2169A;
	Thu, 10 Sep 2020 14:41:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 265E2169A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599741733;
	bh=6uU4AW5MOfmavuIzx4PXFHBVnfwAascoIo1uMCymayk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aKOyEvQlrixH/0TxXiVlq/ZlCaGMf8izHfnS95c74D13JrPi3fmuiYf9b2CPlY+px
	 SSgjkdqA8kTWWI6OF86zt6YRqVNxZx5q6JRQirnv09kLJFej6+qLaqHEoKjT4eq1T/
	 RUphsjKr6Xsjs88YCbrmKslDrYs/4X+wKct0Z0/8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B3B39F801F2;
	Thu, 10 Sep 2020 14:41:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D8E9DF800E9; Thu, 10 Sep 2020 14:41:21 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D6BA4F800E9
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2020 14:41:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D6BA4F800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MpjF/hY5"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08ACfCwS058807;
 Thu, 10 Sep 2020 07:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1599741672;
 bh=nzSal+6OsgkooGCpPLASc7epDcU1mtLH8VlEHBjVaT8=;
 h=From:To:CC:Subject:Date;
 b=MpjF/hY5RgChDuhPz9O/wrU1Kx4vX3NTzEeomiYjFGa3td1TCtayAwYoe9xzlbaLK
 onqR/5WfhDnPO8CHgx9tthWm4xTBtvMEd3Ks8ZnTqSXSglfUginB4d9IBtPzMi9WP6
 5OewJXzxDCmCwHndy78yYAsLljHats6tzGQlWD8M=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08ACfC8f006482;
 Thu, 10 Sep 2020 07:41:12 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 10
 Sep 2020 07:41:12 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 10 Sep 2020 07:41:12 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08ACfAGM024223;
 Thu, 10 Sep 2020 07:41:10 -0500
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>
Subject: [PATCH v2 0/2] ASoC: ti: j721e-evm: Support for j7200 variant
Date: Thu, 10 Sep 2020 15:41:08 +0300
Message-ID: <20200910124110.19361-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

Hi,

Changes since v1:
- Suffix the 2359296000 constant with 'u' to silence C90 warning

When j7200 SOM is connected to the CPB, the audio setup is a bit different:
Only 48KHz family have clock path, 44.1KHz is not supported.

Update the binding documentation and add support for the j7200 version of CPB
to the driver.

Regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: dt-bindings: ti,j721e-cpb-audio: Document support for j7200-cpb
  ASoC: ti: j721e-evm: Add support for j7200-cpb audio

 .../bindings/sound/ti,j721e-cpb-audio.yaml    | 92 ++++++++++++++-----
 sound/soc/ti/j721e-evm.c                      | 11 +++
 2 files changed, 81 insertions(+), 22 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

