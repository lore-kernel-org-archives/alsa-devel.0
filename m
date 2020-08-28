Return-Path: <SRS0=n32M=CG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3746C433E6
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2020 07:24:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B53420DD4
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2020 07:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HOah8vCk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUq/I4b0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B53420DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 99BF5184B;
	Fri, 28 Aug 2020 09:24:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 99BF5184B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598599491;
	bh=0r2w+eWEA3lELt5/vzkC23PGHtVYVeQf3VCsJwHlaBE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HOah8vCkgn0Xc8OoG1cnWjcfgXw/0A9U4smzUbobn5pMPzRl0yDukYVeJ3VDYxJ+x
	 80CrLJya2OyCRk6rX5KCh46YDbCq9okHXHTP9SfsxbLTtNvEXHpprv6vgrhcbk3VqS
	 V1vMWcXCN8pzyDclPJGvJeclBv+ur9l5JJCjR+Ws=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 61E81F802DF;
	Fri, 28 Aug 2020 09:21:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 580FFF802C3; Fri, 28 Aug 2020 09:21:35 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 731B3F80118
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2020 09:21:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 731B3F80118
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="GUq/I4b0"
Received: from localhost.localdomain (unknown [122.171.38.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7441C20E65;
 Fri, 28 Aug 2020 07:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598599285;
 bh=0r2w+eWEA3lELt5/vzkC23PGHtVYVeQf3VCsJwHlaBE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GUq/I4b0jsgwXlskT2uARpMifgvl4c0JvNCWky4QJpIgwVpDUBFAeB8ZD4YWEWrtk
 il1aLkm6gJ1xd8QwGutuO31uVZ/ib4Yp7SFe41u8kZNvQoMC4Tcn2oav2znp59OHTr
 Gd9VVpAiqenl6DhPQqq2MCyUZA6nEsxxzhTAwxws=
From: Vinod Koul <vkoul@kernel.org>
To: alsa-devel@alsa-project.org
Subject: [PATCH 4/9] soundwire: stream: use FIELD_{GET|PREP}
Date: Fri, 28 Aug 2020 12:50:56 +0530
Message-Id: <20200828072101.3781956-5-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200828072101.3781956-1-vkoul@kernel.org>
References: <20200828072101.3781956-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Vinod Koul <vkoul@kernel.org>
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

use FIELD_{GET|PREP} in stream code to get/set field values instead of
open coding masks and shift operations.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soundwire/stream.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 37290a799023..91fd300739ee 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -100,9 +100,7 @@ static int _sdw_program_slave_port_params(struct sdw_bus *bus,
 		return ret;
 
 	/* Program DPN_SampleCtrl2 register */
-	wbuf = (t_params->sample_interval - 1);
-	wbuf &= SDW_DPN_SAMPLECTRL_HIGH;
-	wbuf >>= SDW_REG_SHIFT(SDW_DPN_SAMPLECTRL_HIGH);
+	wbuf = FIELD_GET(SDW_DPN_SAMPLECTRL_HIGH, t_params->sample_interval - 1);
 
 	ret = sdw_write(slave, addr3, wbuf);
 	if (ret < 0) {
@@ -111,9 +109,8 @@ static int _sdw_program_slave_port_params(struct sdw_bus *bus,
 	}
 
 	/* Program DPN_HCtrl register */
-	wbuf = t_params->hstart;
-	wbuf <<= SDW_REG_SHIFT(SDW_DPN_HCTRL_HSTART);
-	wbuf |= t_params->hstop;
+	wbuf = FIELD_PREP(SDW_DPN_HCTRL_HSTART, t_params->hstart);
+	wbuf |= FIELD_PREP(SDW_DPN_HCTRL_HSTOP, t_params->hstop);
 
 	ret = sdw_write(slave, addr4, wbuf);
 	if (ret < 0)
@@ -157,8 +154,8 @@ static int sdw_program_slave_port_params(struct sdw_bus *bus,
 	}
 
 	/* Program DPN_PortCtrl register */
-	wbuf = p_params->data_mode << SDW_REG_SHIFT(SDW_DPN_PORTCTRL_DATAMODE);
-	wbuf |= p_params->flow_mode;
+	wbuf = FIELD_PREP(SDW_DPN_PORTCTRL_DATAMODE, p_params->data_mode);
+	wbuf |= FIELD_PREP(SDW_DPN_PORTCTRL_FLOWMODE, p_params->flow_mode);
 
 	ret = sdw_update(s_rt->slave, addr1, 0xF, wbuf);
 	if (ret < 0) {
-- 
2.26.2

