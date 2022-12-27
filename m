Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD08C10F1B
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Dec 2022 08:28:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 57EC17086;
	Tue, 27 Dec 2022 09:27:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 57EC17086
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1672129724;
	bh=zK6SB8PjBNzFTaE/BLXiypwAvRFZlXkv08jktiNmVyQ=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=s3JXBsWFMGPJoDXJ5aEnD2lKhWJ7exAw+c96hwlEAMgxtHd8TrXbvJWTM++s0mlqn
	 prHaOxY7MhSdO4rSdPM1LSZ257yDpiXboWSneE5vOSRy4fkJhM/7BJ+uu4RoN36mB4
	 Xf3yrdeLLD/06oH4bVxxrm0/Lwl8ww8xHXT5E5sA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EAEB0F800F0;
	Tue, 27 Dec 2022 09:27:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D25F7F804E7; Tue, 27 Dec 2022 09:27:51 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B09E9F804B4
 for <alsa-devel@alsa-project.org>; Tue, 27 Dec 2022 09:27:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B09E9F804B4
Authentication-Results: alsa1.perex.cz; dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=ti-com-17Q1 header.b=OxHXXt6Z
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BR8Rj5F019879;
 Tue, 27 Dec 2022 02:27:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1672129665;
 bh=W2jS52aaXKHKNZtM8BluGXp3l1JVDspx5b4whSMVk0k=;
 h=From:To:CC:Subject:Date;
 b=OxHXXt6ZwA8X1XOTCJRzmVKjZUQjQLUJ+DFVBMJ5zDKIkjDb3vRBDtlVXkZkCb5Js
 HS0lzj6IHlkZIDe2NcWxi1GBaojZ48cPprZ+H/aBL140jE6SqNxS325HWrYbK7hXMn
 tOoeOZLyPIBiiQ5w4i9neEWofEFCX8PIW6le42w8=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BR8RjRT100652
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 27 Dec 2022 02:27:45 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 27
 Dec 2022 02:27:44 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 27 Dec 2022 02:27:44 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BR8RiVj099504;
 Tue, 27 Dec 2022 02:27:44 -0600
From: Jai Luthra <j-luthra@ti.com>
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Subject: [PATCH v5 0/2] dt-bindings: sound: tlv320aic3x: Convert to dtschema
Date: Tue, 27 Dec 2022 13:57:15 +0530
Message-ID: <20221227082717.29561-1-j-luthra@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Jai Luthra <j-luthra@ti.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Convert bindings for TI's TLV320AIC3x audio codecs to dtschema.

v5:
Follow up commit with properties around clocks and port that were 
missing in original txt bindings

v4: https://lore.kernel.org/all/20221221145216.11400-1-j-luthra@ti.com/

Jai Luthra (2):
  dt-bindings: sound: tlv320aic3x: Convert to dtschema
  dt-bindings: sound: tlv320aic3x: Add optional clock and port
    properties

 .../bindings/sound/ti,tlv320aic3x.yaml        | 164 ++++++++++++++++++
 .../devicetree/bindings/sound/tlv320aic3x.txt |  97 -----------
 2 files changed, 164 insertions(+), 97 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,tlv320aic3x.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/tlv320aic3x.txt

-- 
2.17.1

