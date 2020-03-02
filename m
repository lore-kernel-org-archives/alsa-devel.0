Return-Path: <SRS0=GfuB=4T=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F326DC3F2CD
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Mar 2020 20:59:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C27021D56
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Mar 2020 20:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mhQlz48y";
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kH7GkTLA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C27021D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 67944167D;
	Mon,  2 Mar 2020 21:58:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 67944167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583182772;
	bh=NOFNvOIwaCDf0Kk0VHX8QzQ9XnYQxpRxcW6PVwwftmU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mhQlz48yglmuTqbVW9vwsFDkspgGV+edUtxj87wi5NT4ElQxmPsgfOyZDBTueHXYC
	 ITxvQmIKVy2CPbhw8Leb1zZ98AwYwuo+W3tSaOwhZ0xlXmGIb5+jbF31RclpO5gMsP
	 xg5mWSvnMeIYDJN54AJWWzl+xY4Lp1xJMVT7VSVw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 896ADF80229;
	Mon,  2 Mar 2020 21:57:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E06FFF801F9; Mon,  2 Mar 2020 21:57:45 +0100 (CET)
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50062.outbound.protection.outlook.com [40.107.5.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 95D1FF80130
 for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2020 21:57:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 95D1FF80130
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.b="kH7GkTLA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekqtjVewMFrRlkHGe+CPUP5whEzhenk9iGiZeGfHgS8Gwl9eSZfqYJlQGbPBH99eCYyVwbRzdGrfNT6fDtqj7BKDiqEgVKlPXwxFbIqREVUhjlyFvVAPDOzNsZU8Eu2NdtMYx4NsX7htcwZaUvuZAIAhn3qelGdSbVmEe90YcN6UkjOHNZdtChslCwGIkLB7X/e1pCwz+yUDAoZnLPBuOxbXOV8I19nG8FAPujfM7Y0q6ioRPRLBmVeDtOrlrrQFiZYGjxzIbm3zay7gNgnYBAGi8IKlVtBIg0FIz/Hkd9ILI+zpUO7UMJ+lm2ntqLuvSCrDrhL/m0ET5jHPM+nBCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwW0WkLK7AMbPdbcN/MPMhAV7X0xRa9rgVZuqxdNv4c=;
 b=JOFFLpYfynEN6DOYbytnBrsq1sUpi4SHuIuKa2n9m4Q7AZZod0GrwMndP5phi1vla8MIA8pHQJ0RGreuNe5DC38JrO097a/34MFJvlzS8v9MKCSzQA5SyZXTl/ehEWddfPZ28/W5IFgBw3fDIslwi11ZLFIS3YbuM6buHsiA7duUpINXnnQ/fcuu/YwQMaUZ+QiqeAYOwJvgwvh7dJd5zYALb9aGtRslLe8E41z9v3HJe4rnIS3XYGEPcKbSWTdflLJTsILMJbv2R1Po0JUJmqftc0V7LqRPcPfqA6RJ1XDMgPhFD59RVK0CRA4G5RUUFTA/22IczbmlpXYUU7r20g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwW0WkLK7AMbPdbcN/MPMhAV7X0xRa9rgVZuqxdNv4c=;
 b=kH7GkTLAiiqqX3GPytDj6tG+nEh838Q0ZA9x3fUBmzxKUHjcZ6WqDOEbgXKBqNNALTQd3KUb6WHMz1Hw8s9i9g7HIfpZtRomrhHQZcGrnV2/LoUM91LLCWER23SfKV0Dw5pas4EW0yPKVr19aWVQ/UPKs+nNlEks6GXgT13jfCU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@oss.nxp.com; 
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com (52.134.16.147) by
 VI1PR0402MB3453.eurprd04.prod.outlook.com (52.134.3.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Mon, 2 Mar 2020 20:57:36 +0000
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::35d0:31bc:91d9:ceb0]) by VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::35d0:31bc:91d9:ceb0%7]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 20:57:36 +0000
From: Daniel Baluta <daniel.baluta@oss.nxp.com>
To: rjw@rjwysocki.net,
	len.brown@intel.com,
	pavel@ucw.cz
Subject: [RFC PATCH 0/2] Introduce multi PM domains helpers
Date: Mon,  2 Mar 2020 22:56:58 +0200
Message-Id: <20200302205700.29746-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0031.eurprd05.prod.outlook.com (2603:10a6:205::44)
 To VI1PR0402MB3839.eurprd04.prod.outlook.com
 (2603:10a6:803:21::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-103.ro-buh02.nxp.com (89.37.124.34) by
 AM4PR05CA0031.eurprd05.prod.outlook.com (2603:10a6:205::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Mon, 2 Mar 2020 20:57:34 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6ab0dde7-917b-48cd-b118-08d7beec5636
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3453:|VI1PR0402MB3453:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3453AED7CF12DDDE9DFCD42DB8E70@VI1PR0402MB3453.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(2906002)(26005)(6486002)(4326008)(6506007)(5660300002)(186003)(16526019)(478600001)(7416002)(6666004)(1076003)(2616005)(66946007)(66556008)(66476007)(44832011)(8936002)(4744005)(8676002)(86362001)(81166006)(81156014)(6512007)(52116002)(956004)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3453;
 H:VI1PR0402MB3839.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:0; MX:1; 
Received-SPF: None (protection.outlook.com: oss.nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fn8ap5iZRidIEqf7abUkOuBDrwdeI/q2QYHPSy1ZVx6oCAafg2N2wBGTIZAFa5syO/5wy8Z+zYNIgRaGFBpmFVe80HsjakIXlO4hcIA7fHMj1j7Ca+QG4pfDZEzyx/ZnOytwG+nrCnv44qqvkog9qEYtD6OGyAKkRwrqMUnOiBMRpe+zoIkHOJIzg7W+QvOy71+At90H6vSuyvLUYmUPpxPo8KlsRbvqoQw2bcVg1RdV6zrIhgUW9oEesR2/2FSvZMaev1cdQ7uoVpCVZwBVYWFPH5wdiR99+TVOpIcpy0lSA7M4LNs7oBjdI8ByhbambvgzUd12fTpYhPURfEM99jpX9JzVCECOwq78FUFQildN+zwfLFZmI+P6kQrX/MELUSyqTKGfGLVzdmTFDnsKxdewHeQ76PG6BrsLQz3NHckXk+4o5rYwREIxmwLu/V5r
X-MS-Exchange-AntiSpam-MessageData: tdrkMUdFeQq2dWfsHMaXYlh070IfB+/WHhT+wjjbdqXKUhPmZqIvwh9bYwbr8TYoiEfU1YLm2uyvoFEcREcDVN+Tr3ASSX9V4Vpw78BboyK0bTp9jYBvR26nCMvJOLps4ReIxwosy5LtXHEXjFPVww==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab0dde7-917b-48cd-b118-08d7beec5636
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 20:57:36.7356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fp3s6thvPf2NYNYaj8ew7Iuu2D0J4xgpQAwkwauBU21JHoCOL237z/II6WZzWGT496XpeCWnZGNxE8O+MB0Fvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3453
Cc: aisheng.dong@nxp.com, daniel.baluta@gmail.com, ulf.hansson@linaro.org,
 festevam@gmail.com, alsa-devel@alsa-project.org, linux-pm@vger.kernel.org,
 gregkh@linuxfoundation.org, s.hauer@pengutronix.de, khilman@kernel.org,
 ranjani.sridharan@linux.intel.com, linux-kernel@vger.kernel.org,
 Daniel Baluta <daniel.baluta@nxp.com>, pierre-louis.bossart@linux.intel.com,
 paul.olaru@nxp.com, linux-imx@nxp.com, kernel@pengutronix.de,
 shawnguo@kernel.org, shengjiu.wang@nxp.com,
 linux-arm-kernel@lists.infradead.org
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

From: Daniel Baluta <daniel.baluta@nxp.com>

i.MX8QXP/i.MX8QM has IPs that need multiple power domains to be up
in order to work. In order to help drivers, we introduce multi PM
domains helpers that are able to activate/deactivate multi PM domains.

First patch introduces the helpers and second patch demonstrates how
a driver can use them instead of hardcoding the PM domains handling.

Daniel Baluta (2):
  PM / domains: Introduce multi PM domains helpers
  ASoC: SOF: Use multi PM domains helpers

 drivers/base/power/common.c | 93 +++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   | 19 ++++++++
 sound/soc/sof/imx/imx8.c    | 54 +++------------------
 3 files changed, 118 insertions(+), 48 deletions(-)

-- 
2.17.1

