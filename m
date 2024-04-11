Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885C0C4345F
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Apr 2024 17:49:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C5C3D2BC6;
	Thu, 11 Apr 2024 19:49:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C5C3D2BC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1712857781;
	bh=+xGai2+yQRuwJxV3vruDN127Ywqk6sjQlpgvB62GDC0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=H06HY4jht7Lzid7TFJvDJwNGEo+jb11v3wULjnv8jFvyPTHixd2ksmn9VfAa+kPVF
	 bRtyQ30OLD6QyQr7iQufNcKY1VhVYF4Q/eINkpjrhCSD6ZPD8hZqsODkx14BQjSFCq
	 E8137GTR++Es2Y0U7JAVzJjfgRM6WMqcY6r9J8FE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 71D5BF805D3; Thu, 11 Apr 2024 19:49:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6EEC3F805D4;
	Thu, 11 Apr 2024 19:49:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F31D2F8026D; Thu, 11 Apr 2024 19:48:54 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6F2FFF80236
	for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2024 19:48:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6F2FFF80236
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=s/gHjecz
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 433D562104;
	Thu, 11 Apr 2024 17:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A5BC113CE;
	Thu, 11 Apr 2024 17:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712857729;
	bh=+xGai2+yQRuwJxV3vruDN127Ywqk6sjQlpgvB62GDC0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=s/gHjecz3MF1Jb2zrk0vs01JvLf/r7UbyG0tYD6S8t6zcAeWzxwgkflgdv+JaBUxm
	 gPPbJf9zFuQZdg87TCYvk8hhMnzmkrJAYcz5Dd+oOkHpkSzw8jxzxNit3qrbSVfQc3
	 0Qz5xJL4jjMt1wcAQyIlVF+/wl7rnQsKZWaSBTSuUg8vzRw7ZQqpPnabkpiSkQ9P4f
	 pWydTIK8Fdm7kHSpUjHUJdMx/kJ3jSu1IGTOLPkZ+TN9mdNRYEFqWAGDnrHCQZT8F0
	 gVHZisYtQOm3Rk+AVAbhyrryJwRTipgsUsFB8CFN2jFu7jIzX/A2Azj8ZlJHjIzlVj
	 JV+XUPutiYz0Q==
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
In-Reply-To: <20240405144141.47217-1-krzysztof.kozlowski@linaro.org>
References: <20240405144141.47217-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] soundwire: qcom: allow multi-link on newer devices
Message-Id: <171285772650.544231.3543346756872331188.b4-ty@kernel.org>
Date: Thu, 11 Apr 2024 23:18:46 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
Message-ID-Hash: PNKVTATCUA4RIJJBTRYWVKW5PLH2KKZM
X-Message-ID-Hash: PNKVTATCUA4RIJJBTRYWVKW5PLH2KKZM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PNKVTATCUA4RIJJBTRYWVKW5PLH2KKZM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Fri, 05 Apr 2024 16:41:41 +0200, Krzysztof Kozlowski wrote:
> Newer Qualcomm SoCs like X1E80100 might come with four speakers spread
> over two Soundwire controllers, thus they need a multi-link Soundwire
> stream runtime.
> 
> 

Applied, thanks!

[1/1] soundwire: qcom: allow multi-link on newer devices
      commit: ce5e811e069168898ae2ff02a90de68637ed7dc4

Best regards,
-- 
~Vinod


