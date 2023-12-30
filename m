Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681D9C46CD2
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Jan 2024 19:09:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6491DEA1;
	Tue,  2 Jan 2024 20:08:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6491DEA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1704222549;
	bh=frcCV1k9oG9oKj3dpUqdJg1PxRT2RSN/XKdLCPjaYaY=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=MZSpbNaGYGQbt5S/NBhsDBSjunaVUhNNH+Tlt3OAFkVM0I0Deh5mYjg3CgPVFCnLB
	 wFTod4H/DQ69fLFUMu3WzL/eT+YipV1TAlX/EUC7RRbbdqltahVe5lJgvbe6XIxmQ7
	 w+UZz8Lnkl8bePbdSnzNadPwDS4HFhhfCLdIMdm8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A42B0F806B5; Tue,  2 Jan 2024 20:06:59 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D4B45F806BE;
	Tue,  2 Jan 2024 20:06:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3F0B1F80051; Tue,  2 Jan 2024 20:04:08 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 26262F80654
	for <alsa-devel@alsa-project.org>; Tue,  2 Jan 2024 19:59:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26262F80654
Authentication-Results: alsa1.perex.cz;
	dkim=fail reason="signature verification failed" (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=ti-com-17Q1 header.b=gOHXLzpD
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BUAoIqC129102;
	Sat, 30 Dec 2023 04:50:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1703933418;
	bh=iy2zWH+NW3lElFVQhzfYk0FwXztRp5REtkmqB+gJFeA=;
	h=From:To:CC:Subject:Date;
	b=gOHXLzpDU0dZUT2IGhDa7SRdJPKrput5eo3pggLrdqIYi1KihmGRk4AE/6aHgnCxT
	 Vd2R6EKoEvXYp2F1RRXhDHvL58gChoy+V1995Wx79hOCa/b0tXhgoVSlCqFvdG+A/g
	 Ut0JKP3eRxQ0Sx92duT7NoFkkfZTyb1JyebHT/0U=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BUAoIIk017577
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 30 Dec 2023 04:50:18 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 30
 Dec 2023 04:50:18 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 30 Dec 2023 04:50:18 -0600
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.161.227])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BUAoCRg036817;
	Sat, 30 Dec 2023 04:50:12 -0600
From: Shenghao Ding <shenghao-ding@ti.com>
To: <broonie@kernel.org>
CC: <andriy.shevchenko@linux.intel.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <pierre-louis.bossart@linux.intel.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <mengdong.lin@intel.com>, <yung-chuan.liao@linux.intel.com>,
        <baojun.xu@ti.com>, <kevin-lu@ti.com>, <peeyush@ti.com>,
        <navada@ti.com>, <tiwai@suse.de>, Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v4] ASoc: tas2783: Add tas2783 codec driver
Date: Sat, 30 Dec 2023 18:50:07 +0800
Message-ID: <20231230105008.997-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Message-ID-Hash: 4X53UGHY2OC4CY37SRQZQWZISORPRJBI
X-Message-ID-Hash: 4X53UGHY2OC4CY37SRQZQWZISORPRJBI
X-MailFrom: shenghao-ding@ti.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4X53UGHY2OC4CY37SRQZQWZISORPRJBI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


