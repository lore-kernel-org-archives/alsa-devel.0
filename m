Return-Path: <SRS0=jYMw=PQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBE3C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Oct 2021 14:11:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 932F3610CA
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Oct 2021 14:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 932F3610CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0F09916D0;
	Thu, 28 Oct 2021 16:10:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0F09916D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635430292;
	bh=Bj+kN98RsIDGwGArNQuA8vu9uwNTfh0YG8iYcJoyato=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cukygGy7/kx4hPxoIJWA9ClUzccHAApJrWY0lcUhfZhbL+FjX3oxKwGn68GCuP1Hc
	 DzSH+QD7SZAVtDYhiLcfmHSZQg1l9AkwVsD71knUo2D6p6WYfp5o2/jmlgAAQCfXD1
	 rQjVJl2RIbUdAsli6pnZI7MGW4damxElltzOzB54=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C451F804E7;
	Thu, 28 Oct 2021 16:09:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1547CF804AE; Thu, 28 Oct 2021 16:09:24 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 63964F80269
 for <alsa-devel@alsa-project.org>; Thu, 28 Oct 2021 16:09:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 63964F80269
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="OGH4QM1c"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19S8422t008357; 
 Thu, 28 Oct 2021 09:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=X0O6MWyGZX3E7kGT3bHAMBl+YQRTxjhLQ/rRDFPMcio=;
 b=OGH4QM1coMENDOiOzPkOPncxVz8Ow37pOKueTq0haopFZZDpTA9Juas8X4/jj55lGaHv
 I0ce2Ox9x/foToNr4I5LPJ1r5W0rdoVoolzsNZL6+EIhocHNwtgcnZzmLzOb3si0KNmA
 kIeRwcpkJhBB24tH2kU+pEhSz90ZWvLpg5tBIA9y1NueEa8XCJTHHfsYkMsvRp4yFdUD
 D0d8rhee4rIRg6qR5nb8fDjQ7QN6QawLbZbeJ2+Xh/yTZJcS1SBZUsuNlIee+V6yvUnR
 W7USLuHl11R8RGoBDfc/SVkZxoZqGnR/3pIUePMyYZcHwgq4L/DlsVbrmeFt3cMvb/qr Dg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 3bya1wh98x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 28 Oct 2021 09:09:09 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 28 Oct
 2021 15:09:07 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Thu, 28 Oct 2021 15:09:07 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com
 [198.61.65.32])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 45C5211AF;
 Thu, 28 Oct 2021 14:09:06 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>
Subject: [PATCH 0/3] ASoC: cs42l42: Fix definition and handling of jack switch
 invert
Date: Thu, 28 Oct 2021 15:08:59 +0100
Message-ID: <20211028140902.11786-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: j12Yjou9t0SDfd7rHLrc4Vc2ZOvGrId8
X-Proofpoint-ORIG-GUID: j12Yjou9t0SDfd7rHLrc4Vc2ZOvGrId8
X-Proofpoint-Spam-Reason: safe
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Richard Fitzgerald <rf@opensource.cirrus.com>, linux-kernel@vger.kernel.org,
 patches@opensource.cirrus.com
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

Summary: The driver applied the opposite of the DT setting to the
wrong register bit.

The jack plug detect hardware in cs42l42 is somewhat confusing,
compounded by an unclear description in the datasheet. This is most
likely the reason that the driver implemented a DT property for the
wrong register bit, that had the opposite effect of what was
described in the binding.

Changing the meaning of the property values isn't feasible; the
driver dates from 2016 and the risk of breaking out-of-tree configs
is too high (the property is also available to ACPI systems).

So the fix is to make the binding doc match the actual behaviour and
then fix the driver to apply it to the correct register bit.

As a bonus, patch #3 converts the binding to yaml.

Richard Fitzgerald (3):
  ASoC: dt-bindings: cs42l42: Correct description of ts-inv
  ASoC: cs42l42: Correct configuring of switch inversion from ts-inv
  ASoC: dt-bindings: cs42l42: Convert binding to yaml

 .../devicetree/bindings/sound/cirrus,cs42l42.yaml  | 225 +++++++++++++++++++++
 .../devicetree/bindings/sound/cs42l42.txt          | 114 -----------
 MAINTAINERS                                        |   1 +
 sound/soc/codecs/cs42l42.c                         |   9 +-
 4 files changed, 230 insertions(+), 119 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,cs42l42.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/cs42l42.txt

-- 
2.11.0

