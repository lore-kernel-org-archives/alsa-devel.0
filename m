Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE5DCF31BE
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Oct 2024 05:55:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6FA2A857;
	Thu,  3 Oct 2024 07:54:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6FA2A857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1727934905;
	bh=ULDx9MnTQFEQueJG7rMq8r5HkqESyvZYSyaLNLHVDrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=YaKyuOgZicICYaRT/YOs2Q8ByVHPc/11P6ZyZT4a238GA2InU+MRko/oVIn3TwCy4
	 9gzIFus7T631/gTRY5MAVqhmmR+Oz0CNEQbnrDFVp/2Rf3cCjlwC6Ro5Mr90rLc9sg
	 rzhEY/yBeNvPGRM6WpRY+GTdPuFVowLXpfskbJN0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C8074F805B4; Thu,  3 Oct 2024 07:54:34 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 036F7F80517;
	Thu,  3 Oct 2024 07:54:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1D3C3F80517; Thu,  3 Oct 2024 07:54:26 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EA648F8001E
	for <alsa-devel@alsa-project.org>; Thu,  3 Oct 2024 07:54:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EA648F8001E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=cNTZkpj0
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 71014A431B8;
	Thu,  3 Oct 2024 05:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED539C4CEC7;
	Thu,  3 Oct 2024 05:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727934861;
	bh=ULDx9MnTQFEQueJG7rMq8r5HkqESyvZYSyaLNLHVDrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cNTZkpj0XudqaYA3YD3CmJxHLdAiyLCj4ifT7NLBSxTX6yeqp0fK/T+LSbYp1imLD
	 Stl+9jttR66vaRoP1rmUP+1M5UJqugPsfMzKBLKo1OnihklffW1VH33xfkqs2ct2pb
	 8cnc5S9AB03XXScJxOCNhwIrqVnV9xDodpYCUnks=
Date: Thu, 3 Oct 2024 07:54:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gax-c <zichenxie0106@gmail.com>
Cc: srinivas.kandagatla@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
	perex@perex.cz, tiwai@suse.com, rohitkr@codeaurora.org,
	alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org, zzjas98@gmail.com,
	chenyuan0y@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: qcom: Fix NULL Dereference in
 asoc_qcom_lpass_cpu_platform_probe()
Message-ID: <2024100358-crewmate-headwear-164e@gregkh>
References: <20241002161233.9172-1-zichenxie0106@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002161233.9172-1-zichenxie0106@gmail.com>
Message-ID-Hash: 2C2B6QPQ5ZONLSJTYGDKU6XHDHU4KUUT
X-Message-ID-Hash: 2C2B6QPQ5ZONLSJTYGDKU6XHDHU4KUUT
X-MailFrom: gregkh@linuxfoundation.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2C2B6QPQ5ZONLSJTYGDKU6XHDHU4KUUT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, Oct 02, 2024 at 11:12:33AM -0500, Gax-c wrote:
> A devm_kzalloc() in asoc_qcom_lpass_cpu_platform_probe() could
> possibly return NULL pointer. NULL Pointer Dereference may be
> triggerred without addtional check.
> Add a NULL check for the returned pointer.
> 
> Fixes: b5022a36d28f ("ASoC: qcom: lpass: Use regmap_field for i2sctl and dmactl registers")
> Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
> Cc: stable@vger.kernel.org

Your "From:" line does not match your signed-off-by :(
