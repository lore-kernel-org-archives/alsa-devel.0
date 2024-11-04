Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96516D132A2
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Nov 2024 10:01:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 12A35857;
	Mon,  4 Nov 2024 11:01:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 12A35857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1730714505;
	bh=f1WAT5GznHOznsY4+nfCpE5qHc2VaaKObHI4tYurF1k=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ftqC3W/o7BBf8s4C+/KvhCFEW7ZD7aiKDQGYmkLID45qcmnGgfJqrVEEGJU0Bmdi3
	 gWGPnFU+puJMT27VPyp7mCF1YhP+NeyerrlzfdvmwNLWlgpVqm/ZJkYWrBnXaMtwy7
	 Q5yTUPHDFPYCMFHChMOj3/TxqfUMDt8TYyR6EGIg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 434F3F8058C; Mon,  4 Nov 2024 11:01:22 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CB390F80587;
	Mon,  4 Nov 2024 11:01:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2CAC0F8026A; Mon,  4 Nov 2024 11:01:12 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B3E82F8014C
	for <alsa-devel@alsa-project.org>; Mon,  4 Nov 2024 11:01:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B3E82F8014C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=ti-com-17Q1 header.b=mhHEKlid
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A4A13s1124531;
	Mon, 4 Nov 2024 04:01:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730714463;
	bh=VBIC/sZ0pblJPttXUyrh9GSaEySJML5Y8Qv1tloCis4=;
	h=From:To:CC:Subject:Date;
	b=mhHEKlidrL4upkPqDsBApPUAXY4u0tNM3WfEtBuZSpk1XC5ER+l0XppfbxLPDNOVG
	 0cgZpySi72rHGk757XWX5JwAGojl9x6VIMus2G+mxIOeCQKPSeNVjBrHUW0MjmfUe4
	 5UW8P9C+ucVwOQqXNI0f1uH5x+pQfQrL1rrUyUvY=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A4A13ed097286;
	Mon, 4 Nov 2024 04:01:03 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Nov 2024 04:01:03 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Nov 2024 04:01:03 -0600
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.162.164])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A4A0wvT080525;
	Mon, 4 Nov 2024 04:00:59 -0600
From: Shenghao Ding <shenghao-ding@ti.com>
To: <broonie@kernel.org>
CC: <andriy.shevchenko@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <13916275206@139.com>,
        <alsa-devel@alsa-project.org>, <tiwai@suse.de>, <baojun.xu@ti.com>,
        <Baojun.Xu@fpt.com>, <navada@ti.com>, <flaviopr@microsoft.com>,
        <v-hampiholi@ti.com>, Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v1] ASoC: tas2781: Add new driver version for tas2563 &
 tas2781 qfn chip
Date: Mon, 4 Nov 2024 18:00:55 +0800
Message-ID: <20241104100055.48-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
Message-ID-Hash: BKLPFWHIJZWPLIRGSXWESIBX5PTRAHTO
X-Message-ID-Hash: BKLPFWHIJZWPLIRGSXWESIBX5PTRAHTO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BKLPFWHIJZWPLIRGSXWESIBX5PTRAHTO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add new driver version to support tas2563 & tas2781 qfn chip

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
---
 sound/soc/codecs/tas2781-fmwlib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tas2781-fmwlib.c b/sound/soc/codecs/tas2781-fmwlib.c
index ae360c97fe1e..0aeb88abbf52 100644
--- a/sound/soc/codecs/tas2781-fmwlib.c
+++ b/sound/soc/codecs/tas2781-fmwlib.c
@@ -1992,6 +1992,7 @@ static int tasdevice_dspfw_ready(const struct firmware *fmw,
 		break;
 	case 0x202:
 	case 0x400:
+	case 0x401:
 		tas_priv->fw_parse_variable_header =
 			fw_parse_variable_header_git;
 		tas_priv->fw_parse_program_data =
-- 
2.34.1

