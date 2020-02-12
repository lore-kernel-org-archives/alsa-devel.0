Return-Path: <SRS0=nhcg=4A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDDAC35242
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Feb 2020 01:56:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCCB22082F
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Feb 2020 01:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TkKfw1fR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=serbinski.com header.i=@serbinski.com header.b="MyzJHWHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCCB22082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=serbinski.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 33463166E;
	Wed, 12 Feb 2020 02:55:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 33463166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581472585;
	bh=cJy0KakIK/Hbl77gCoDTesHsFZGIyUPOp6lYV31dWFo=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TkKfw1fRCy7Cmp9fBCVpP/knzC6CH6RBRXbSZtJUPSzzeJnEUWtCMWHjO6SQzM8mf
	 tbMKpEiiggdpTlKBjAlGFUfO+nJaIx5tJqPBD9y+mtZaasaEDiamp6ihU2P+zji3K1
	 +2cOhho+IY/zS8vyEhW9Qt32B8qsP+9Jdvr1dnHo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 53DB0F8028E;
	Wed, 12 Feb 2020 02:53:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 78B1BF8028D; Wed, 12 Feb 2020 02:53:16 +0100 (CET)
Received: from mail.serbinski.com (mail.serbinski.com [162.218.126.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B8F70F8028D
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2020 02:53:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B8F70F8028D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=serbinski.com header.i=@serbinski.com
 header.b="MyzJHWHO"
Received: from localhost (unknown [127.0.0.1])
 by mail.serbinski.com (Postfix) with ESMTP id 5D545D0071A;
 Wed, 12 Feb 2020 01:53:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at serbinski.com
Received: from mail.serbinski.com ([127.0.0.1])
 by localhost (mail.serbinski.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ffjh8fLh9Azr; Tue, 11 Feb 2020 20:52:58 -0500 (EST)
Received: from anet (23-233-80-73.cpe.pppoe.ca [23.233.80.73])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mail.serbinski.com (Postfix) with ESMTPSA id 486D6D00715;
 Tue, 11 Feb 2020 20:52:37 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.serbinski.com 486D6D00715
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=serbinski.com;
 s=default; t=1581472357;
 bh=6Z1IRgMoCdCgFvRk12JMyiKFWmlMSbcgX0A0M9qY3qI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MyzJHWHOSek1Wj3kk6aSij3GlAgVSI9BIlKlz0CST0OpKPB6IE2EAEsaZM7GIgTF/
 +L9FVj9P4AKzQzxMbQltWlQsvDaDIqqoWnc6WiSAkRkDdPkSwk2hGuiPNjZFNF0ecs
 s0WhCWNfvQKTCyd+XToWneyecdNTnnRLHNqjVSdI=
From: Adam Serbinski <adam@serbinski.com>
To: Mark Brown <broonie@kernel.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>
Date: Tue, 11 Feb 2020 20:52:17 -0500
Message-Id: <20200212015222.8229-2-adam@serbinski.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200212015222.8229-1-adam@serbinski.com>
References: <20200212015222.8229-1-adam@serbinski.com>
MIME-Version: 1.0
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Andy Gross <agross@kernel.org>, Adam Serbinski <adam@serbinski.com>,
 linux-kernel@vger.kernel.org
Subject: [alsa-devel] [PATCH v3 1/6] ASoC: qdsp6: dt-bindings: Add q6afe pcm
	dt binding
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

This patch adds bindings required for PCM ports on AFE.

Signed-off-by: Adam Serbinski <adam@serbinski.com>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC: Andy Gross <agross@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Liam Girdwood <lgirdwood@gmail.com>
CC: Patrick Lai <plai@codeaurora.org>
CC: Banajit Goswami <bgoswami@codeaurora.org>
CC: Jaroslav Kysela <perex@perex.cz>
CC: Takashi Iwai <tiwai@suse.com>
CC: alsa-devel@alsa-project.org
CC: linux-arm-msm@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 include/dt-bindings/sound/qcom,q6afe.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/dt-bindings/sound/qcom,q6afe.h b/include/dt-bindings/sound/qcom,q6afe.h
index 1df06f8ad5c3..f3a435a112cb 100644
--- a/include/dt-bindings/sound/qcom,q6afe.h
+++ b/include/dt-bindings/sound/qcom,q6afe.h
@@ -107,6 +107,14 @@
 #define QUINARY_TDM_RX_7	102
 #define QUINARY_TDM_TX_7	103
 #define DISPLAY_PORT_RX		104
+#define PRIMARY_PCM_RX		105
+#define PRIMARY_PCM_TX		106
+#define SECONDARY_PCM_RX	107
+#define SECONDARY_PCM_TX	108
+#define TERTIARY_PCM_RX		109
+#define TERTIARY_PCM_TX		110
+#define QUATERNARY_PCM_RX	111
+#define QUATERNARY_PCM_TX	112
 
 #endif /* __DT_BINDINGS_Q6_AFE_H__ */
 
-- 
2.21.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
