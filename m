Return-Path: <SRS0=4V3b=E2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2FBC56201
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 18:40:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02C5B2416E
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 18:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="H2km1xFE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCd/AshZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C5B2416E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1D0FF16AF;
	Fri, 20 Nov 2020 19:39:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1D0FF16AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605897638;
	bh=DxzWbsN/Bms1/LKoRDJpdOkI95ZnandenLyAnLVAE/A=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H2km1xFE//J5uyTXPBxV7vFqKnVu6bWeio9fAVdwgL4NusAcyi4DmvY1YjHtMLFSn
	 cj7ANM5lfItcd2RPvUQ3RIHSNcs/uphiGLhV0ptdTNrUOR2/bUpTDegbgF536eJhRY
	 g1yp46R56twzQUtQFNEeBHqNJV1ZfWTw/ExtJjug=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 97F4BF80168;
	Fri, 20 Nov 2020 19:39:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BC703F8016C; Fri, 20 Nov 2020 19:39:45 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B30AF800F3
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 19:39:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B30AF800F3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jCd/AshZ"
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 76B3D2242B;
 Fri, 20 Nov 2020 18:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605897581;
 bh=DxzWbsN/Bms1/LKoRDJpdOkI95ZnandenLyAnLVAE/A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jCd/AshZ5/r3P/1oIqdW8hQM1nRhKZv0sMLYyxpdx/m20ZRtDwhGvYSYPsy3FEPs2
 0pwKMOU82m3S2uspZxrUS4/m0u6pKZSTSXbaQ0Ms8Lr/TNuMcSqeG/lqs75LR2QwZ0
 cOBv52+ER1crgRf+ypbd36DHX/BU2FkefVDZHtm0=
Date: Fri, 20 Nov 2020 12:39:46 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 126/141] slimbus: messaging: Fix fall-through warnings for
 Clang
Message-ID: <08a882fa7a3145bc33bc02392df8319e95092dcf.1605896060.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: alsa-devel@alsa-project.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
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

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/slimbus/messaging.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index d5879142dbef..f2b5d347d227 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -258,6 +258,7 @@ int slim_xfer_msg(struct slim_device *sbdev, struct slim_val_inf *msg,
 	case SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION:
 	case SLIM_MSG_MC_CLEAR_INFORMATION:
 		txn->rl += msg->num_bytes;
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

