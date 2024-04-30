Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4048EC4345F
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Apr 2024 12:02:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 949CDE85;
	Tue, 30 Apr 2024 14:01:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 949CDE85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1714478523;
	bh=epvHPddoW8cTahPJ8pPZg8pvrnB/jzMqDAMM7RoD2Fo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=j4PVPyBAJNNrR27f/e2xo17eBCAp1ufDkrD1OlM526fzsSiqKOdDfVExyy6MItOew
	 rgdkoqcwdYkFf8vfvUQAX2BtHj0H4PEVNHcvuraKpi5r/Zzo8TmoPI6bXCw+oq6ljI
	 dF4A76f+dOS9DZ7qId/QFz7zSGmz8cJopR5HpJsY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A13ECF805C7; Tue, 30 Apr 2024 14:01:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DB0AAF805D3;
	Tue, 30 Apr 2024 14:01:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 662D2F8028D; Tue, 30 Apr 2024 14:01:15 +0200 (CEST)
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 207AAF8023A
	for <alsa-devel@alsa-project.org>; Tue, 30 Apr 2024 14:01:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 207AAF8023A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com
 header.a=rsa-sha256 header.s=k1 header.b=AonwpukB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=1q2ejO6T6rBtag1x93WXJsog9Oya4RWvl6aoqimdi9U=; b=Aonwpu
	kBL6N/oL0WSZFupxdnK9liqWdgKdzRe3nr1AgxubtB517kloaCDKmy2xlyoO6DcW
	n1VL0dOKmnql1ki4SXySGXDkbJdwOYIOHlQuiw9WWPF8c/zF+oEUlYi6bKEvpbUE
	JRLpwRabvYsL06cDzNcEqevjdcwrG4yaKqlr4gJTOr0l3bDhoH0nUHgToa/xT7S8
	dmgouclEqVV3/M3eraUrWwf4g5GPSmabiQph3eJlacf13F0XhD1xGGLX0MBBM56K
	Mi9rxOml5Iu0xyi+WS98vDYQG9qOAWKrMSSEBryQzhNz2kiMZDIlU5EmRLuJYg/s
	tb5ad/LRGpRsRFLA==
Received: (qmail 2623489 invoked from network); 30 Apr 2024 14:01:04 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted,
 authenticated); 30 Apr 2024 14:01:04 +0200
X-UD-Smtp-Session: l3s3148p1@y4bSH08XnJZehhrb
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: alsa-devel@alsa-project.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/3] slimbus: qcom-ctrl: use 'time_left' variable with
 wait_for_completion_timeout()
Date: Tue, 30 Apr 2024 14:01:00 +0200
Message-ID: <20240430120102.29459-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240430120102.29459-1-wsa+renesas@sang-engineering.com>
References: <20240430120102.29459-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ZFWV6ESKAA7PETLM3JLDVNMW2AFCCAOH
X-Message-ID-Hash: ZFWV6ESKAA7PETLM3JLDVNMW2AFCCAOH
X-MailFrom: wsa+renesas@sang-engineering.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZFWV6ESKAA7PETLM3JLDVNMW2AFCCAOH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_for_completion_timeout() causing patterns like:

	timeout = wait_for_completion_timeout(...)
	if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
self explaining.

Fix to the proper variable type 'unsigned long' while here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/slimbus/qcom-ctrl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index 400b7b385a44..c613c7517f99 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -330,7 +330,8 @@ static int qcom_xfer_msg(struct slim_controller *sctrl,
 	void *pbuf = slim_alloc_txbuf(ctrl, txn, &done);
 	unsigned long ms = txn->rl + HZ;
 	u8 *puc;
-	int ret = 0, timeout, retries = QCOM_BUF_ALLOC_RETRIES;
+	int ret = 0, retries = QCOM_BUF_ALLOC_RETRIES;
+	unsigned long time_left;
 	u8 la = txn->la;
 	u32 *head;
 	/* HW expects length field to be excluded */
@@ -374,9 +375,9 @@ static int qcom_xfer_msg(struct slim_controller *sctrl,
 		memcpy(puc, txn->msg->wbuf, txn->msg->num_bytes);
 
 	qcom_slim_queue_tx(ctrl, head, txn->rl, MGR_TX_MSG);
-	timeout = wait_for_completion_timeout(&done, msecs_to_jiffies(ms));
+	time_left = wait_for_completion_timeout(&done, msecs_to_jiffies(ms));
 
-	if (!timeout) {
+	if (!time_left) {
 		dev_err(ctrl->dev, "TX timed out:MC:0x%x,mt:0x%x", txn->mc,
 					txn->mt);
 		ret = -ETIMEDOUT;
-- 
2.43.0

