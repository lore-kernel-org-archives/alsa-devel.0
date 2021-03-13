Return-Path: <SRS0=P760=IL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13F3C433DB
	for <alsa-devel@archiver.kernel.org>; Sat, 13 Mar 2021 23:25:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA4664ED1
	for <alsa-devel@archiver.kernel.org>; Sat, 13 Mar 2021 23:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA4664ED1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C75931734;
	Sun, 14 Mar 2021 00:24:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C75931734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615677906;
	bh=4ynmc7CEQ1sn1i9gKtGzBb31X7OhkMfF6cOCZulEKds=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TSyjryRBm4Cckhol5j6WDjxosbO+IoNHpBgFwXuAEwLQ6tyWfs5Wd19hFujmDpmq6
	 pwC+WYv2TjgtbMys8SFYqQOipNEnCg01Rzf9eTO4vCX9v6aodv0KxVTZ/KYl03Cahh
	 PFdAla+u8L8pjBWqEVD+uVXApVDE2AzColUPaie4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3BAC1F8019B;
	Sun, 14 Mar 2021 00:24:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 73E63F80227; Sun, 14 Mar 2021 00:24:15 +0100 (CET)
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1234::107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4F969F8012A
 for <alsa-devel@alsa-project.org>; Sun, 14 Mar 2021 00:24:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4F969F8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="TlzMrUWL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
 Reply-To:Cc:Content-ID:Content-Description;
 bh=bjTkDYY2S47W+dOwH7RhQ+iYh/NtHasQ+4FwEjODBck=; b=TlzMrUWL1xPkqHMoahUKjApRlE
 EBdmu/rXygCPYBfAHTuPJWjO1wvTnNj3hCZ7kqm4VosmLUOa5phIbrrjn77xe//uQDRPEtvPxDe8m
 MmuwooLijFxhaG4JI1oudU4bC6Od9fgSUeutUtW44PxwVWA8u9dh/OSn44jYQQ4J875Ua5F7HycaG
 6qUjXZ4epTwK4RuLZ5RcRcOnjoZkGojimzW0xyANw1WqfWNVHPSkHh832NnoeHARTyWMfgoPoOYsB
 gWLyLiE1iE9MBbShGTyVDhKZkZgcAJlxr71pawmXDy5ZG8yJyjFTZ74z0qtBhGzjxvQxE2VviQKzl
 MHxishjA==;
Received: from [2601:1c0:6280:3f0::9757]
 by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lLDc2-001A31-0P; Sat, 13 Mar 2021 23:24:02 +0000
Subject: Re: [PATCH] docs: devicetree: bindings: sound: Fix a typo in the file
 rt5682.txt
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>, lgirdwood@gmail.com,
 broonie@kernel.org, dt@kernel.org, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210313231850.17278-1-unixbhaskar@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <08789a65-5159-8658-5fc8-6f6e6efe3e27@infradead.org>
Date: Sat, 13 Mar 2021 15:23:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210313231850.17278-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 3/13/21 3:18 PM, Bhaskar Chowdhury wrote:
> 
> s/drving/driving/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Documentation/devicetree/bindings/sound/rt5682.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/rt5682.txt b/Documentation/devicetree/bindings/sound/rt5682.txt
> index 9c5fadb6ac82..cd8c53d8497e 100644
> --- a/Documentation/devicetree/bindings/sound/rt5682.txt
> +++ b/Documentation/devicetree/bindings/sound/rt5682.txt
> @@ -44,7 +44,7 @@ Optional properties:
>  - realtek,dmic-delay-ms : Set the delay time (ms) for the requirement of
>    the particular DMIC.
> 
> -- realtek,dmic-clk-driving-high : Set the high drving of the DMIC clock out.
> +- realtek,dmic-clk-driving-high : Set the high driving of the DMIC clock out.
> 
>  Pins on the device (for linking into audio routes) for RT5682:
> 
> --


-- 
~Randy

