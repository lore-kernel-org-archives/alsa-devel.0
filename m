Return-Path: <SRS0=xC/7=BZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7A0C433DF
	for <alsa-devel@archiver.kernel.org>; Sat, 15 Aug 2020 17:28:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4908C23B18
	for <alsa-devel@archiver.kernel.org>; Sat, 15 Aug 2020 17:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jvcaa8C3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rKZwlywy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4908C23B18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B98141669;
	Sat, 15 Aug 2020 19:27:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B98141669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597512513;
	bh=hGEQZYwWX03FLQSBuI/6fZCnHFDZCBH6wwAupx1/Zcs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jvcaa8C3vlaVHwK/nd04m+0tcwY8dgcUEuyl0/DtVkW88f/94Ucy2cP7SSA4nTs3I
	 5LyC9MnKeS65qZRIbgCMDuH974Mk3ZrONVL1oziHL6VPMTgSoehOcHXCdFYQdO3qVi
	 51+Vcl8oWT9K3sbatCt9siZ/a7Meapv+Bn8OPcBw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 64D91F8014C;
	Sat, 15 Aug 2020 19:27:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D05D5F8015B; Sat, 15 Aug 2020 19:27:41 +0200 (CEST)
Received: from wforward2-smtp.messagingengine.com
 (wforward2-smtp.messagingengine.com [64.147.123.31])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6DCB9F8014B
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2020 19:27:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6DCB9F8014B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="rKZwlywy"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailforward.west.internal (Postfix) with ESMTP id 31CDDB71;
 Sat, 15 Aug 2020 13:27:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Sat, 15 Aug 2020 13:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=3/hiaFgACK4IVUAKU
 bBTtH14+C6yuBKEXpauIKDrVMM=; b=rKZwlywySamHRyfAIFyrPAfUmckpW6GX4
 gBQJieeispNye/BrjWQc7Lp05BrdmfxC/sLo0pAeWUq2Qw4t8+BmOdaVlItnWB1O
 HocGPG8ZKrIPXiZ1fRMA/Pxmx+5zIUv5GYQPNYFAWo17rPVhlIolhrFN3d5gm1tq
 y650lEWGWtbsZti8OLNxEITr5oMMC2JY7eLNqV0FywLbKAWOXREJAIlaH8Jc0qOW
 lV872ZKE23OD3MQ/qWW5F6xppmh9TZRaBCf+KD7514KunkPeONzCxmhqNdEM10sU
 C/3pJviXIuu3m2RYEjfeMieC3htHJpN20eUb1YrU54gt4CXFu3nIQ==
X-ME-Sender: <xms:Ahs4X_AAUdLiIuX-3yHvhu7rxgME3LxsCPYsB4k2hWXTg967E0eUHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrleelgdduudefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvrghnuhcumfgr
 shhkihhnvghnuceothgrnhhukhesihhkihdrfhhiqeenucggtffrrghtthgvrhhnpeffue
 eugeegvddtudeludehledvkefftddtgeejheehvdefudeiffekgfeiteettdenucffohhm
 rghinheprghlshgrqdhprhhojhgvtghtrdhorhhgnecukfhppedukeekrdduvdeirdekle
 drgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeht
 rghnuhhksehikhhirdhfih
X-ME-Proxy: <xmx:Ahs4X1gii5hLsO50urGxuLb2CjGWfSA4_9SxmEMGT_MANuQQ2uadEA>
 <xmx:Ahs4X6kHmeSbR8ZJnJ3yJTw8NeUhV-5KE4ZvTD54F4IDEpVceIVzMg>
 <xmx:Ahs4XxyFubRlxy9DU6FI5EonRdoIQKYfMJw0dHsJjUUN-gHRpoBC4Q>
 <xmx:Ahs4X7eZBis7q3Q4xXylMWW17LPr1-HIubbG7YsRW_zuBRQqkJ1WBkTWnM8>
Received: from localhost.localdomain (unknown [188.126.89.4])
 by mail.messagingengine.com (Postfix) with ESMTPA id 9238A306005F;
 Sat, 15 Aug 2020 13:27:28 -0400 (EDT)
From: Tanu Kaskinen <tanuk@iki.fi>
To: alsa-devel@alsa-project.org
Subject: [PATCH alsa-lib] README: add patch submission instructions
Date: Sat, 15 Aug 2020 20:26:49 +0300
Message-Id: <20200815172649.38845-1-tanuk@iki.fi>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>
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

---
 README.md | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/README.md b/README.md
index 3cd122d5..57fd353e 100644
--- a/README.md
+++ b/README.md
@@ -12,3 +12,14 @@ http://www.alsa-project.org/alsa-doc/alsa-lib/
 
 You may give a look for more information about the ALSA project to URL
 http://www.alsa-project.org.
+
+### Submitting patches
+
+The preferred way to submit patches is by sending them by email to the
+alsa-devel mailing list. Sending mail to the list requires subscription,
+subscribe here: https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
+
+Add Takashi Iwai `<tiwai@suse.de>` and/or Jaroslav Kysela `<perex@perex.cz>' to
+Cc so that your patch won't be missed.
+
+Patches are also accepted as GitHub pull requests.
-- 
2.20.1

