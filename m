Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D22E706FD
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Sep 2023 09:39:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F2099F6;
	Thu, 21 Sep 2023 11:38:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F2099F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695289178;
	bh=94iskBoc6V/PnxsBaXf75S6qQ4CxvGzdNsAZ1gka2mg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=YMWuPn8I//PSRQ5csjU6hCTAFZsHwQLFCMgrQP4mbjbzrPiqLr/tZpQKurbz98Qs0
	 OB5Jfy7HbxEDEM7+p0fIlPLXLtSVYYsC7tbYAAGhx+k5/rehlrB53ZS/zXe06PldHs
	 +Yav910zYedE4JT08WH7KBoPdat80+DPqrzS4KwY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 31A3BF80494; Thu, 21 Sep 2023 11:38:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4A368F80549;
	Thu, 21 Sep 2023 11:38:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 05F0AF8025A; Thu, 21 Sep 2023 11:38:15 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 40122F80124
	for <alsa-devel@alsa-project.org>; Thu, 21 Sep 2023 11:38:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 40122F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=PINsPSLH
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 301C561EA7;
	Thu, 21 Sep 2023 09:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACB6C32780;
	Thu, 21 Sep 2023 09:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695289085;
	bh=94iskBoc6V/PnxsBaXf75S6qQ4CxvGzdNsAZ1gka2mg=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=PINsPSLHMNW0Ir2cAkCHqaAQHo2ZkKI28ArKcJ42NTjFW8szAXnJE3hoJFYG61AUj
	 3xSpLYDx43ZvVcIj1MWn3tJzUgJfwSA7TFYG1qWIdUgd4m5LTuGUIOJq8RsqsJxDLK
	 sbYPAbfsdrZ9CQ8xRCaa5+Qe8Hmr5eNM83M17mAdBF+ERS2Z7kbTMKYx/LpCCj5q8w
	 4l+SuoWZGo6GtlIZYz5gTkDIPZjclLuS1BX/FLvE3okRFHwdaS41YbP7jr9SyY73RY
	 RAA22XSshN5HVtn5WmBy3iN5Vrc3ZVJMjyRd4U/luHgQQ5xTtF+CJzAW68Cp95AqWX
	 hTS84DsY5VdcA==
From: Vinod Koul <vkoul@kernel.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728112848.67092-1-krzysztof.kozlowski@linaro.org>
References: <20230728112848.67092-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] soundwire: qcom: use newer link status tregister
 on v2.0.0
Message-Id: <169528908296.97319.1848948668643094291.b4-ty@kernel.org>
Date: Thu, 21 Sep 2023 11:38:02 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
Message-ID-Hash: TACELJJAVH2WAW52EQETHUSZYCX3HBFM
X-Message-ID-Hash: TACELJJAVH2WAW52EQETHUSZYCX3HBFM
X-MailFrom: vkoul@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TACELJJAVH2WAW52EQETHUSZYCX3HBFM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Fri, 28 Jul 2023 13:28:47 +0200, Krzysztof Kozlowski wrote:
> Soundwire v2.0.0 comes with a new register LINK_STATUS for the
> FRAME_GEN_ENABLED field (bit indicating that an active frame is
> running).  The old register COMP_STATUS is still there and still works,
> although the new one is preferred in downstream sources.  Probably
> because it allows to choose Soundwire instance per CPU.  Most of the
> code allowing to use new register for Soundwire v2.0.0 was already there
> as part of commit 312355a6a9f6 ("soundwire: qcom: add support for v2.0.0
> controller"), so switch to it in swrm_wait_for_frame_gen_enabled()
> function.  This should not have functional impact, because the old
> register still behaves correctly.
> 
> [...]

Applied, thanks!

[1/2] soundwire: qcom: use newer link status tregister on v2.0.0
      commit: 5d78c7d684192e42241593a936ee60003d8ac064
[2/2] soundwire: qcom: handle command ignored interrupt
      commit: 16d568c8f646933710c980783d87d3f59a89b563

Best regards,
-- 
~Vinod


