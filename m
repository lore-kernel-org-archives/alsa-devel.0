Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322B3C43334
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jun 2022 09:43:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 87AA816FE;
	Thu,  2 Jun 2022 11:42:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 87AA816FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654163013;
	bh=cpC2uDa8rAaDOpIKiFxrs+Qz+CtkwtKNP0DQQAXlAqw=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fwTdDeHCuadol0IZQNRND8090Wjz7Xn3mIQysFZrtXBEuHHZfr5IEuoSmBFkiTH1o
	 DOZX1yWUa8vkfERY3330JB/srhq78VmBvGquO1jUvIhKsG/4E2J9y6uFvROLt05WhT
	 DQcJFC0+1GxDO9hWKiraJuvnEjZbrZ7BDWPPTLyk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B654F80158;
	Thu,  2 Jun 2022 11:42:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3BAFAF80124; Thu,  2 Jun 2022 11:42:41 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C7009F80124
 for <alsa-devel@alsa-project.org>; Thu,  2 Jun 2022 11:42:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C7009F80124
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com
 header.b="do390E3o"
Received: from [192.168.0.109] (unknown [123.112.66.143])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 56FDE3F212; 
 Thu,  2 Jun 2022 09:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1654162951;
 bh=cpC2uDa8rAaDOpIKiFxrs+Qz+CtkwtKNP0DQQAXlAqw=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=do390E3ovLfp2IajyklTBUI06i2E+isByRNi4ISePe4qzXkuRjza1LlV4H6yG3oj9
 q9CCd5FAFRFMfMbgKSFNNiLlzOR3GRytTnSuLvHm6JbEHXqgy0FQZz+bY6fYGsa3BJ
 deWUZBvLf4pWfQRQxHlohZaFRyrCkx5rlst8bUpviQ9AgGJS4/eSyvHtfXp7c74bHJ
 nXnIXjP4AUePhE8oeYg6i51TsaVzY5sNOIF1x6zREpapWu6OWHm6lu91+pUfAclXe2
 72nwWIS3URqGZJ4Uj+2QQ4Qzm95EGkv2Ekj6wDA0a9BxLr8813xacIqa6hhCv+851C
 hx0oKcuxW7miA==
Message-ID: <effa4ed9-0e83-4acf-e21a-34e14fbdde13@canonical.com>
Date: Thu, 2 Jun 2022 17:42:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] ASoC: nau8822: Disable internal PLL if freq_out is
 zero
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
References: <20220530040151.95221-1-hui.wang@canonical.com>
 <20220530040151.95221-3-hui.wang@canonical.com>
 <db674fa6-37cc-9dc6-ed87-f9fee681db9a@canonical.com>
 <Yph3TT+EHN+CyrD3@sirena.org.uk>
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <Yph3TT+EHN+CyrD3@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: wtli@nuvoton.com, ctlin0@nuvoton.com, alsa-devel@alsa-project.org,
 kchsu0@nuvoton.com, ctlin0.linux@gmail.com
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

OK, got it. Thanks.

On 6/2/22 16:39, Mark Brown wrote:
> On Thu, Jun 02, 2022 at 10:12:06AM +0800, Hui Wang wrote:
>> Hi Mark,
>>
>> I saw you merged the [PATCH 1/2], the [PATCH 2/2] is also needed. Please
>> take a look.
> Patch 2 isn't a bug fix, it's a new feature so will need to wait
> until after the merge window.
