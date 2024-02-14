Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B97C48BC1
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Feb 2024 17:59:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7EBC386F;
	Wed, 14 Feb 2024 18:58:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7EBC386F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1707933544;
	bh=8XAR8VG6+3dDOUtJ+wKBf06KI2MpuezZuwn0g6OrdIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=E8q13NMEiQtt448hVM5wGGbDpKsAjswX2F0Ab9usiRjrb2UFjmnAGKJ6xcc+HyvXg
	 7gWyVDxXrGWKjS6Rxtx0kEETkwSarNhi2wDBYJr5mrYK6l9ayKaq2339aJLe+3pMz4
	 ASk1hs3HkCYCC5JVl1exQ3azaTWx6vSaGe81uQe4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 610AAF805AB; Wed, 14 Feb 2024 18:58:28 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C4996F80589;
	Wed, 14 Feb 2024 18:58:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 923A3F80238; Wed, 14 Feb 2024 18:58:23 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 853ACF800EE
	for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2024 18:58:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 853ACF800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=LyG83SQn
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E6DBD61B7D;
	Wed, 14 Feb 2024 17:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E851DC433C7;
	Wed, 14 Feb 2024 17:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707933494;
	bh=8XAR8VG6+3dDOUtJ+wKBf06KI2MpuezZuwn0g6OrdIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LyG83SQnZqpk6BNacTJdo/v/XFn1rd2KEdMJqcL6s5ARj4ygwmLCN+Dbi2w8ZCufy
	 EuApGzQuthxXoGFW+DowmqVNq7msqZ4vEe6cQH8AV/M9FAGWGISElLH4Av0LuN5F87
	 mN+X2FGbG3M7ycXLA1zrOJO5LlrKE/wQlqvzIF7ClEaS1hUA+YtqUOyalMCa+ab/9c
	 JNgasX+yu7QJoZMf49ToQLnh+2hw10aQYfYHpeY32N+AC0XYSm0FcWl2keIavJsYlk
	 /nDngg1C+yFSfnLU3G2o8cMEFniLI+RApZT2zQS4qVUNj1InYMoKwSYPHxT1KSZ84y
	 z246+ZSOz72ww==
From: Bjorn Andersson <andersson@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>
Cc: alsa-devel@alsa-project.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] soc: qcom: apr: make aprbus const
Date: Wed, 14 Feb 2024 11:57:42 -0600
Message-ID: <170793345820.27225.42969581094596997.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213-bus_cleanup-apr-v1-1-50c824eec06d@marliere.net>
References: <20240213-bus_cleanup-apr-v1-1-50c824eec06d@marliere.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID-Hash: IBUE4LBKA2ILCY5AAQ557OGAKS3J26HS
X-Message-ID-Hash: IBUE4LBKA2ILCY5AAQ557OGAKS3J26HS
X-MailFrom: andersson@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IBUE4LBKA2ILCY5AAQ557OGAKS3J26HS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Tue, 13 Feb 2024 11:44:01 -0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the aprbus variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: apr: make aprbus const
      commit: d2e8899de71cd0a3c22a0eadfb9d54604d34eb96

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
