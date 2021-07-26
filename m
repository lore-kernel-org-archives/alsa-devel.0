Return-Path: <SRS0=yf6i=MS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603EFC4338F
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Jul 2021 18:06:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85E4060F6F
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Jul 2021 18:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 85E4060F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1EB4817F4;
	Mon, 26 Jul 2021 20:05:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1EB4817F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627322782;
	bh=U3VfDo+wyD+RQRLTxKce2aoJT2G/Z/ndmBP+AC4i/20=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PIw5XBNcdZ8EJ41k3Y/G+zDJ6T40ZE3kY4AI4ubtn5cJIJB/ZrBRoosM+hT1G1x7F
	 jOWkn8auzXCnbm0JwqKXyfGNSSj5ZwPCsyy9UaFOlTzHjruVIMq5enf7rKzGZ3SBDR
	 y1+hjGTkzqnwZcK+68egLki0dF3MxleTOBd+R/3s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D54CF8020D;
	Mon, 26 Jul 2021 20:03:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D4874F804E2; Mon, 26 Jul 2021 20:03:18 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF5F8F8051F
 for <alsa-devel@alsa-project.org>; Mon, 26 Jul 2021 20:03:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF5F8F8051F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="QDeg7PzV"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16Q2DYd4012545; 
 Mon, 26 Jul 2021 13:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=tNrhaPpR6nfFieh25/I+8/sUvK3EZY5OkEhMJNElmzU=;
 b=QDeg7PzVutBz00Vmp1uqU4cOHtbgJBGJtfsGH0QxWfO8d+lbCvvnMl6TZph+qRoO56x2
 +DJd1lxoJAMleUegOy+6H6Z8QZDkHLLH4qsuN0gaV49U6v4Ir9HtfWeX01c1xoqlIcIV
 3qeeg5+YLFSWoyZFr+cMEc5GGt/7UMFL+6TwsCwWH1KRD5+xTwLc0xDqGS87EXo6iOTd
 sYYCUq9qT+T4oEMg04LhPbxoWXQeT039X1TeYRT8td2bEg4x/ycUUQ9MLb/N4pKWwf87
 7RcDZLcC+7J6gfnlapdcX3dhOgfewNZRoy/jb6zqd/85j1hVvc+DzYuuZZD4JBywakEU BQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 3a17cvhhav-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 26 Jul 2021 13:03:08 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 26 Jul
 2021 18:47:04 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 26 Jul 2021 18:47:04 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.32])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2B8722BA;
 Mon, 26 Jul 2021 17:47:03 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 08/27] ALSA: hda/cs8409: Disable unsolicited response for the
 first boot
Date: Mon, 26 Jul 2021 18:46:21 +0100
Message-ID: <20210726174640.6390-9-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726174640.6390-1-vitalyr@opensource.cirrus.com>
References: <20210726174640.6390-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: RB7QhXYeFCX02K3vlXO2Mp_VPfWOWUSE
X-Proofpoint-ORIG-GUID: RB7QhXYeFCX02K3vlXO2Mp_VPfWOWUSE
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260105
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Lucas Tanure <tanureal@opensource.cirrus.com>
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

From: Lucas Tanure <tanureal@opensource.cirrus.com>

The subsequence suspend and remuse have their enable/disable
unsolicited responses at the correct place already

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/patch_cs8409.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index 4906d2913603..2ed07ab3f47e 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -621,9 +621,6 @@ static void cs8409_cs42l42_hw_init(struct hda_codec *codec)
 		for (; seq_bullseye->nid; seq_bullseye++)
 			cs8409_vendor_coef_set(codec, seq_bullseye->cir, seq_bullseye->coeff);
 
-	/* Disable Unsolicited Response during boot */
-	cs8409_enable_ur(codec, 0);
-
 	/* Reset CS42L42 */
 	cs8409_cs42l42_reset(codec);
 
@@ -795,6 +792,8 @@ void cs8409_cs42l42_fixups(struct hda_codec *codec, const struct hda_fixup *fix,
 					      HDA_INPUT, 0, 0xff, 0x19);
 		snd_hda_gen_add_kctl(&spec->gen, NULL, &cs8409_cs42l42_hp_volume_mixer);
 		snd_hda_gen_add_kctl(&spec->gen, NULL, &cs8409_cs42l42_amic_volume_mixer);
+		/* Disable Unsolicited Response during boot */
+		cs8409_enable_ur(codec, 0);
 		cs8409_cs42l42_hw_init(codec);
 		snd_hda_codec_set_name(codec, "CS8409/CS42L42");
 		break;
-- 
2.25.1

