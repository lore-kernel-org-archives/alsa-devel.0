Return-Path: <SRS0=XQZd=IK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58139C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 09:43:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F72064FE2
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 09:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F72064FE2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A1EFA16E1;
	Fri, 12 Mar 2021 10:34:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A1EFA16E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615541728;
	bh=SyxNwqnSg76J7Ve9Mkb9te8LAGkXqTqD6z4Kb6fk1sk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PAunwVzfUqDuV5+UjQx4lLn0z2inbXLQsEybDxylfeeOBOycm3s4hhYAwxk8VFn+j
	 SrREmi8DSAmE39DIqWNiY+NxS8FTVZR/0Rw13YaZT9xMkqRGrxC1ZutKU3jT0C+RuA
	 IUcgQ7h/gTdBD6yAlgJcTgsFvc33wAyo54iqOktg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 23622F8016C;
	Fri, 12 Mar 2021 10:34:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8E57CF801D8; Fri, 12 Mar 2021 10:34:35 +0100 (CET)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7F5FBF800BF
 for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2021 10:34:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7F5FBF800BF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="u501xOcE"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="XetWkQi1"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id BA55118AD;
 Fri, 12 Mar 2021 04:34:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Fri, 12 Mar 2021 04:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=vwRKwAmpvTdtGnmYiNdeCL/mi0
 xGimvcUnHRyBB0y2c=; b=u501xOcENHpDqt8YcEEA48mlyqns2cuGVwjR3hSVLl
 4DgSmAZC9PxtzA/AjU9bEom1vFD0p3hpaYq6FVrnv44uOo6nbP5YBxVf4fzzKO36
 zH8w0P3eg2fEDpaEsckNvcKOvEkw+cbZhBHJK0twZB8se6bRscn7ZwF4Y+FcaOgm
 sUzWY+BW084nlc20IsLivNhllzdBrese/i5N1VqQOBUp4En+/9ABB1kpOLiN5dnB
 XYDFch0cxUKnSvX3lbyA76IIFilDwrau/45RgR/2S5+MM0/w8d/a93IWxLKC9gfM
 bVrqaU8CK13cNFgXHhzBBjeQxfnPZFWFny3O1grDVnbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=vwRKwAmpvTdtGnmYi
 NdeCL/mi0xGimvcUnHRyBB0y2c=; b=XetWkQi1AgTVBxsIdm0KcBpUBBl0cZwQL
 31r1rfDxFgOjE4Lf5nmxX5UTXWZbPqdWFEwUya+ho87A7T1oyvu2uJlzyhHPUlrV
 26++ko6mLXOEk561laELyLEAgyyEpKIq8kMcerKvvbvUFVZCjs7YgjoMsHr521Dh
 Lx3sSOd/FgVXFw/ISSzLU8pMCmxzRFotDkF7eL4TCUHQIsLJN5pUgwkz3spdAOpU
 4h1NH4FPdAW8RlrWli4+EFGCpLXm0EVxgGLfoRwuaEUniTvBeHFCRnEtgTIZH9xt
 65YuAeuNc80hI4PPhzQO30y7Rl+aL0d0m7ArwDgo/LYfUviMQHW7w==
X-ME-Sender: <xms:lDVLYFw9Jk_GV2O7pLbI8-7JI75mv6hsBVrh6pmBU69w4AEPvfHvSw>
 <xme:lDVLYFNJrs_IeSF5eOSrMwWtXfayK0IF8pciDqC-mXCYzccYOw8Q2h0njt2fcYgG8
 clFnBTizFnBKbbGBYs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvvddgtdehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
 dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
 ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepudejteelhfdttd
 ekgfdtueeilefhgfetjeejheekgeevuddvveegieehueeukeejnecukfhppedugedrfedr
 ieehrddujeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:lDVLYMO_vjbagHdJTgFVPagUUvIKvSOlT4gtfxqyEWfgBYOeOK7FxA>
 <xmx:lDVLYPTE71LBmzvK3DJ9Hek8L-gnBAoyqnu-YUi7cvL2KeHW8GIr2A>
 <xmx:lDVLYGAd-fLAxB1xQedCtS9lQfi3N9iMAsOKZxuj7fqNnW8CpMVyuw>
 <xmx:ljVLYBctKBmUf_xg0a-S5BNsMJWO8jqTsG8bmf6ci76ChQ8DLFt7fw>
Received: from workstation.flets-east.jp (ae065175.dynamic.ppp.asahi-net.or.jp
 [14.3.65.175])
 by mail.messagingengine.com (Postfix) with ESMTPA id 7520C24005C;
 Fri, 12 Mar 2021 04:34:11 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de,
	perex@perex.cz
Subject: [PATCH] ALSA: dice: fix null pointer dereference when node is
 disconnected
Date: Fri, 12 Mar 2021 18:34:07 +0900
Message-Id: <20210312093407.23437-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: ffado-devel@lists.sourceforge.net, alsa-devel@alsa-project.org,
 clemens@ladisch.de, stable@vger.kernel.org
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

When node is removed from IEEE 1394 bus, any transaction fails to the node.
In the case, ALSA dice driver doesn't stop isochronous contexts even if
they are running. As a result, null pointer dereference occurs in callback
from the running context.

This commit fixes the bug to release isochronous contexts always.

Cc: <stable@vger.kernel.org> # v5.4 or later
Fixes: e9f21129b8d8 ("ALSA: dice: support AMDTP domain")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-stream.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index 8e0c0380b4c4..1a14c083e8ce 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -493,11 +493,10 @@ void snd_dice_stream_stop_duplex(struct snd_dice *dice)
 	struct reg_params tx_params, rx_params;
 
 	if (dice->substreams_counter == 0) {
-		if (get_register_params(dice, &tx_params, &rx_params) >= 0) {
-			amdtp_domain_stop(&dice->domain);
+		if (get_register_params(dice, &tx_params, &rx_params) >= 0)
 			finish_session(dice, &tx_params, &rx_params);
-		}
 
+		amdtp_domain_stop(&dice->domain);
 		release_resources(dice);
 	}
 }
-- 
2.27.0

