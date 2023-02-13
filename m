Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D228C636CC
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Feb 2023 22:22:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 64003836;
	Mon, 13 Feb 2023 23:21:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 64003836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1676326957;
	bh=IgFSxGVW+g4L3K+r5WNLqzfyj/9O8AXEX7jeT9PfUOE=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=sCskUqYw2K1P69jusA/cC3xjHv14bQyTT6CBkKo/fnyVGsWzTpRsMgU44xqPprWU0
	 xwQ6qkSdOHh/0351SJkq8MZJVU7V30iwaGsS2tKOeaw07lWr198U8Yr3JpvpqYYd6+
	 tJeUei4wrlDDBzrWgSrU5KtZK6EyGI+ttfmzHM5A=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C4E61F804B4;
	Mon, 13 Feb 2023 23:21:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BB87AF804B4; Mon, 13 Feb 2023 23:21:18 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 46AF4F80051
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2023 23:21:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 46AF4F80051
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=B2s4hik6
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 66185B81996;
	Mon, 13 Feb 2023 22:21:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D05C4339B;
	Mon, 13 Feb 2023 22:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676326867;
	bh=IgFSxGVW+g4L3K+r5WNLqzfyj/9O8AXEX7jeT9PfUOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B2s4hik6PHKM+c/6j3z6QeIYoHCzVPGfa6WFsZQ5G1nb7Z0RSf6qJMzdCN+TqwfbK
	 ylSba7C7OE2sHg4S7YJAv2wOUGj5TsjIXQ8bsF8ZIC/Vd3KIXLUHz8rv1o457AkUk/
	 ZhPjAWnu2aXkaKXuW9B9bwg5VLCT7RtljaLll4bQvuJar7Y6C9M+E8+YRKenC+8CbN
	 ZYoOqebjix/PvkILYwB/AXgmgQfQU/NvzLQ+4GaYSI7UB/brBNINyPrtMPHsq183Za
	 XlTw0kAZ9Q8guVZOYV6MsV/ZQ9XUo3JdnH4dljROaIzzn33Ilhl6eeLJaMshbJxzIa
	 1Sq4TV2hLr/gA==
From: Bjorn Andersson <andersson@kernel.org>
To: linux-remoteproc@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Banajit Goswami <bgoswami@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	devicetree@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: Re: (subset) [PATCH v2 1/7] arm64: dts: qcom: ipq6018: align RPM
 G-Link node with bindings
Date: Mon, 13 Feb 2023 14:23:03 -0800
Message-Id: <167632698311.557014.8382168807767874732.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208101545.45711-1-krzysztof.kozlowski@linaro.org>
References: <20230208101545.45711-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID-Hash: EHBL5TLYM6QH74RWXCAJIIWM6AAMDFOI
X-Message-ID-Hash: EHBL5TLYM6QH74RWXCAJIIWM6AAMDFOI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EHBL5TLYM6QH74RWXCAJIIWM6AAMDFOI/>
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

[1/7] arm64: dts: qcom: ipq6018: align RPM G-Link node with bindings
      commit: 679ee73bbee28cab441008f8cca38160cc8f3d05
[2/7] arm64: dts: qcom: qcs404: align RPM G-Link node with bindings
      commit: 7bf30eb441b3bdaa368e65837a03f9fbba033180
[3/7] arm64: dts: qcom: msm8996: align RPM G-Link clock-controller node with bindings
      commit: 407ef897bd0275e38ae33d410857e71c092679bd

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
