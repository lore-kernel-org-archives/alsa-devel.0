Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D500AC61DA4
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Mar 2023 23:34:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7D9E71202;
	Thu, 16 Mar 2023 00:33:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7D9E71202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678923246;
	bh=V/Z0f0cZlAcswOoBOoDprpItQqPHofsay60H0vvm0Zs=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=NDtcSH3S2qFAHezWuYv5033cmLJ0q13PYaNqVENz0UEwY3g9WLAD+gd/nhs9bXZLC
	 ANujycn8xA9+ouz8dY5WtN+1L6Y0+17l/Aqn7tBssupejzhRlsgYWdEBwy80cq+RcJ
	 /hZaAfLI9xCnIEVOCmvjhNtnNI/ifp5K6VMbeL9Y=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 01D0CF800C9;
	Thu, 16 Mar 2023 00:32:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4C99AF80423; Thu, 16 Mar 2023 00:32:49 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 98BFBF8016C
	for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2023 00:32:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 98BFBF8016C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=dqMxL3vo
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 1971CB81FA0;
	Wed, 15 Mar 2023 23:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99523C4339E;
	Wed, 15 Mar 2023 23:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678923159;
	bh=V/Z0f0cZlAcswOoBOoDprpItQqPHofsay60H0vvm0Zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dqMxL3voxxPS/gEtwwSlDtEng6i+Y8KE5fM7BT/4jS5M/8FyqLJ7IxDXWZ0T3PfFi
	 vaI/iYzea5Ehgfyjah3ERGyqr/PKsTUrKsflTUyxCs/JzCH0U/1cBH34l7CZT5lZlD
	 DcdTZF3wTDDNm0FiuqLRujbqBwKWKbP748E2YIgyhuTQe5DR5uH96xGPzIDnVdX0kU
	 r/MQWBQ9KS1Plj6NBkJ++vnDe35mduwy23Fa/dmS/sAYyQrW54A0b3IwweA6GOXq6f
	 7G8pzr0HGdz1c5RttOPcqUxzfIX0/LWEZ19ZTf5mOnNwE/UggVss01rCkja15i/+yh
	 vEE9607uCKLCQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Jassi Brar <jassisinghbrar@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	devicetree@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Gross <agross@kernel.org>
Subject: Re: (subset) [PATCH v2 1/7] arm64: dts: qcom: ipq6018: align RPM
 G-Link node with bindings
Date: Wed, 15 Mar 2023 16:35:11 -0700
Message-Id: <167892332564.4030021.5571390998634849737.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230208101545.45711-1-krzysztof.kozlowski@linaro.org>
References: <20230208101545.45711-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID-Hash: J66YNRUNX72IQPEUYJTPTDZ7TVTUXKUE
X-Message-ID-Hash: J66YNRUNX72IQPEUYJTPTDZ7TVTUXKUE
X-MailFrom: andersson@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/J66YNRUNX72IQPEUYJTPTDZ7TVTUXKUE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 8 Feb 2023 11:15:39 +0100, Krzysztof Kozlowski wrote:
> Bindings expect (and most of DTS use) the RPM G-Link node name to be
> "rpm-requests".
> 
> 

Applied, thanks!

[5/7] dt-bindings: soc: qcom,apr: correct qcom,intents type
      commit: b5bec0f00ee1c52ff0965a5dba4c91c413a6f3de

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
