Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8490C19F32
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Mar 2025 07:00:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 303FB602F6;
	Wed,  5 Mar 2025 08:00:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 303FB602F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1741158039;
	bh=UnMrf3hwWP656jVdFqfjePZCqUTf7O+8jLhTLHLlQCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rOdZ2UGh79E7KNM/Io5ZwAD7VqozEb4JxYE4z0HrKjRqcmUNKk28a0cG/k/MfFD8y
	 0FPJGdpq0hp253MGuVWu7h2pwlxAprLXEmat/Jg3fXCin5ELYLAlUodxyAvrkSz5nF
	 t1bEnoXBxc2IwVI73rx1uQnY43Itn3g19dbd2pOk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 30FF4F805CA; Wed,  5 Mar 2025 08:00:05 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 19705F805C1;
	Wed,  5 Mar 2025 08:00:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 58BA2F80517; Wed,  5 Mar 2025 07:59:53 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9F2E4F8001D
	for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2025 07:59:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F2E4F8001D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=sQzjRI0J
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 300A9A44ED7;
	Wed,  5 Mar 2025 06:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64C8C4CEE2;
	Wed,  5 Mar 2025 06:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741157987;
	bh=UnMrf3hwWP656jVdFqfjePZCqUTf7O+8jLhTLHLlQCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sQzjRI0JKfGv7ExdP8oZzO3kvepg23+XABIl3jd0Qcb1XfnZbHYZXmnsNIgEFNZsM
	 TAjv+zLnt3ggQTcmrQ0OpyMyyNkutIBib0nb3yFLqeqJeUT6miFONmaPAkcoyIpxM9
	 E5nuaaj4Te12OVjZIqNVzgur5iir+OFoV8efPrPdyNSmHfXLe9rZm74Yqt8ijDMf7a
	 bNNDHObiy3WQLnHwzGSSkMrwTBaMkLhf70Si4OU5bGp48gto9FnhcJzPU3/Iz1jtDn
	 GtHsNRfoK5SebKHlwWJcdhYrvnPMrD/dRsFSXQEFT973t83waP9kQ8341/CvDEXp78
	 3w+e8bVjRljUQ==
Date: Wed, 5 Mar 2025 07:59:44 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Zhang Yi <zhangyi@everest-semi.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org,
	devicetree@vger.kernel.org, tiwai@suse.com,
 amadeuszx.slawinski@linux.intel.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Subject: Re: [PATCH v4 2/2] ASoC: dt-bindings: Add Everest ES8389 audio CODEC
Message-ID: <20250305-quiet-upbeat-chamois-5e5ce2@krzk-bin>
References: <20250304114751.54635-1-zhangyi@everest-semi.com>
 <20250304114751.54635-3-zhangyi@everest-semi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304114751.54635-3-zhangyi@everest-semi.com>
Message-ID-Hash: 3HEMYIR7US4GUSBX354ET2DTKGWZNUQV
X-Message-ID-Hash: 3HEMYIR7US4GUSBX354ET2DTKGWZNUQV
X-MailFrom: krzk@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3HEMYIR7US4GUSBX354ET2DTKGWZNUQV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, Mar 04, 2025 at 07:47:51PM +0800, Zhang Yi wrote:
> Add device tree binding documentation for Everest ES8389 which
> is different from ES8388
> 
> Signed-off-by: Zhang Yi <zhangyi@everest-semi.com>
> ---
>  .../bindings/sound/everest,es8389.yaml        | 83 +++++++++++++++++++


NAK, you just ignored entire feedback.

Best regards,
Krzysztof

