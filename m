Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61280C433DF
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:19:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E643A206E9
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Q6qQZC7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E643A206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B8741675;
	Tue,  7 Jul 2020 21:18:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B8741675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594149584;
	bh=Byex0VeTVX0s3PwHJnCAruxFfuC1vT1Vw/d7thHCSoA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q6qQZC7Y1SbMGxYAxPltkweANmsARWMGD1Oulx9wH1Fq008KM317hzpXu+lpSaAf/
	 oM4iwk2psFiI0JqKA7MoFW2kv/jFNGN/wOvFD6J97AXaRbywbnSM+hn5NoS8otQyHx
	 Oiasvy20B9M18yBPIVMZ3gK5T62AJ2MUv6H+GE2w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CD1E8F8025A;
	Tue,  7 Jul 2020 21:16:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 51941F802C4; Tue,  7 Jul 2020 21:16:46 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 16E5BF80257
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 21:16:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 16E5BF80257
IronPort-SDR: cJj9d7Mvw1caP4QWwtLT7YP6vH8WS6v3gNTOxhmBP03k8UjYBIqwEaVBn9ZCP+J2M972Ut/MX0
 YngSTABWNVZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="147690670"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; d="scan'208";a="147690670"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 12:16:32 -0700
IronPort-SDR: bu/xB5HkdarlLZbMdaUBKZACtPTpSD53vx716bB5DNolqjguBmrWAgoGN0txboE9sHsbje27pQ
 8XbgXhqSpVAg==
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; d="scan'208";a="388601607"
Received: from mrtorger-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.77.62])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 12:16:30 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v3 02/10] ASoC: sunxi: sun4i-i2s: fix kernel-doc
Date: Tue,  7 Jul 2020 14:16:07 -0500
Message-Id: <20200707191615.98296-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707191615.98296-1-pierre-louis.bossart@linux.intel.com>
References: <20200707191615.98296-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de,
 open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Marcus Cooper <codekipper@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, broonie@kernel.org,
 Lee Jones <lee.jones@linaro.org>,
 "moderated list:ARM/Allwinner sunXi SoC support"
 <linux-arm-kernel@lists.infradead.org>
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

Fix W=1 warnings - missing fields in description

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index d0a8d5810c0a..f23ff29e7c1d 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -128,13 +128,21 @@ struct sun4i_i2s;
 
 /**
  * struct sun4i_i2s_quirks - Differences between SoC variants.
- *
  * @has_reset: SoC needs reset deasserted.
  * @reg_offset_txdata: offset of the tx fifo.
  * @sun4i_i2s_regmap: regmap config to use.
  * @field_clkdiv_mclk_en: regmap field to enable mclk output.
  * @field_fmt_wss: regmap field to set word select size.
  * @field_fmt_sr: regmap field to set sample resolution.
+ * @bclk_dividers: bit clock dividers array
+ * @num_bclk_dividers: number of bit clock dividers
+ * @mclk_dividers: mclk dividers array
+ * @num_mclk_dividers: number of mclk dividers
+ * @get_bclk_parent_rate: callback to get bclk parent rate
+ * @get_sr: callback to get sample resolution
+ * @get_wss: callback to get word select size
+ * @set_chan_cfg: callback to set channel configuration
+ * @set_fmt: callback to set format
  */
 struct sun4i_i2s_quirks {
 	bool				has_reset;
-- 
2.25.1

