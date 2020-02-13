Return-Path: <SRS0=t/pq=4B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140F6C2BA83
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Feb 2020 06:38:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9262F217F4
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Feb 2020 06:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FgCdjenz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="FrRY45uz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ciM6GQug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9262F217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2973C1683;
	Thu, 13 Feb 2020 07:37:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2973C1683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581575912;
	bh=lfOUMycBbARse1OmWIa1eHXVl6RcQMAD+ZVpcxzVHs0=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FgCdjenz4f9ZN/k/zwemAE+Tn26343HIHOPWHldOw3YcnkJQA2b78s4KvqbV/7J5b
	 UmTXmrjerm5CqRbAL0VtvXYazbitdc3r5TDqWcaC4YX2nqHCPr1bHb71EQuf4ELbxy
	 eplK9QFsXU5JHktcX31hFD8RWCd9vl6I8gMotRUE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E6421F80278;
	Thu, 13 Feb 2020 07:36:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9286EF80218; Thu, 13 Feb 2020 07:11:57 +0100 (CET)
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com
 [66.111.4.221])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A566AF80138
 for <alsa-devel@alsa-project.org>; Thu, 13 Feb 2020 07:11:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A566AF80138
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="FrRY45uz"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="ciM6GQug"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.nyi.internal (Postfix) with ESMTP id F2A215397;
 Thu, 13 Feb 2020 01:11:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Thu, 13 Feb 2020 01:11:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=RIhl9ui4MUMvU
 Z3Loqtrzp+BStII7YZIIhAd8D98BR8=; b=FrRY45uza9QIuvD5w+dJpQeXqiaCE
 c7bfRtWec5BqDXWDuANN1aSRBkpbHpHDJZKhM1Flzqs5uBjN2Q0SJ9WNRdkFc41Y
 udUV+f/RJhMESZsCQHfUcU5/uTi6IbdBtdmcesSn01yed2mGgyYWR9Ixd9kFxrPG
 85pgkcZbQi4CuByjj5Vk3CHigylPmknw0aRch5d4K+jIBiZbp6nPDPSd4C3b++Il
 M/oSnqrVjVXjaf1jVWJ3RoZ+GKefTBmD+zv9/kS3MgbL0/HbprW+v/zgFbiWdKIv
 c+l3xmS8oeA9Y1j4iFYBgu4d2D1F3c3o9hYP3VAQ02CtDg3nTj+OBIQ3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=RIhl9ui4MUMvUZ3Loqtrzp+BStII7YZIIhAd8D98BR8=; b=ciM6GQug
 Iw0C7/qrmPtYFYeogOGkOV+LKE3UJfNnEt1Uf388Y2HrIJMW6+SaksdhcaSWZff8
 pNt1cOsuMoHdBICa47pJIqRHTnMVRTLtexGKXoqkhJx9cy31Gr1KvE445cdsim+H
 g8bVRCZyZERGBoiKMkpeVhdWjfLayrkXOBtEgG/B49mrYg0YQdIVVsXrw6HffNFB
 Ux9xdwfwRrXZmuMj7bKQWSc6J1Mby9v4DW7F56kV3VClafRjgxtx2EWomunJ27U0
 Sa6olSwdregwsItpviPrCd65uvl8akNKQ5TF8QEzFI73UWeHUhtK8IePGm6CPZ9X
 HnJDMV1yS4LGtQ==
X-ME-Sender: <xms:pehEXn4FgcqQV0QB2W75WmQRxBAjFFyio8WwtXUKnJR9vY-r5Hb0rA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrieejgdelhecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
 ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
 ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
 mhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:pehEXqG_tkvVnAlLW0wt6CgoCmUugWiJDHEnxRaYpbfFENSenBvs1A>
 <xmx:pehEXnCLaUgA2hBbPTjHKfpT_TV_WKMxoNjt3EZvgAb4u-aJkDxtrw>
 <xmx:pehEXnycsg15BGcKBJuRm_5AwxKWgNZ7D9_cIAelNFC-0d-zPUnTZA>
 <xmx:pehEXrF1pHEbmaet6mDBhsM37nEGOeXFFOdUuWC75nAHjOZfiOiV0A>
Received: from titanium.stl.sholland.net
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA id 114593280067;
 Thu, 13 Feb 2020 01:11:49 -0500 (EST)
From: Samuel Holland <samuel@sholland.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 13 Feb 2020 00:11:44 -0600
Message-Id: <20200213061147.29386-2-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213061147.29386-1-samuel@sholland.org>
References: <20200213061147.29386-1-samuel@sholland.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 13 Feb 2020 07:36:42 +0100
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Samuel Holland <samuel@sholland.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [alsa-devel] [PATCH 1/4] ASoC: codec2codec: avoid
	invalid/double-free of pcm runtime
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

The PCM runtime was freed during PMU in the case that the event hook
encountered an error. However, it is also unconditionally freed during
PMD. Avoid a double-free by dropping the call to kfree in the PMU hook.

Fixes: a72706ed8208 ("ASoC: codec2codec: remove ephemeral variables")
Cc: stable@vger.kernel.org
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/soc-dapm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b6378f025836..935b5375ecc5 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3888,9 +3888,6 @@ snd_soc_dai_link_event_pre_pmu(struct snd_soc_dapm_widget *w,
 	runtime->rate = params_rate(params);
 
 out:
-	if (ret < 0)
-		kfree(runtime);
-
 	kfree(params);
 	return ret;
 }
-- 
2.24.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
