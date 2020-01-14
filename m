Return-Path: <SRS0=6Vr6=3D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BC1C33CB1
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:17:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEBAC2467A
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="E5Izllmj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEBAC2467A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (unknown [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B6EF2ED9;
	Tue, 14 Jan 2020 12:24:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B6EF2ED9
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 112F5F80276;
	Tue, 14 Jan 2020 12:23:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B65E9F80277; Tue, 14 Jan 2020 12:23:08 +0100 (CET)
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 04B21F800E9;
 Tue, 14 Jan 2020 12:22:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04B21F800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net
 header.b="E5Izllmj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1579000976;
 s=strato-dkim-0002; d=gerhold.net;
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=5yTE7cLlgXleUHOY2MlqK1MoBnw7WgPHiBcoPkvG1SQ=;
 b=E5IzllmjtQwZl12arc8rrozgtdw0WxwiWOdhdO6Lx3cSfx4eWxzQQJa3yKd7M4tMbw
 KkOSDk6QiiCYxtz9APJ6QXyfPAhYGhnM8Gv3SN3Vil0BFTtCN0uwjPWQnLi7c1d2IvAz
 cNsGIc/mA70xTaKPQaVKDMux5vQmIKwT76fVO7/5sHghKHaAgxy+S+H66vf3rTkXqpm4
 rNChH1x1LmuEtleQUb6omBAlr8h8A3D44Xp6noLYi3m2N9PY1sXrqLs+hu6AfF+4XN0j
 n3qIKnXelXcgP8Nm+Zll2HKJKssOaw7dzfzw4gbJpOIoxfTdPtDDrjUCqRViISIjzBl8
 2kOQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQ7IOGU5qzCB3a93viaVr"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain by smtp.strato.de (RZmta 46.1.4 AUTH)
 with ESMTPSA id h048a6w0EBMtULE
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 14 Jan 2020 12:22:55 +0100 (CET)
From: Stephan Gerhold <stephan@gerhold.net>
To: Jaroslav Kysela <perex@perex.cz>
Date: Tue, 14 Jan 2020 12:21:07 +0100
Message-Id: <20200114112110.51983-5-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114112110.51983-1-stephan@gerhold.net>
References: <20200114112110.51983-1-stephan@gerhold.net>
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Stephan Gerhold <stephan@gerhold.net>
Subject: [alsa-devel] [PATCH alsa-ucm-conf 4/7] codecs/msm8916-wcd:
	Headphones: Drop invalid RDAC2 MUX value
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

As of commit 9110d1b0e229c ("ASoC: msm8916-wcd-analog: Fix RX1 selection in RDAC2 MUX")
in the Linux kernel, the RDAC2 MUX mixer can be only set to RX1 or RX2.
Drop the invalid value from the UCM configuration.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 ucm2/codecs/msm8916-wcd/Headphones.conf | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ucm2/codecs/msm8916-wcd/Headphones.conf b/ucm2/codecs/msm8916-wcd/Headphones.conf
index 7a2090e..380787d 100644
--- a/ucm2/codecs/msm8916-wcd/Headphones.conf
+++ b/ucm2/codecs/msm8916-wcd/Headphones.conf
@@ -23,7 +23,6 @@ SectionDevice."Headphones" {
 		cset "name='RX2 Digital Volume' 0"
 		cset "name='HPHL' 0"
 		cset "name='HPHR' 0"
-		cset "name='RDAC2 MUX' ZERO"
 		cset "name='RX1 MIX1 INP1' ZERO"
 		cset "name='RX2 MIX1 INP1' ZERO"
 	]
-- 
2.24.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
