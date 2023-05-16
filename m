Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A90C77B7F
	for <alsa-devel@archiver.kernel.org>; Tue, 16 May 2023 08:12:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 820F07F1;
	Tue, 16 May 2023 10:12:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 820F07F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684224775;
	bh=BwbqlbeJ/czAgDOonORnkAuqe8vpuMclFiku42/KenI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=SBGdgdAZM53xIF3tCWiW9rglv9OZ1CMaHcbvVt84DqH/xqRMcfY/YTNFCxoQFA2jQ
	 ZiaeQn/FaFvykr8MWbzf2r5CCPtit6mWCYUWQClH752VSi/TFWqoOyTxap1kHlMV5c
	 IFoFiQPwXPvj1KGzUF9p4LXGzdMrTXl59FuQ3a7s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CD0D4F8025A; Tue, 16 May 2023 10:11:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 63D3DF80272;
	Tue, 16 May 2023 10:11:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1F22AF80272; Tue, 16 May 2023 10:11:34 +0200 (CEST)
Received: from out30-101.freemail.mail.aliyun.com
 (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9D6A8F8016D;
	Tue, 16 May 2023 10:11:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D6A8F8016D
X-Alimail-AntiSpam: 
 AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VinPRLs_1684224678;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com
 fp:SMTPD_---0VinPRLs_1684224678)
          by smtp.aliyun-inc.com;
          Tue, 16 May 2023 16:11:19 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: perex@perex.cz
Cc: tiwai@suse.com,
	pierre-louis.bossart@linux.intel.com,
	lgirdwood@gmail.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com,
	kai.vehmanen@linux.intel.com,
	broonie@kernel.org,
	sound-open-firmware@alsa-project.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] ASoC: SOF: ipc4-topology: Fix an unsigned comparison
 which can never be negative
Date: Tue, 16 May 2023 16:11:16 +0800
Message-Id: <20230516081116.71370-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: U5DVJ7Q3IGUA3NXIRINTK62DTT5345L7
X-Message-ID-Hash: U5DVJ7Q3IGUA3NXIRINTK62DTT5345L7
X-MailFrom: yang.lee@linux.alibaba.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/U5DVJ7Q3IGUA3NXIRINTK62DTT5345L7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The return value from the call to sof_ipc4_get_valid_bits() is int.
However, the return value is being assigned to an unsigned
int variable 'out_ref_valid_bits', so making it an int.

Eliminate the following warning:
./sound/soc/sof/ipc4-topology.c:1537:6-24: WARNING: Unsigned expression compared with zero: out_ref_valid_bits < 0

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4985
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 sound/soc/sof/ipc4-topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index dce2f8f7f518..d82ac5701eb2 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -1381,8 +1381,8 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
 	void **ipc_config_data;
 	int *ipc_config_size;
 	u32 **data;
-	int ipc_size, ret;
-	u32 out_ref_rate, out_ref_channels, out_ref_valid_bits;
+	int ipc_size, ret, out_ref_valid_bits;
+	u32 out_ref_rate, out_ref_channels;
 	u32 deep_buffer_dma_ms = 0;
 	int output_fmt_index;
 
-- 
2.20.1.7.g153144c

