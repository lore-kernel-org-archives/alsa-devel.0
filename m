Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C485EC43334
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jun 2022 14:13:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DC1641658;
	Mon, 27 Jun 2022 16:12:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DC1641658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656339180;
	bh=AzBC7pd/aCo11D/WlhyqitMPym8Cg5Oj/Pzfk7BGbRE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UtEQtZUKX4lRkAKiufTAPYzxmBj283pQGDh+1tct8yTTLd1klf62FW+BG9U6w9K7n
	 jP7x5WnuEszzfP3L1WQdGu78f0o2eJl9tjj8FnkHxLLI2PWqziItgw4+vO75+omiTc
	 w4U2F9E8RCDvoSpCA2GUUB3tfDvo0KzKBXrU0h+Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 62CD1F8028D;
	Mon, 27 Jun 2022 16:12:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7E6A9F8028D; Mon, 27 Jun 2022 16:12:08 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E9261F800E9
 for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2022 16:12:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E9261F800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="XRoISmmB"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RCn06H027978;
 Mon, 27 Jun 2022 09:12:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=kKHbTQVbRij3BjfskU5kHjjPsm8UzILiriN2/NeS3tw=;
 b=XRoISmmBHi7eUskptbmw4mr1Cn01vxEOvcqMYh08Tgjjj1b0+XUsbLqxBZ5LCzB15lKa
 UA+NxJaHZ9Hcws5JevDSe3S7bd+2DRaihHEzG1SgnbtqahszBpY+Your9j3JbBqNsBfk
 sgJfeJpA68cOlDY4n1D4+YUjUcHeiz/GCpNcr8vz3OhylWCLsf+8fG0pGny59363wWRR
 rzCvEb4NjvYVxPaEaA3m5jleQV/tTJRMGJ9+fU9N5PrEtGSRlXFvEsooEnenYpjgQeqI
 c9yt7vWmBroJkH1DQQnTmr0vRcUC6a1nRsnAXiCyH02wswhkO1vUmVeYvCDbdsfUy/Dl 7w== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3gwxsq2qjm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 27 Jun 2022 09:12:03 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 27 Jun
 2022 15:12:02 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Mon, 27 Jun 2022 15:12:02 +0100
Received: from sbinding-cirrus-dsktp.ad.cirrus.com (unknown [198.90.238.163])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 31B4F2A1;
 Mon, 27 Jun 2022 14:12:01 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v2 0/2] Read _SUB from ACPI to be able to identify firmware
Date: Mon, 27 Jun 2022 15:11:46 +0100
Message-ID: <20220627141148.804319-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: yEnf3Se5JcKdyp-XF1hPLQQKIteU4Zts
X-Proofpoint-ORIG-GUID: yEnf3Se5JcKdyp-XF1hPLQQKIteU4Zts
X-Proofpoint-Spam-Reason: safe
Cc: linux-acpi@vger.kernel.org, alsa-devel@alsa-project.org,
 Stefan Binding <sbinding@opensource.cirrus.com>, linux-kernel@vger.kernel.org,
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

CS35L41 has a DSP which is able to run firmware, as well as a tuning file.
Different systems may want to use different firmwares and tuning files, and
some firmwares/tunings may not be compatible with other systems.
To allow a system to select the correct fimware/tuning, we can read an _SUB
from the ACPI. This _SUB can then be used to uniquely identify the system
in the firmware/tuning file name.

Add a helper function which reads the _SUB, so this can be used by other
parts in the future.
Add support inside the CS35L41 ASoC driver to read this _SUB, and save it
appropriately.

Changes since v1:
- Add length validation for SSID String
- Rename API
- Allocate memory inside API
- Use ACPI_HANDLE macro instead of ACPI_COMPANION
- Improve error handling

Stefan Binding (2):
  ACPI: utils: Add api to read _SUB from ACPI
  ASoC: cs35l41: Read System Name from ACPI _SUB to identify firmware

 drivers/acpi/utils.c       | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h       |  6 ++++++
 sound/soc/codecs/cs35l41.c | 24 ++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

-- 
2.25.1

