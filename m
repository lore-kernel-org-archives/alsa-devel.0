Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08546C47DAF
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jan 2024 08:28:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A18520E;
	Mon, 22 Jan 2024 09:28:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A18520E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1705912102;
	bh=lBFgz2wmn8cEi5y1vg4jI0P+TneucWVXyyuYbQ64/20=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=tFan8694x0/DtaXIdISKZye9hYOoKGHfWf3l/isUXw8q1tiyZPwWhobFKoWDdIQrP
	 qRFAP5PIXYJwpHEBPiBx0zbO6Eo4d5LfPgpvCMmCUdhLxw4gTnQcSl012MKfZjJ1ib
	 ELDRiKWJiwfkM+G+443smjtkeQqpyC+r0VKoL7bA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3E567F8057C; Mon, 22 Jan 2024 09:27:46 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EE8DAF80580;
	Mon, 22 Jan 2024 09:27:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F2440F8025F; Mon, 22 Jan 2024 09:27:39 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DB0C0F8020D
	for <alsa-devel@alsa-project.org>; Mon, 22 Jan 2024 09:27:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DB0C0F8020D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=b5QNG5R3
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 84EF1CE219C;
	Mon, 22 Jan 2024 08:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3D0C43390;
	Mon, 22 Jan 2024 08:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705912048;
	bh=lBFgz2wmn8cEi5y1vg4jI0P+TneucWVXyyuYbQ64/20=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=b5QNG5R3IbaJpXLZoJV8kUkdPiznstDxQhuBa9X5bSxsPZ3jw3aQbJXQVtKbg/kUa
	 tlvOKQpBeM5vHcmEguCY0hv6mdrwa76rVna3PifOlu7SiqsPp4TfZOd590djQpupyE
	 zXWz1MfXpCeSH34EHFjqSHRYNPjH85qcJyGyPaqAEAZM8GDwyCLfqSrpKEjxSdbmyp
	 8geRVmqIB8oZBVAXC9tjzXPUusgAtYUTB4FG2RVci1epuCCa2BR68KHhXkMmgpGAvQ
	 rVYGYXGiG0j+kbttKgyREhoGTNPqbfOIuFmy0S8gYAf7LsyS6ZqGkRoMln5+b19EH1
	 IVKmckkQkA1oQ==
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240117160639.1327266-1-krzysztof.kozlowski@linaro.org>
References: <20240117160639.1327266-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] soundwire: stream: add missing const to Documentation
Message-Id: <170591204572.231468.12374563970048661834.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 13:57:25 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
Message-ID-Hash: J6ZPLWS22TYQG4RCIHFXGTQONN5UOLVQ
X-Message-ID-Hash: J6ZPLWS22TYQG4RCIHFXGTQONN5UOLVQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/J6ZPLWS22TYQG4RCIHFXGTQONN5UOLVQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Wed, 17 Jan 2024 17:06:39 +0100, Krzysztof Kozlowski wrote:
> Commit 21f4c443731f ("soundwire: stream: constify sdw_port_config when
> adding devices") added const to sdw_port_config argument, but forgot
> documentation.
> 
> 

Applied, thanks!

[1/1] soundwire: stream: add missing const to Documentation
      commit: 0707496ff4e416ea08c90053fd5fde5811b11b22

Best regards,
-- 
~Vinod


