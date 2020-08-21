Return-Path: <SRS0=Ooul=B7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CD7C433E1
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 07:35:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 470062078D
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 07:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UZi4J4no";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="GW+E40S7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oo1CzkwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470062078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C2BF3846;
	Fri, 21 Aug 2020 09:34:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C2BF3846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597995346;
	bh=DXaP1tpGX1zKV+YxWs4LTpnx3JDNKUF7BR1fuoD633o=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UZi4J4noCgkBTUvRJUhvAvYA7X2Hav5ngl51K2eC71EqMV8lXy/EdB40BQrt5TqtU
	 Fk3r6ixskjGq9D4W1hHmMfE4294hecKRpBMPLdXrqEmw1mygUhTflnzKu2t0jkU9bi
	 /ffWCqZLz+sIQezo86m6rhAL4FVo+62M7yLsuS+s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ACD9FF802FF;
	Fri, 21 Aug 2020 09:31:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6D412F8025A; Fri, 21 Aug 2020 09:31:41 +0200 (CEST)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 68A44F80253
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2020 09:31:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68A44F80253
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="GW+E40S7"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="oo1CzkwM"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.west.internal (Postfix) with ESMTP id 590ED310;
 Fri, 21 Aug 2020 03:31:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Fri, 21 Aug 2020 03:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=/XqfIqyu18uSn
 jcHyC2m9YLXcfLh7soh6af9AtUQNBo=; b=GW+E40S7AYviY+khl9tkkW6U/POe6
 s7Y8Bn4ZjnGZb783QcfiFtyQs1NXXwcuwlsbJm9Hj3Mkst3CHdNFypP8MvHbD8I9
 ZXPBJNWMoDdo1yDtPlFirHPabMfVOPBOsHQwBIrJ+RGLIkf6XFGLR2PCMg3P6b3T
 SJaGIvonUu5Wc8jDFcW8CPdEWOBnBRKWGoZHPJWCERT6QeFXQTxVJN28ewUcj3gv
 OKc69Pmpm1JdoW+eRwbnfQ5PhET7GI7R5iH2QwjnNK3tuNXN3a3zh+lR1Xi1kF2j
 H+LTjFz/rzIdyr3BSHidfLlTwzBkIqYn62FrRk3LoD2DsiHl3ZKiBr8Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=/XqfIqyu18uSnjcHyC2m9YLXcfLh7soh6af9AtUQNBo=; b=oo1CzkwM
 EbdFzUcSf2urR1K4WB8epIV7QVU8tEUh/39hASdKh3INQtPGvowbPrw/Ip6+MV54
 /468h8g/5D6lHUvC06QsLXV9JLs/Hh9gmWuyICwVIG41IZ7k5HxTMSYEOf9Slsjr
 KwJ/PK+7+tSy8lWMfOUgWscWIR2B46+dMG4iWwiIp++muVdb4Ji5mW6oTduZsWjx
 FWDqnsFQYfhotiece5diB1wPU+5oyXNp2b7ifFUbaXxHMwjAUcJuNfHbFRTbT1Df
 w5DaufgKMZO/wpeJevHPj5v+uARnIQoc6OiidPd26HQ5l5iYtnXWyB8LO5vL/TNv
 OT4X2hL1ceQimg==
X-ME-Sender: <xms:S3g_Xz877RGaYIOk1SptUe4Yb1pf6EHzsAH1SgDAMtlWAiOmeD0riQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudduuddgudduudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
 ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
 rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevfefffe
 ektefgveegfeelheffhfeujedtjeevtefhkeevkedtjeejvddtjefhjeenucfkphepudek
 tddrvdefhedrfedrheegnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
 hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:S3g_X_vvRk2LY7ymcrRbpXaElZPsYZ71kcPEQ_O10BzQyDNZV6jh2A>
 <xmx:S3g_XxAIlH9wIKbHKJXKCwHctUqKWF-KYISiBWaFIIUV3GRiE4nOBw>
 <xmx:S3g_X_c66eR5dsWQcntiqaY3jEs32gN7_yfB9KAs7hqJgxzo6bloNw>
 <xmx:S3g_Xy0OumcRQHpCYznf7-IMUPy5SbUIgU8GixBTBL-lAu0OY-Ii4w>
Received: from workstation.flets-east.jp (ad003054.dynamic.ppp.asahi-net.or.jp
 [180.235.3.54])
 by mail.messagingengine.com (Postfix) with ESMTPA id A171530600DC;
 Fri, 21 Aug 2020 03:31:22 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de,
	perex@perex.cz
Subject: [PATCH 05/25] efw-downloader: efw-proto: add class virtual method to
 handle responded signal
Date: Fri, 21 Aug 2020 16:30:51 +0900
Message-Id: <20200821073111.134857-6-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821073111.134857-1-o-takashi@sakamocchi.jp>
References: <20200821073111.134857-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: ffado-devel@lists.sourceforge.net, alsa-devel@alsa-project.org,
 clemens@ladisch.de
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

GObject allows applications to override class virtual method with own
method implementation in inheritance.

This commit adds the class virtual method to handle 'responded' signal
added in the former commit.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 efw-downloader/src/efw-proto.c |  2 +-
 efw-downloader/src/efw-proto.h | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/efw-downloader/src/efw-proto.c b/efw-downloader/src/efw-proto.c
index 6502957..72b7655 100644
--- a/efw-downloader/src/efw-proto.c
+++ b/efw-downloader/src/efw-proto.c
@@ -60,7 +60,7 @@ static void efw_proto_class_init(EfwProtoClass *klass)
         g_signal_new("responded",
             G_OBJECT_CLASS_TYPE(klass),
             G_SIGNAL_RUN_LAST,
-            0,
+            G_STRUCT_OFFSET(EfwProtoClass, responded),
             NULL, NULL,
             efw_proto_sigs_marshal_VOID__ENUM_UINT_UINT_UINT_POINTER_UINT,
             G_TYPE_NONE,
diff --git a/efw-downloader/src/efw-proto.h b/efw-downloader/src/efw-proto.h
index fbd4366..fdbcbc8 100644
--- a/efw-downloader/src/efw-proto.h
+++ b/efw-downloader/src/efw-proto.h
@@ -34,6 +34,24 @@ struct _EfwProto {
 
 struct _EfwProtoClass {
     HinawaFwRespClass parent_class;
+
+    /**
+     * EfwProtoClass::responded:
+     * @self: A #EfwProto.
+     * @status: One of #HinawaSndEfwStatus.
+     * @seqnum: The sequence number of response.
+     * @category: The value of category field in the response.
+     * @command: The value of command field in the response.
+     * @frame: (array length=frame_size)(element-type guint32): The array with elements for
+     *         quadlet data of response for Echo Fireworks protocol.
+     * @frame_size: The number of elements of the array.
+     *
+     * When the unit transfers asynchronous packet as response for Fireworks protocol, and the
+     * process successfully reads the content of response from ALSA Fireworks driver, the
+     * #EfwProto::responded signal handler is called with parameters of the response.
+     */
+    void (*responded)(EfwProto *self, HinawaSndEfwStatus status, guint seqnum,
+                      guint category, guint command, const guint32 *frame, guint frame_size);
 };
 
 EfwProto *efw_proto_new();
-- 
2.25.1

