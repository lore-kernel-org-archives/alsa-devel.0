Return-Path: <SRS0=1Vby=4G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA48C34026
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:29:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A68420801
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iFBHXXxw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ghLMVHiV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A68420801
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A533A1690;
	Tue, 18 Feb 2020 18:28:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A533A1690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582046965;
	bh=XxAJ8dtuKn4gsK69/t4nqnMAcQvCYtbLYoZdhCvFHtE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iFBHXXxw0KLqEgwzqEC9kMrzQVNgHM518NoiIWoClbSkb3HVVDOxNmTmKQxtcbsUU
	 fcDQxZ2ruXVexZus1iTrKljzuvNamj+H40ucMUHJyOIc/9nlWJhZP78Mcpeizb3H2p
	 VKg3vBMU7wgUzAEgC5iLgZMIUos3YeSVlVM3gLTg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 98320F8027D;
	Tue, 18 Feb 2020 18:26:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C3C82F8015C; Tue, 18 Feb 2020 18:26:34 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 94BB3F80137
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2020 18:26:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 94BB3F80137
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ghLMVHiV"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01IHQPBe095293;
 Tue, 18 Feb 2020 11:26:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1582046785;
 bh=lvwXkYs8d80yE7BNnJ2oI2ay727RRz52IoOVRAsarhw=;
 h=From:To:CC:Subject:Date;
 b=ghLMVHiVkMzpMdZkJWxB53JeSi9Fc+l1fm0o7lZvV5SR/P8H5raaglOKnXChVJ4w4
 0julWR7da7m/RXgKrfTuNokFmjOtg05SJz9gjWklDNehR1uo8U0pG8+kfjH0gPbq3L
 ac+doOHhpFIXjdty+i5hDqPXm/kiIOq06tFkS+aI=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01IHQPPk065185;
 Tue, 18 Feb 2020 11:26:25 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 18
 Feb 2020 11:26:25 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 18 Feb 2020 11:26:25 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01IHQO72068505;
 Tue, 18 Feb 2020 11:26:25 -0600
From: Dan Murphy <dmurphy@ti.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>
Subject: [PATCH v2 0/2] INtroduce the TLV320ADCx140 codec family
Date: Tue, 18 Feb 2020 11:21:38 -0600
Message-ID: <20200218172140.23740-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Dan Murphy <dmurphy@ti.com>
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

Hello

Introducing the Texas Instruments TLV320ADCx140 quad channel audio ADC.
This device supports 4 analog inputs, 8 digital inputs or a combination of
analog and digital microphones.

TLV320ADC3140 - http://www.ti.com/lit/gpn/tlv320adc3140
TLV320ADC5140 - http://www.ti.com/lit/gpn/tlv320adc5140
TLV320ADC6140 - http://www.ti.com/lit/gpn/tlv320adc6140

Dan Murphy (2):
  dt-bindings: sound: Add TLV320ADCx140 dt bindings
  ASoC: tlv320adcx140: Add the tlv320adcx140 codec driver family

 .../bindings/sound/tlv320adcx140.yaml         |  83 ++
 sound/soc/codecs/Kconfig                      |   9 +
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/tlv320adcx140.c              | 851 ++++++++++++++++++
 sound/soc/codecs/tlv320adcx140.h              | 130 +++
 5 files changed, 1075 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
 create mode 100644 sound/soc/codecs/tlv320adcx140.c
 create mode 100644 sound/soc/codecs/tlv320adcx140.h

-- 
2.25.0

