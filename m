Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D79EB64DA
	for <alsa-devel@archiver.kernel.org>; Sat, 22 Jul 2023 05:21:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9679D1F7;
	Sat, 22 Jul 2023 07:20:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9679D1F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690003291;
	bh=l2etnZvJ9/hffs2X1dtEQe8kxdMzW6IwoomkjJCKvgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ZWC+ujD6QyyuY+uDUqWfzgYj79eevvp0GCrQtBzYnohFWZelVXvdvqpGoqVJBNo5q
	 Tc4ycl3XYdzcFF1sxdXR4UpIoIT1f+2sC8KbiWSX35so0Y0KJjvq8xrekSAD41H03V
	 XC4bElJJynF15kiaTznNHWlygKIvvumD4hLpdeDY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CA4F2F80520; Sat, 22 Jul 2023 07:20:34 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7BCC0F8047D;
	Sat, 22 Jul 2023 07:20:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5F77BF8047D; Sat, 22 Jul 2023 07:14:26 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E3B58F80153
	for <alsa-devel@alsa-project.org>; Sat, 22 Jul 2023 07:14:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E3B58F80153
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=oRwMosP0
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C99A660AFB;
	Sat, 22 Jul 2023 05:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624E7C433C8;
	Sat, 22 Jul 2023 05:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690002849;
	bh=l2etnZvJ9/hffs2X1dtEQe8kxdMzW6IwoomkjJCKvgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oRwMosP0cDm7zISdBQOn5gTODekBtT5qZz2mJEqGhRgUtMP6QjQQLpvyZYye9a8qw
	 JqpqPxO1QQ4A8REvqUaAFGBaPV5ae1A6m3KQWMWzrLHW4C3JPG6Woyijf5mbIRLuPs
	 DE77/Fp+akBc3kwP+1RHcDuTd1ovzKN4ikiOASfi6gXjdOn419XPdmMdHHompNMSQc
	 DyZ0StHl3a2SR5l4ZAK6ysqAo7GmX9lyd9VlS+K9GFCVLCcIbBETS5VFnbEn7AEezf
	 o4pB76MUH2ElP7ehWRMTYocFo3TxU54F26V1bZIcVPOHua6ipyWD6RwQG5rX9IV3e5
	 KoI3e2DF+X1uA==
From: Bjorn Andersson <andersson@kernel.org>
To: cros-qcom-dts-watchers@chromium.org,
	Andy Gross <agross@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Benjamin Li <benl@squareup.com>,
	James Willcox <jwillcox@squareup.com>,
	Joseph Gates <jgates@squareup.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Zac Crosby <zac@squareup.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Xu Yang <xu.yang_2@nxp.com>,
	Peng Fan <peng.fan@nxp.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Jun Nie <jun.nie@linaro.org>,
	Max Chen <mchen@squareup.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Vivek Gautam <vivek.gautam@codeaurora.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Knecht <vincent.knecht@mailoo.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	alsa-devel@alsa-project.org,
	iommu@lists.linux.dev,
	linux-usb@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Leo Yan <leo.yan@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Andy Gross <andy.gross@linaro.org>
Subject: Re: (subset) [PATCH 00/11] Even more msm bindings fixes
Date: Fri, 21 Jul 2023 22:17:08 -0700
Message-ID: <169000304212.3611206.847521612980089108.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
References: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID-Hash: SKJRLAPDJJWOW42QH2EF2UVRWAMOCXVM
X-Message-ID-Hash: SKJRLAPDJJWOW42QH2EF2UVRWAMOCXVM
X-MailFrom: andersson@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SKJRLAPDJJWOW42QH2EF2UVRWAMOCXVM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Tue, 27 Jun 2023 18:24:16 +0200, Konrad Dybcio wrote:
> This series contains couple more random dt schema warning fixes, centered
> around linux-msm.
> 
> All of the patches (except) the last two are pretty much independent.
> Patch 1 is not only a bindings fix, but also a functional one.
> 
> 
> [...]

Applied, thanks!

[09/11] dt-bindings: arm: msm: kpss-acc: Make the optional reg truly optional
        commit: 981be238e1d28e156aa9da2a8722f86f02fd0453

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
