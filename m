Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEADC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Dec 2021 14:25:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A82AE1FDB;
	Tue, 14 Dec 2021 15:24:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A82AE1FDB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639491899;
	bh=2dDNUldn/GWjkkMo/5vstfOfw/V/JlyhoW+cSlhqIbI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CKN5eJ4XNy538D5xcUDjcJ+Yl1PAYwQUSFGVGFuOc3RgqFOV6rXncY+Kz6uPkc+U0
	 CCWhbVlCayUNVyx5bzmvwtbRqSELZEYwIAh7JDXNhq7KUgdADakN2QC1ddE3QTJoCw
	 EGXNf7cN6fdKyFAkg0/ioKz3sa1429DKqmuFEpZc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 73E71F80518;
	Tue, 14 Dec 2021 15:22:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 73244F804F2; Tue, 14 Dec 2021 15:22:52 +0100 (CET)
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de
 [85.215.255.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5C0CCF8016A
 for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2021 15:22:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5C0CCF8016A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net
 header.b="e2jcaIpB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1639491756;
 s=strato-dkim-0002; d=gerhold.net;
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
 From:Subject:Sender;
 bh=nK1WI/n5WJTnKoFcfera4gLZkWVqZW1oe5BBzB4Dcuo=;
 b=e2jcaIpBwW/gjK+Wrev+TvSAp2KUSBzwJMDosivaYYohMOPejnp+EI3O3GOb4bNnRr
 bVGriNq7ub/7G9ZdGvKTvdjMsg7UOX2f11il6jzKLEYVdp+qgR3w3l/mO8vWJT+Ekdce
 N5wC18lSqySEgNC8wsCNsniqOq3Gsvc/qX0PUaxVcLgq9nmcbZoLwygE5Kok6TF1kgNg
 Si6U5EJIVJU+pqn2Ivcfn9m9UtECynpaJEY50RaP9aUuf8C+BXerKr7rK4vE1NtqdMae
 Vj7i0+RYZiWGsBWb6bvyT8KTmm152DiSPeb7CpDCaOsWX136tkN9r6ngsf4UNkWBLhKA
 83Hw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQ7UOGqRde+a0fiL1O/hR"
X-RZG-CLASS-ID: mo00
Received: from droid.. by smtp.strato.de (RZmta 47.35.3 AUTH)
 with ESMTPSA id x08baexBEEMZ8rY
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 14 Dec 2021 15:22:35 +0100 (CET)
From: Stephan Gerhold <stephan@gerhold.net>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/4] ASoC: qcom: common: Parse "pin-switches" and "widgets"
 from DT
Date: Tue, 14 Dec 2021 15:20:48 +0100
Message-Id: <20211214142049.20422-4-stephan@gerhold.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211214142049.20422-1-stephan@gerhold.net>
References: <20211214142049.20422-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Banajit Goswami <bgoswami@codeaurora.org>,
 Stephan Gerhold <stephan@gerhold.net>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-arm-msm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Paul Cercueil <paul@crapouillou.net>, Andy Gross <agross@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Vincent Knecht <vincent.knecht@mailoo.org>
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

Use the DT helpers in the ASoC core to parse the "pin-switches" and
"widgets" properties from the device tree. This allows adding extra
mixers to disable e.g. an extra speaker amplifier that would be
normally powered on automatically because it is connected to a shared
output pin.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 sound/soc/qcom/common.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index 2e1c618f7529..eff134785051 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -26,6 +26,12 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 		return ret;
 	}
 
+	if (of_property_read_bool(dev->of_node, "widgets")) {
+		ret = snd_soc_of_parse_audio_simple_widgets(card, "widgets");
+		if (ret)
+			return ret;
+	}
+
 	/* DAPM routes */
 	if (of_property_read_bool(dev->of_node, "audio-routing")) {
 		ret = snd_soc_of_parse_audio_routing(card, "audio-routing");
@@ -39,6 +45,10 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 			return ret;
 	}
 
+	ret = snd_soc_of_parse_pin_switches(card, "pin-switches");
+	if (ret)
+		return ret;
+
 	ret = snd_soc_of_parse_aux_devs(card, "aux-devs");
 	if (ret)
 		return ret;
-- 
2.34.1

