Return-Path: <SRS0=8+EQ=IJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC1EC433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Mar 2021 05:27:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42FAB64FC9
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Mar 2021 05:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FAB64FC9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A199C1703;
	Thu, 11 Mar 2021 06:26:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A199C1703
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615440429;
	bh=/w4VIcxS8vrH/sSZvqN9w6UZmSo6kozRlXSNQzzU+CE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tTlokddvljsuiTosK/Rm5kdbTePVCGfHswt17LEpX9AvqAlbenCi+KMHKlUdFtgAR
	 M6FZ0xYSTDRv2YS03p9JeC5lo2nVvDtSeRaQvPZd0/BSP7Sm+1NkVm2oHIrC7pzEnC
	 x+0Ud2nqdaqL8EYcnAMWZn+aooDF8HUz0YA27vkc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6A160F804F2;
	Thu, 11 Mar 2021 06:22:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EDD1CF8032B; Thu, 11 Mar 2021 06:22:38 +0100 (CET)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com
 [64.147.123.21])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 115D9F8032B
 for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2021 06:22:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 115D9F8032B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="kUGb0xSD"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="IW2k6GJt"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 61A782F88;
 Thu, 11 Mar 2021 00:22:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Thu, 11 Mar 2021 00:22:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=J9guudtb6Eogk
 0WZpXeQnCskSuocbkmRpzRjcLI3Lik=; b=kUGb0xSDsDAvFejFzREd1yiltyLhU
 UEtwSAUeXUHce0dkVpLQ+xLJo6EoI+h5c2FAZuf8P5tGVUcdL1YWQ8QNt2HeMGa1
 6VC+5M2fE+IKqKVFdpPj+WV+bleOrZ8e/w6/DjkSxeBXrg5DBpJStQOoGQFp6AgO
 HnpdupZMQuGupXNXDgnbuYoeRXeGo8lYl8ugcqxherZKK0vAa0QE4UHX6DSCcymZ
 t1sB4xcKVuPAlBu9HypuQ5r5SYsSaxLPW47eUqm740yD0OSexceO0cbibzcJpG8C
 V5YorGCB3xnICpXZK+12Fg26xZgMBw48g/zUuENhCZOx3LUCij7+lQd5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=J9guudtb6Eogk0WZpXeQnCskSuocbkmRpzRjcLI3Lik=; b=IW2k6GJt
 M+JyUT5KA9vUYhIjPLI93tpMjgh7qBn9dmzMvHiNCNBesWNCUWXQRWwewBM+/E0k
 mFKEwUwsN3EjRHv3phsBCYBAtZVqHcPimPtsz4kMapXyAniJq7NLhq/g6OyQTqYN
 tHUCVI/WnywhYnvAenIHVIldvOnAuWCoDStwgWDIeh6pUweoeztW3pWXs0URM007
 xzRE4ooWf6tLTIN5amaSqHgRO1QoFXPXun7TODDrh+XdoBIksCWj/BpRXYkVZwh9
 mrAPWccEamk3Cgm/lCcYu7y8SijBX1ql2zyjEquV7hAo9SGy48sQA7je+amhX/ZE
 2BTP+IPFLEwKHw==
X-ME-Sender: <xms:AKlJYCnpqzx5l-IyF7okKDKgGi-_h24AifzUNXOs8w6IWVxwUXf0Tw>
 <xme:AKlJYJ04bxA0ZfFJAIqGqQYPRJ-H_l6NGjRpm9wOWCzs5_JubToNzPdgbb5FBSHBb
 pFrkcJzfz1qC-GIMeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudduledgkedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
 shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
 etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecukfhppedugedr
 fedrieehrddujeehnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilh
 hfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:AKlJYAqBVDqrisquQGIEyFeJhBP0Nr_rpli2cZ5n4X43rtO6e9KpeA>
 <xmx:AKlJYGlZBagmqzQ5vQl1wTF8Wj3ukAn0Prk4gnuybNUR8Saxt2FA4A>
 <xmx:AKlJYA0sqw9eEb4tgG5kV-DiJCSqWjY_4ogN6B4JKHVciZCE1V7QxA>
 <xmx:AKlJYF_1yAUToTK_A7d4ZPDgPncL08Q25698b_w9MN7ewaO-KcFYzA>
Received: from workstation.flets-east.jp (ae065175.dynamic.ppp.asahi-net.or.jp
 [14.3.65.175])
 by mail.messagingengine.com (Postfix) with ESMTPA id F3CB5240057;
 Thu, 11 Mar 2021 00:22:06 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de,
	perex@perex.cz
Subject: [alsa-utils][PATCH 12/14] axfer: test: reduce test case for maximum
 number of frame count
Date: Thu, 11 Mar 2021 14:21:43 +0900
Message-Id: <20210311052146.404003-13-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210311052146.404003-1-o-takashi@sakamocchi.jp>
References: <20210311052146.404003-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org
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

This commit reduces test case for maximum number of frame count so that
overall time is shortened. The count of total iteration is still the same.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/test/container-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/axfer/test/container-test.c b/axfer/test/container-test.c
index 4e2dcc2..788507b 100644
--- a/axfer/test/container-test.c
+++ b/axfer/test/container-test.c
@@ -300,7 +300,7 @@ int main(int argc, const char *argv[])
 	for (i = begin; i < end; ++i) {
 		err = generator_context_init(&gen, access_mask,
 					     sample_format_masks[i],
-					     1, 128, 23, 4500, 1024,
+					     1, 128, 23, 3000, 512,
 					     sizeof(struct container_trial));
 		if (err >= 0) {
 			trial = gen.private_data;
-- 
2.27.0

