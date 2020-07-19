Return-Path: <SRS0=8d/u=A6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A5DC433E2
	for <alsa-devel@archiver.kernel.org>; Sun, 19 Jul 2020 18:11:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 347DB20684
	for <alsa-devel@archiver.kernel.org>; Sun, 19 Jul 2020 18:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="h+pY0le5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a4lS0k+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347DB20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC6081673;
	Sun, 19 Jul 2020 20:10:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC6081673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595182297;
	bh=cZTeVh42HTvFTJ1V8ck6Z80hfY8e3VwHYXm5QSKDf6o=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=h+pY0le5Jrc3oajgS0ZrfgE3pfpXAps1UHn6cDfmFJjsjExgamUmXCkbHy2YDgjuf
	 6j6dJR+/5DratVTsSb2C4aZtNOVtmp8lt3ugRXucC1aR1Xiu7PlPYsnrxldYX6Q8Ap
	 pEKeAzGFhaIa9olq52T0+SoJ1w8COvqT4Knpmvyg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DB0B5F801F5;
	Sun, 19 Jul 2020 20:09:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A8242F80161; Sun, 19 Jul 2020 20:09:28 +0200 (CEST)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3341EF80161
 for <alsa-devel@alsa-project.org>; Sun, 19 Jul 2020 20:09:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3341EF80161
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="a4lS0k+G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=G2g4Ceb7iWRskTszXh5u/2+ZaJlCDCsfgNYhSicznHw=; b=a4lS0k+GTcKGcQ0AilLiU1+vgJ
 q8FcMUxsztwUZTY6eoNtCDa18NjmGUf/a4dzysFju4jYG2WcOlyX/qCyRG7yN2mdkLRb7hjh3sWSe
 hHW8fToSdOkM3hq/0eLPc7hzbGC2KTzTFaNcuzqVoq0CH7JkkQ8mxv8Q1WtLH+Qmqfp3ZdOoNLaZ8
 RqGiokGkt8Ct5lhlPKXZIdWcl8oStBvMkb+c975sDsSeDFlJuRCiw2xgEzq9ZdxcVFxKY/wmU3qby
 uR5TRaB9ZOtF5Bpk8GVNy/G3k99yftRmtaLQFwdpQB9ioTe3WOhEJds4hTLOrgsuxC/iaVIFejJyv
 eiPmWF6Q==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxDkS-0006EF-P7; Sun, 19 Jul 2020 18:09:17 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: tegra20_das.h: delete duplicated words
Date: Sun, 19 Jul 2020 11:09:12 -0700
Message-Id: <20200719180912.30770-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Stephen Warren <swarren@nvidia.com>, alsa-devel@alsa-project.org
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

Delete the doubled word "to" in two comments.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/tegra/tegra20_das.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200717.orig/sound/soc/tegra/tegra20_das.h
+++ linux-next-20200717/sound/soc/tegra/tegra20_das.h
@@ -91,14 +91,14 @@ struct tegra20_das {
  */
 
 /*
- * Connect a DAP to to a DAC
+ * Connect a DAP to a DAC
  * dap_id: DAP to connect: TEGRA20_DAS_DAP_ID_*
  * dac_sel: DAC to connect to: TEGRA20_DAS_DAP_SEL_DAC*
  */
 extern int tegra20_das_connect_dap_to_dac(int dap_id, int dac_sel);
 
 /*
- * Connect a DAP to to another DAP
+ * Connect a DAP to another DAP
  * dap_id: DAP to connect: TEGRA20_DAS_DAP_ID_*
  * other_dap_sel: DAP to connect to: TEGRA20_DAS_DAP_SEL_DAP*
  * master: Is this DAP the master (1) or slave (0)
