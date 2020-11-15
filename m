Return-Path: <SRS0=iGAb=EV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3762DC2D0E4
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Nov 2020 17:11:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D54422453
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Nov 2020 17:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Mr0N8VWo";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U84Dhcao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D54422453
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB1D417A0;
	Sun, 15 Nov 2020 18:11:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB1D417A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605460316;
	bh=nLQvhMPRPmn8OBYUS7haupcAM25cdbBYOxtHEx0ld1E=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mr0N8VWo0A1ij+mdvOsH0hsLtM2ThV8Xf8RVBiGEdbHylejFsySRcoKvHfIaTiVzQ
	 VZVYnI/Gg+Ep4WeTjstfSCEJt/tWjHwFiZyjPxbkVxtawTlLo0QYRbtVDHL7ouMDJz
	 XMr4IQEevzeCr5J7Smk75iux2aYxin+ZnorU5PRM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A9402F8029B;
	Sun, 15 Nov 2020 18:10:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 573F3F8020B; Sun, 15 Nov 2020 18:10:13 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3C4FCF801F5
 for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2020 18:10:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3C4FCF801F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="U84Dhcao"
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch
 [84.226.167.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 12A4124198;
 Sun, 15 Nov 2020 17:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605460202;
 bh=nLQvhMPRPmn8OBYUS7haupcAM25cdbBYOxtHEx0ld1E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=U84DhcaoqGc5ScNqf/gUzmoe3lK2x7woUgZ2YR83LVYwL4il15/VjE1A83CrMWzD4
 EqboYDLGRo+lHGcZ3VILVGxtMrtg4zqXdQ27FuDOoXg9eoSw7rFg7+xX2HLG+NpCGp
 Nf5csY7BoO+zqJ+LnWl6v2gXW/c48MlQgjuFwbAk=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@siol.net>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-media@vger.kernel.org,
 devel@driverdev.osuosl.org, alsa-devel@alsa-project.org
Subject: [PATCH 1/3] clk: fix redefinition of clk_prepare on MIPS with
 HAVE_LEGACY_CLK
Date: Sun, 15 Nov 2020 18:09:48 +0100
Message-Id: <20201115170950.304460-2-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201115170950.304460-1-krzk@kernel.org>
References: <20201115170950.304460-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Krzysztof Kozlowski <krzk@kernel.org>
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

COMMON_CLK even though is a user-selectable symbol, is still selected by
multiple other config options.  COMMON_CLK should not be used when
legacy clocks are provided by architecture, so it correctly depends on
!HAVE_LEGACY_CLK.

However it is possible to create a config which selects both COMMON_CLK
(by SND_SUN8I_CODEC) and HAVE_LEGACY_CLK (by SOC_RT305X) which leads to
compile errors (MIPS architecture):

    drivers/clk/clk.c:855:6: error: redefinition of ‘clk_unprepare’
    In file included from drivers/clk/clk.c:9:
    include/linux/clk.h:263:20: note: previous definition of ‘clk_unprepare’ was here

The definitions clk_bulk_prepare() (and unprepare) already have proper
surrounding #ifdef so add them also for clk_prepare()/clk_unprepare().

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/clk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index f83dac54ed85..f4f68c7c2fb5 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -841,6 +841,7 @@ static void clk_core_unprepare_lock(struct clk_core *core)
 	clk_prepare_unlock();
 }
 
+#ifdef CONFIG_HAVE_CLK_PREPARE
 /**
  * clk_unprepare - undo preparation of a clock source
  * @clk: the clk being unprepared
@@ -860,6 +861,7 @@ void clk_unprepare(struct clk *clk)
 	clk_core_unprepare_lock(clk->core);
 }
 EXPORT_SYMBOL_GPL(clk_unprepare);
+#endif
 
 static int clk_core_prepare(struct clk_core *core)
 {
@@ -921,6 +923,7 @@ static int clk_core_prepare_lock(struct clk_core *core)
 	return ret;
 }
 
+#ifdef CONFIG_HAVE_CLK_PREPARE
 /**
  * clk_prepare - prepare a clock source
  * @clk: the clk being prepared
@@ -941,6 +944,7 @@ int clk_prepare(struct clk *clk)
 	return clk_core_prepare_lock(clk->core);
 }
 EXPORT_SYMBOL_GPL(clk_prepare);
+#endif /* CONFIG_HAVE_CLK_PREPARE */
 
 static void clk_core_disable(struct clk_core *core)
 {
-- 
2.25.1

