Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D43C04AB6
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Sep 2023 17:11:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 252E0A4A;
	Wed, 20 Sep 2023 19:11:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 252E0A4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695229916;
	bh=xORNwuaiBdlcQ+oz/AKk1EfwusQCgyC/d/Q/gfTmaU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VBbR5W/9lxg54UAU2zlw7gghX8TBAJQ8g23k1jPfkyVK9pXQX2FcLsLZpNW1uOCNn
	 CqzcRRQqTzdItCSurik4TUHVxwmDbn4VIrbQk5ArZHMtgPllItqbG8Y9v3rqrjTG5O
	 tcY74iu33nk2MMcOOK++wqPe4PPUa+3OIJOFDoq4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E9D92F80125; Wed, 20 Sep 2023 19:10:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 50DC6F8025A;
	Wed, 20 Sep 2023 19:10:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5DFD3F8025A; Wed, 20 Sep 2023 19:10:33 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AB4B7F800F4
	for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2023 19:10:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB4B7F800F4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=RZS/24/Q
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 02D8261D68;
	Wed, 20 Sep 2023 17:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC95DC433CC;
	Wed, 20 Sep 2023 17:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695229826;
	bh=xORNwuaiBdlcQ+oz/AKk1EfwusQCgyC/d/Q/gfTmaU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RZS/24/QW/PAWHVet8IANErdWPYhYCwLiWDv5voNPdKuENhv+/MB+NMMdDLzPrsYi
	 ZhWCZu1mafHxjdmuxK5Ahzuc1ayAciqkRdMxDEStvpS0v67puSIhhxKI8gSFxAud4u
	 Nu3/9wMoBGzpoRJVwdOheX9r///JXhL4gxleNjPP/69FTP5BduEIDvrFenmZQz2+eh
	 Ygcse9EN2+QZ4qj7CrTs/DywV+kQcriDLTbVNivqwkyH8fHKZfD8G7CAVK74HC6RsL
	 Alz5dplmfwNU7HdOZ0aGwgabFDN8DhmjEEskQLkpKfQodBA6V5eKPcurrMn7SWJBwe
	 LCLFqGEaS0rNw==
From: Bjorn Andersson <andersson@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Stephan Gerhold <stephan@gerhold.net>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Otto=20Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Subject: Re: (subset) [PATCH 0/6] ASoC: codecs: msm8916-wcd-analog: Cleanup DT
 bindings
Date: Wed, 20 Sep 2023 10:14:12 -0700
Message-ID: <169523004961.2665018.6811007282234942362.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230718-pm8916-mclk-v1-0-4b4a58b4240a@gerhold.net>
References: <20230718-pm8916-mclk-v1-0-4b4a58b4240a@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID-Hash: B2VGT3VNH33K27E3AFT5LTGO6FSN77L2
X-Message-ID-Hash: B2VGT3VNH33K27E3AFT5LTGO6FSN77L2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/B2VGT3VNH33K27E3AFT5LTGO6FSN77L2/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Tue, 18 Jul 2023 13:40:12 +0200, Stephan Gerhold wrote:
> Drop the redundant reg-names and mclk from the PM8916 analog codec.
> Having the mclk on the analog codec is incorrect because only the
> digital codec consumes it directly.
> 
> 

Applied, thanks!

[6/6] arm64: dts: qcom: pm8916: Drop codec reg-names and mclk
      commit: c7b34291bb376598ea4279658bf3100c8cb1487b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
