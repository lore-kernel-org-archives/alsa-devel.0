Return-Path: <SRS0=adxF=2N=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4F1C2D0C0
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Dec 2019 09:34:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C999D20709
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Dec 2019 09:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FNiSDpob";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="PK0yd5bM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aTsSFP2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C999D20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F0F71674;
	Mon, 23 Dec 2019 10:34:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F0F71674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1577093691;
	bh=CwFPeRimQ7t3Bv58GMD9i2/R+7qw15uchSH0X/04HY4=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FNiSDpoboPMzdUl13c7her2NGkLd3OG+Xj2T1KI9QgOuDJEPspcu41SQBdYRUw8S6
	 uXY5zbHnScEHqR7Q771MDlpxtLxKEI92Nhg9fnKaeqyvep+IVvegEH/VyG/fVz9/pR
	 rFnhu5s4NJmZRHZVNwEL0k9ktbhR/zuGVzZwlm8w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AD873F8012F;
	Mon, 23 Dec 2019 10:34:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7A215F80130; Mon, 23 Dec 2019 10:33:59 +0100 (CET)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B5B80F80087
 for <alsa-devel@alsa-project.org>; Mon, 23 Dec 2019 10:33:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5B80F80087
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="PK0yd5bM"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="aTsSFP2k"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id 0C8A7418;
 Mon, 23 Dec 2019 04:33:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Mon, 23 Dec 2019 04:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm3; bh=xPta1XNidzF35p51P4vuWxHsOt
 8PxiI4r2lRRbJpcTg=; b=PK0yd5bMy0rnGEf+SK2Cd3+fIQ5czAfySAmceaHPPz
 4ZQ/cFWcOfxHy84k+LGiNnYoLz1GvsVFqPSjelUS+mo1F3RzSB1UzoohGfDZWXcL
 8CczF9R5SUyt6RkowTEiXGNGfh8DH7qOXvGE3zhd7vprfzv9g1hdR07awcjIcLJJ
 rE9vQODGjKqOO4feNdfivvSEyAHEyq7oN0lfhY9ViWVAMeQQGdA0uWxvZ5fqJ3Bz
 +rna/v5LAmrheCG7konhAvMUvUTMPtZzZ5TDwA3bGbi1yx2WPtsb3YgP3AqFCMpC
 ty0dD4ic0Shr9WfqH2MXrmoxiYbr/d7EJKtkMR3og62w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=xPta1XNidzF35p51P
 4vuWxHsOt8PxiI4r2lRRbJpcTg=; b=aTsSFP2kL51h/WC+qLYZkM+yoqqXlxOYs
 EftxEOJiLbUr/hiAc9n5ow5XmqP1m/hVxvlhngg0TSoGqWRYe6FFBScPCjKx2jcl
 uh7OFcHO8Gu/X09TgkPry3MKZ5B4pZSol+VtcPZuhO6Gk82PmybH10dAqMEzz9qW
 lJLK9lbdisreFvNKRzvQfjOKs2zIeFIY19SGoWXtN0yngFGLXR8SD14l4iGxLgoA
 gNcoQgymSZ/uVofnRxh42HDTrO4Pbdx6x7nWz4U1VUo2Y5kE33befK7RnzRRF3Q1
 GKNh3aEJBRQvxOEBBX4oU8SLbEd/I2szcStNSet9/RQMpPMiQ2TOg==
X-ME-Sender: <xms:_4kAXmjuGUmTfb9_5cpH_VoZ43OxUs6vRafh4kq0gm90ubLFQ0YVvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddvtddgtdehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
 dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
 ihesshgrkhgrmhhotggthhhirdhjpheqnecukfhppedugedrfedrjeehrddukedunecurf
 grrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdr
 jhhpnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:_4kAXqjX3cocU6O2ux-rMrcrcs6LuXLeaTf5oY5Qt0zcRnHQ0t6TJQ>
 <xmx:_4kAXmlpJ_W6lKe7DYygl_IKrxcXavLE7w8ZJkvhBS-2hPDSyxZCZg>
 <xmx:_4kAXiHUQtO4b07YL_7Gp_pL8T8qLzafuSyPCGDEG7dQDjobADPAnA>
 <xmx:_4kAXhKt2AkWPgva47sN9ObsGtfhWedL9D-JlkfyW-GXOHkEqQJJEA>
Received: from workstation.flets-east.jp (ae075181.dynamic.ppp.asahi-net.or.jp
 [14.3.75.181])
 by mail.messagingengine.com (Postfix) with ESMTPA id 6E51580062;
 Mon, 23 Dec 2019 04:33:50 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Date: Mon, 23 Dec 2019 18:33:47 +0900
Message-Id: <20191223093347.15279-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH] ALSA: ctl: allow TLV read operation for
	callback type of element in locked case
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

A design of ALSA control core allows applications to execute three
operations for TLV feature; read, write and command. Furthermore, it
allows driver developers to process the operations by two ways; allocated
array or callback function. In the former, read operation is just allowed,
thus developers uses the latter when device driver supports variety of
models or the target model is expected to dynamically change information
stored in TLV container.

The core also allows applications to lock any element so that the other
applications can't perform write operation to the element for element
value and TLV information. When the element is locked, write and command
operation for TLV information are prohibited as well as element value.
Any read operation should be allowed in the case.

At present, when an element has callback function for TLV information,
TLV read operation returns EPERM if the element is locked. On the
other hand, the read operation is success when an element has allocated
array for TLV information. In both cases, read operation is success for
element value expectedly.

This commit fixes the bug. This change can be backported to v4.14
kernel or later.
---
 sound/core/control.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 3fa1171dc1c2..49f3428dfacb 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1398,8 +1398,9 @@ static int call_tlv_handler(struct snd_ctl_file *file, int op_flag,
 	if (kctl->tlv.c == NULL)
 		return -ENXIO;
 
-	/* When locked, this is unavailable. */
-	if (vd->owner != NULL && vd->owner != file)
+	// Write and command operations are not allowed for locked element.
+	if (op_flag != SNDRV_CTL_TLV_OP_READ &&
+	    vd->owner != NULL && vd->owner != file)
 		return -EPERM;
 
 	return kctl->tlv.c(kctl, op_flag, size, buf);
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
