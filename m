Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48407CD4F3C
	for <alsa-devel@archiver.kernel.org>; Mon, 18 May 2026 12:03:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0FC816020E;
	Mon, 18 May 2026 14:02:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0FC816020E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779105787;
	bh=x6CYfNWjvjQv3HJzv4ikNQ5ma1+9J3bx6JaQCwy5UlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=dW1QnbI9M8fmAQi9DbLGJ14UtD/fSMQX+T5wPyZwSDj5EZ4saITWKxB44lVTxM9LM
	 2zqOteWwTvksnKXLRsdym/aQmwpeNXxNnXehl34KCUW3iSmNhj/DoWkQkDySGkd9tf
	 sPKD4DXreD2oniLyUv3hNKz6dn9DKvPhlXAAoi+Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 535ABF805F1; Mon, 18 May 2026 14:02:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C8E3DF805EC;
	Mon, 18 May 2026 14:02:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 50826F804F3; Mon, 18 May 2026 14:02:24 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 85308F80169
	for <alsa-devel@alsa-project.org>; Mon, 18 May 2026 14:02:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 85308F80169
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=g5uRPqJF
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 54C1D60212;
	Mon, 18 May 2026 12:02:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CABC2BCB7;
	Mon, 18 May 2026 12:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779105739;
	bh=x6CYfNWjvjQv3HJzv4ikNQ5ma1+9J3bx6JaQCwy5UlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g5uRPqJFqMSnjpKtB44FV9kEOyE1OSxESjhaDeTbKnrirKUmwbGSSboo0C+ds/f84
	 5NsVod4nKW3XW/qI+5e0FWO4G6qom3I7W9kG06Q5L+CEAhxq8zRG0HQzNDgNkpYaxg
	 8/oSDoR7KIvAXxxC0D0d4m5udIwsCrC4Aq0AA/lDlirpk0yQj2HOvd2cC5X3pumhdF
	 kIRLg5JR9mrjEepmqfiugu1Uo2J93m0oMY24J9A2g4w6DxhOnwMGwGz/QC0JkQkXLV
	 HXUL0zNrJzSbxMyWzSdBXtiu4WI/Njd15LrRwA7RYWD17AU61x6ARYUmxveCHooM5R
	 kJiCGzIfJGAdw==
Date: Mon, 18 May 2026 14:02:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Neo Chang <YLCHANG2@nuvoton.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, robh@kernel.org, krzk+dt@kernel.org,
 linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 neo.chang70@gmail.com,
	kchsu0@nuvoton.com, sjlin0@nuvoton.com
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: nuvoton,nau8360: Add NAU83G60
Message-ID: <20260518-heavy-bear-of-camouflage-d7c89d@quoll>
References: <20260518024704.118613-1-YLCHANG2@nuvoton.com>
 <20260518024704.118613-2-YLCHANG2@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260518024704.118613-2-YLCHANG2@nuvoton.com>
Message-ID-Hash: 3C6OSJO7BQW7CAQTYAR2KZQTXGMUNGDP
X-Message-ID-Hash: 3C6OSJO7BQW7CAQTYAR2KZQTXGMUNGDP
X-MailFrom: krzk@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3C6OSJO7BQW7CAQTYAR2KZQTXGMUNGDP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, May 18, 2026 at 10:47:03AM +0800, Neo Chang wrote:
> Add device tree bindings documentation for the Nuvoton NAU83G60
> audio amplifier.
> 
> Signed-off-by: Neo Chang <YLCHANG2@nuvoton.com>
> ---
> Changes in v2:
> - Dropped the word "driver" from the description.
> - Removed runtime/software configuration properties:
>   nuvoton,low-latency, nuvoton,anc-enable, nuvoton,aec-enable,
>   nuvoton,vbat-microvolt, and nuvoton,tdm-channel-length.
> - Added missing "nuvoton,dac-cur-enable" property for static speaker impedance matching.
> - Removed unnecessary '|' formatting from single-line descriptions.
> - Fixed typo in firmware-name property.

You didn't really...

git grep firmware-name

Best regards,
Krzysztof

