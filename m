Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21DECD613B
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Oct 2023 21:31:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 86068EE5;
	Mon,  9 Oct 2023 23:30:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 86068EE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696887089;
	bh=hKpw9LZwyKaVS0FWXHmJymdA4SjptOQOm2bWj75OgPs=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=vST5B7ISguE+711dZlZn9G9rQbOaRvZ8+UuPCiQZvPsyts0K90qEJ/4kekFwBuGWe
	 qzyXUR5pYdEPkKokN2AIW9pyMk5EcTi7qkYeJKbPsFNLNynMEyxSEGNM2cD6PDamHT
	 ruPdXCSHDmUzor3WmPr65DdY9h1HwKV+Yznjasqw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EC92DF80557; Mon,  9 Oct 2023 23:30:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7CEF6F802BE;
	Mon,  9 Oct 2023 23:30:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BCDEDF802BE; Mon,  9 Oct 2023 23:30:33 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 12223F80130
	for <alsa-devel@alsa-project.org>; Mon,  9 Oct 2023 23:30:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 12223F80130
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=rT1qhpFp
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id DE9F7CE1A49;
	Mon,  9 Oct 2023 21:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D10C433C7;
	Mon,  9 Oct 2023 21:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696887021;
	bh=hKpw9LZwyKaVS0FWXHmJymdA4SjptOQOm2bWj75OgPs=;
	h=Date:From:To:Cc:Subject:From;
	b=rT1qhpFpqRiVqgpTZwUGexp2A+nUsN2ViOQjRqnwpV0V0OEDPncJ7UNSgaYVBGHsH
	 qKxM3kOH+f9qJrEyWZPcguD95u3rmDjaCIF5AVOLgk5fP2yAOEmMMJtYd77KoXZrFw
	 Wq6qTfZatu8Mlf81/v9INrgEXKTDHDPi5aCI+OO2PEAo9gx3ZRj1LmHA3FEQ4cIP+N
	 YwNrvNLakxwSDssvtvd2pvR/7MhoZLyFiiR95n8xwK6qH/kqt1oL05VW5cl6ROxs9x
	 fIomWW8LKuLgLPRQpFao87ba4zFOX2cCBX/2F8Q35XWeJEhC05ayqb8/jR9GpH/LE2
	 BSFrwwIN8Vd5g==
Date: Mon, 9 Oct 2023 15:30:17 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] soc: qcom: apr: Add __counted_by for struct apr_rx_buf
 and use struct_size()
Message-ID: <ZSRw6RNi3Crhd32H@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: SSRFB47XSDO7BIRFXYDZKQHTX7LY4NXV
X-Message-ID-Hash: SSRFB47XSDO7BIRFXYDZKQHTX7LY4NXV
X-MailFrom: gustavoars@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SSRFB47XSDO7BIRFXYDZKQHTX7LY4NXV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

While there, use struct_size() helper, instead of the open-coded
version, to calculate the size for the allocation of the whole
flexible structure, including of course, the flexible-array member.

This code was found with the help of Coccinelle, and audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/soc/qcom/apr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
index 30f81d6d9d9d..1f8b315576a4 100644
--- a/drivers/soc/qcom/apr.c
+++ b/drivers/soc/qcom/apr.c
@@ -41,7 +41,7 @@ struct packet_router {
 struct apr_rx_buf {
 	struct list_head node;
 	int len;
-	uint8_t buf[];
+	uint8_t buf[] __counted_by(len);
 };
 
 /**
@@ -171,7 +171,7 @@ static int apr_callback(struct rpmsg_device *rpdev, void *buf,
 		return -EINVAL;
 	}
 
-	abuf = kzalloc(sizeof(*abuf) + len, GFP_ATOMIC);
+	abuf = kzalloc(struct_size(abuf, buf, len), GFP_ATOMIC);
 	if (!abuf)
 		return -ENOMEM;
 
-- 
2.34.1

