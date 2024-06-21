Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CEDC27C4F
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Jun 2024 10:01:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A9876A4B;
	Fri, 21 Jun 2024 12:01:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A9876A4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1718964070;
	bh=yIT38m0X5h/xAUdgyo6UZokPqNben8J1c7EywYPzAcw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=cqX76A+3DDdVFCz4ADTi7Tq2tCDjrDRmth3ohVTFWYMQlJWCU15ynFZziMNaOCThB
	 QqU6f8j7sQgJ3CdA5hw5G/JnoFTsDV68vajouwKeD3vBYtbhyUeH45ymsubQMj5/mt
	 2uR5RAWRIHG4EONES2y7BN/Q+EfP/VAavzFJzlbc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 89F7AF805B4; Fri, 21 Jun 2024 12:00:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 194A9F805AA;
	Fri, 21 Jun 2024 12:00:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DD908F8023A; Fri, 21 Jun 2024 11:58:33 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E5F1DF800ED
	for <alsa-devel@alsa-project.org>; Fri, 21 Jun 2024 11:58:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E5F1DF800ED
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=mlSNNs7R
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A934E624F1;
	Fri, 21 Jun 2024 09:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811E9C2BBFC;
	Fri, 21 Jun 2024 09:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718963907;
	bh=yIT38m0X5h/xAUdgyo6UZokPqNben8J1c7EywYPzAcw=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=mlSNNs7Rcj3RJam78NY9YP8LdXzuuBK4GaRNqDpQ8ljcb35Us/tDqm8D5OoE7S+cl
	 Aw57zgrvYhInOBxlEvWqOndAJZbOCSqhWYx9fvDjTPlgS3BtG0VIDg1lYtqKhKcw05
	 1igAuhzrobVoClbgEZdhLgHh5S9HpnHszFglGULr6UMaREeojNxhYZSyfjNDWRVK9e
	 e/vqOHhl1gmfnVuqcowBYJ6nGQtztm/zq++dEPUiZ3A50k//7j+Q9nuUwJSSOIDesa
	 cxZoNKBDJIpeuiAUjfu3EovMylZi4HoYgZ+SoTeXyqWTd0jozkiG+I3datYGJdW4Qk
	 ARBLZDFKR1stA==
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240620091046.12426-1-krzysztof.kozlowski@linaro.org>
References: <20240620091046.12426-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] soundwire: bus: simplify by using local slave->prop
Message-Id: <171896390510.263874.7819997619365288749.b4-ty@kernel.org>
Date: Fri, 21 Jun 2024 15:28:25 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
Message-ID-Hash: DWZM6NJ5SICLBUUO35GVSSDCEZB7PD6K
X-Message-ID-Hash: DWZM6NJ5SICLBUUO35GVSSDCEZB7PD6K
X-MailFrom: vkoul@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DWZM6NJ5SICLBUUO35GVSSDCEZB7PD6K/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Thu, 20 Jun 2024 11:10:46 +0200, Krzysztof Kozlowski wrote:
> The sdw_initialize_slave() function stores 'slave->prop' as local 'prop'
> variable, so use it in all applicable places to make code a bit simpler.
> 
> 

Applied, thanks!

[1/1] soundwire: bus: simplify by using local slave->prop
      commit: 5a4c1f0207d8925c45a516d8dc85f0dd70c020ef

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>

