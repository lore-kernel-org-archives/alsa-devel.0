Return-Path: <SRS0=7Yh/=DV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F43C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2020 02:59:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5298A21775
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2020 02:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="J+mrVghz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jhvl5R+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5298A21775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5959416D0;
	Wed, 14 Oct 2020 04:58:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5959416D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602644379;
	bh=sCE8LDHzvlWrzjvibU91Vup7ces7HmtycE9RnmT05ag=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J+mrVghz0CEjTdOtaSsOE4irjWg5lRWKjMuTiedbCoEGVTOyypR9llKWwMeg2RSsz
	 NToRMkYTt63iH+DbbXlpXf4q5TGBuzzgTnWyIoinrfIkQ5BGhpFY1QX+89JBVwo0io
	 PE2ITExEpZXapGd3TEcngZi3ldNj+Z27bGbXYgEo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EC5ADF8026B;
	Wed, 14 Oct 2020 04:57:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BE824F80217; Wed, 14 Oct 2020 04:57:08 +0200 (CEST)
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3E2F2F8021D;
 Wed, 14 Oct 2020 04:56:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3E2F2F8021D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="Jhvl5R+m"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=bYV1w8XItU+gaKbLFzijOk8gUliJ9BqOZSyQAwLkMec=; b=Jhvl5R+mtjSDbteR8R+ac3m2mX
 cPJ/ABj9EjN8BgmtC+q3a3i1LY1Iq9t7MZzddohPwOULYGPLVMg6qXi82AksZXG1Oe0nHNIfmyIZN
 9olVfkDT281gohBV+vY9JIKtvA4pOBh7GUzHJg9FGBfrfIKnsXqp5PekCZKst7CkZ/rbSRlCGHh9y
 4VueywQKkF9Ny3YhQVzRAQOMXhb52dtpGA2126lR4OCMuojqWiyL0hHqBugg2ejZ1OL4BBsLgO5oh
 YPCAupCConLarB2XiQpFuHrgvUoxFEtXOhyvnwqS4BkNVaVo9INtfyAuwpjsfG/mYkh/rd9kgavo3
 isep+ZEw==;
Received: from [2601:1c0:6280:3f0::507c] (helo=smtpauth.infradead.org)
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSWy2-0005zg-KA; Wed, 14 Oct 2020 02:56:43 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ASoC: sof: imx: fix Kconfig punctuation
Date: Tue, 13 Oct 2020 19:56:31 -0700
Message-Id: <20201014025633.4879-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201014025633.4879-1-rdunlap@infradead.org>
References: <20201014025633.4879-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, sound-open-firmware@alsa-project.org
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

Add periods at the end of sentences in help text.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: sound-open-firmware@alsa-project.org
Cc: alsa-devel@alsa-project.org
---
 sound/soc/sof/imx/Kconfig |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- linux-next-20201013.orig/sound/soc/sof/imx/Kconfig
+++ linux-next-20201013/sound/soc/sof/imx/Kconfig
@@ -17,7 +17,7 @@ config SND_SOC_SOF_IMX_OF
 	select SND_SOC_SOF_IMX8M if SND_SOC_SOF_IMX8M_SUPPORT
 	help
 	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level
+	  'select' statements at a higher level.
 
 config SND_SOC_SOF_IMX_COMMON
 	tristate
@@ -30,7 +30,7 @@ config SND_SOC_SOF_IMX8_SUPPORT
 	depends on IMX_SCU=y || IMX_SCU=SND_SOC_SOF_IMX_OF
 	depends on IMX_DSP=y || IMX_DSP=SND_SOC_SOF_IMX_OF
 	help
-	  This adds support for Sound Open Firmware for NXP i.MX8 platforms
+	  This adds support for Sound Open Firmware for NXP i.MX8 platforms.
 	  Say Y if you have such a device.
 	  If unsure select "N".
 
@@ -40,13 +40,13 @@ config SND_SOC_SOF_IMX8
 	select SND_SOC_SOF_XTENSA
 	help
 	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level
+	  'select' statements at a higher level.
 
 config SND_SOC_SOF_IMX8M_SUPPORT
 	bool "SOF support for i.MX8M"
 	depends on IMX_DSP=y || IMX_DSP=SND_SOC_SOF_OF
 	help
-	  This adds support for Sound Open Firmware for NXP i.MX8M platforms
+	  This adds support for Sound Open Firmware for NXP i.MX8M platforms.
 	  Say Y if you have such a device.
 	  If unsure select "N".
 
@@ -56,6 +56,6 @@ config SND_SOC_SOF_IMX8M
 	select SND_SOC_SOF_XTENSA
 	help
 	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level
+	  'select' statements at a higher level.
 
 endif ## SND_SOC_SOF_IMX_IMX_TOPLEVEL
