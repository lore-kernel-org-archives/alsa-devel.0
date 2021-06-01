Return-Path: <SRS0=jKKe=K3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F64AC47080
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 01:55:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5F861263
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 01:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5F861263
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D8C315F9;
	Tue,  1 Jun 2021 03:54:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D8C315F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622512540;
	bh=W1oc6szqrmsNhYAa9a5qy0yFuvb5IcJHSTRRpvjXiuU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MpazgS51gt3pxxVlHa+i4PFPKjghVCF6CsXD5fM0ZJ2+cmIKjOKhVVDc1G0aWiIUw
	 dIEiMYN8udqNtpvXJ09l3hN6pFH02g8OA61y1dozdz6hF8ksJvo8j5Lkv7z3plizZ6
	 K1UK1pldooek0jffqbihwa2X34Hw/wcMOx0tV4fs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 148A0F801DB;
	Tue,  1 Jun 2021 03:54:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DBC90F80254; Tue,  1 Jun 2021 03:54:47 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E8D23F800B2
 for <alsa-devel@alsa-project.org>; Tue,  1 Jun 2021 03:54:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8D23F800B2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="CeZ+EItl"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 1511pvCS010293; Mon, 31 May 2021 20:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=EmBI1KT6nO97aEH2N0T8X6uiH63fhH2zq1PDYtzVodM=;
 b=CeZ+EItlLePD/U1m1FY2rfPV7F+KEo/iLL5mRqN4EBJN5xCFwxDJEM92z9F3+nvQ7e9c
 uAZQ3AwcxDmdf4qwxaex8YCcG+6kn4vDydiljy4Jvfimpz2QrlsQAzt/JVd0FPgZdzxJ
 THFBeROI08PMT632XoXxQ0nxHjyZq2gUNKykcgW2t1AaOi5fVABCAUWm2NTizIYT6e8l
 CkRJP40BWMNnH07rcrPpJTWczMICCsRnTCOGXjPi6hC21jsN/c3Tx7D79fgEz0s7/kUE
 x0ahrcFrI0Ik+gxNVRRLNEX/nEQRwBFgOn51NeIDXhOEZJ2c3FYZ7nvdMg2QFurd9Cj1 QQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 38vv1h0qh3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 31 May 2021 20:54:42 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 1 Jun 2021
 02:39:37 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 1 Jun 2021 02:39:37 +0100
Received: from localhost.localdomain (unknown [141.131.77.13])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E096F2B2;
 Tue,  1 Jun 2021 01:39:23 +0000 (UTC)
From: David Rhodes <drhodes@opensource.cirrus.com>
To: <broonie@kernel.org>, <ckeepax@opensource.cirrus.com>,
 <brian.austin@cirrus.com>, <patches@opensource.cirrus.com>,
 <alsa-devel@alsa-project.org>, <david.rhodes@cirrus.com>
Subject: [PATCH 0/2] Cirrus Logic CS35L41 Amplifier
Date: Mon, 31 May 2021 20:37:29 -0500
Message-ID: <20210601013731.2744163-1-drhodes@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3QFWfjIq24nKMxnVkZE3dqlPEvS3a8hG
X-Proofpoint-GUID: 3QFWfjIq24nKMxnVkZE3dqlPEvS3a8hG
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106010010
Cc: David Rhodes <drhodes@opensource.cirrus.com>
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

ASoC driver and devicetree documentation for a new
Cirrus Logic amplifier CS35L41

David Rhodes (2):
  ASoC: cs35l41: CS35L41 Boosted Smart Amplifier
  ASoC: cs35l41: Add bindings for CS35L41

 .../devicetree/bindings/sound/cs35l41.yaml    |  395 ++++
 include/sound/cs35l41.h                       |   83 +
 sound/soc/codecs/Kconfig                      |   12 +
 sound/soc/codecs/Makefile                     |    4 +
 sound/soc/codecs/cs35l41-i2c.c                |  126 ++
 sound/soc/codecs/cs35l41-spi.c                |  148 ++
 sound/soc/codecs/cs35l41-tables.c             |  688 +++++++
 sound/soc/codecs/cs35l41.c                    | 1758 +++++++++++++++++
 sound/soc/codecs/cs35l41.h                    |  755 +++++++
 9 files changed, 3969 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cs35l41.yaml
 create mode 100644 include/sound/cs35l41.h
 create mode 100644 sound/soc/codecs/cs35l41-i2c.c
 create mode 100644 sound/soc/codecs/cs35l41-spi.c
 create mode 100644 sound/soc/codecs/cs35l41-tables.c
 create mode 100644 sound/soc/codecs/cs35l41.c
 create mode 100644 sound/soc/codecs/cs35l41.h

-- 
2.25.1

