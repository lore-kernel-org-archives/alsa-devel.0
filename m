Return-Path: <SRS0=30sX=ZH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E17FC432C3
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Nov 2019 09:59:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E78312073B
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Nov 2019 09:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="U4zihm8j";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Mt63OvVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78312073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 218CC1668;
	Fri, 15 Nov 2019 10:58:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 218CC1668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573811988;
	bh=6wMzRISlM6XMsqSXmbbffGJLBiPW9ZmVb2TxI3DPjps=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U4zihm8ji2x8p4wJkLiuTlL2Q0XarZnRXf6Zz7xrbuTfjPhlk3WFyh7h6fmZAMkFZ
	 SCTfdn2IGWq1TqRDdMuUu37Tpy1gKhLvXWBAoP2zl+CZDGj6fNkVdkPTOtpRrkMq8y
	 4ctLsmf4CQxIiIqS/OPvTxvVvsJC0uFWEfBnahbE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8F94CF80117;
	Fri, 15 Nov 2019 10:56:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0BB89F8010B; Fri, 15 Nov 2019 10:56:42 +0100 (CET)
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 96658F8010B
 for <alsa-devel@alsa-project.org>; Fri, 15 Nov 2019 10:56:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 96658F8010B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="Mt63OvVQ"
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5dce76580000>; Fri, 15 Nov 2019 01:56:40 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Fri, 15 Nov 2019 01:56:37 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Fri, 15 Nov 2019 01:56:37 -0800
Received: from nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com (172.20.187.13)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3;
 Fri, 15 Nov 2019 09:56:35 +0000
From: Nikhil Mahale <nmahale@nvidia.com>
To: <tiwai@suse.com>
Date: Fri, 15 Nov 2019 15:26:04 +0530
Message-ID: <20191115095606.22392-4-nmahale@nvidia.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191115095606.22392-1-nmahale@nvidia.com>
References: <20191115095606.22392-1-nmahale@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1573811800; bh=GFJTuhDHEyTAZF3QHNTG4tgZYvzDWCHGtTtKHGG8hLo=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 X-Originating-IP:X-ClientProxiedBy:Content-Type;
 b=Mt63OvVQi03YPoXLTCD8xakxF0bWoi7kTuPQJTnF6NOMHpbFFs99lEpEOJhpdWfPJ
 pM58oa24yyYTYd1Wl4RztWOlWbG99r2QTL2UsGCw1HKfwGhVJdg+ZCv44dTJvp5qc1
 YFx4u0Ll7C/reXbMmd8MJaS5ATfLOIE/sT5tzlVMWXRzmatFUEyblKNRvgAOf2UvMe
 i/CIfMcnAeSlDddR8DKWTj7NQQay0B7fWZSoE2oO5qB/gjyV8agCzHI9EgD5U2h5j5
 QWPu+PWDOruT2KzDpse/ufTmgK9pdkLAcjz85y/1f9qZlCsndMbFabqncVwsCEJceg
 crAoraZmmd1mw==
Cc: alsa-devel@alsa-project.org, nmahale@nvidia.com, aplattner@nvidia.com
Subject: [alsa-devel] [PATCH v2 3/5] ALSA: hda - Add DP-MST conn list support
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Document change notification HDA040-A for the Intel High Definition
Audio 1.0a specification introduces a Device Select verb for Digital
Display Pin Widgets that are multi-stream capable. This verb selects
a Device Entry that is used by subsequent Pin Widget verbs,
including the Get Connection List Entry verb.

This patch queries the current Device Select value, associates it
with the connection list, and updates the connection list management
code to consider dev_id along with nid.

Signed-off-by: Nikhil Mahale <nmahale@nvidia.com>
Reviewed-by: Aaron Plattner <aplattner@nvidia.com>
---
 sound/pci/hda/hda_codec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index a2fb19129219..8f32cab8f4a4 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -88,6 +88,7 @@ struct hda_conn_list {
 	struct list_head list;
 	int len;
 	hda_nid_t nid;
+	int dev_id;
 	hda_nid_t conns[0];
 };
 
@@ -96,8 +97,9 @@ static struct hda_conn_list *
 lookup_conn_list(struct hda_codec *codec, hda_nid_t nid)
 {
 	struct hda_conn_list *p;
+	int dev_id = snd_hda_get_dev_select(codec, nid);
 	list_for_each_entry(p, &codec->conn_list, list) {
-		if (p->nid == nid)
+		if (p->nid == nid && p->dev_id == dev_id)
 			return p;
 	}
 	return NULL;
@@ -113,6 +115,7 @@ static int add_conn_list(struct hda_codec *codec, hda_nid_t nid, int len,
 		return -ENOMEM;
 	p->len = len;
 	p->nid = nid;
+	p->dev_id = snd_hda_get_dev_select(codec, nid);
 	memcpy(p->conns, list, len * sizeof(hda_nid_t));
 	list_add(&p->list, &codec->conn_list);
 	return 0;
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
