Return-Path: <SRS0=4V3b=E2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF508C56201
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:43:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0659F2225B
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hkE8cnRg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJLOhvR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0659F2225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E5597170A;
	Fri, 20 Nov 2020 17:42:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E5597170A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605890577;
	bh=RsU56jrCTRWv4W91wOKbnibTHglkZi7P7QfGXIPhqpA=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hkE8cnRgAWwhqPugGKBnCVaFHPmpvNDBszbzRWOuufA83hToA9oSVzHe7tIQ8vbqn
	 0/I8tXwyQauP0iGW7ZfKS+ZgC6DDnNMcTCtvIWJ9gN9NqH9u+TBpLx5mNkyNmoj+UV
	 8a7d4xPFy7U3PFjXDDLemCvootdj5L1+yFypUZqU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 843A5F80168;
	Fri, 20 Nov 2020 17:42:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8DFCCF8016C; Fri, 20 Nov 2020 17:42:05 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0DA19F800C5
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 17:42:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0DA19F800C5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="gJLOhvR5"
Received: from [192.168.0.50] (89-70-52-201.dynamic.chello.pl [89.70.52.201])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 99E482225B;
 Fri, 20 Nov 2020 16:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605890519;
 bh=RsU56jrCTRWv4W91wOKbnibTHglkZi7P7QfGXIPhqpA=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=gJLOhvR5L5VgwE7TZnkHSW4qrYnNWQ3fXTc25doOGPDRRdRWM6O+TLfG3+fFkU9jO
 8iYrkx0KgVOtEAIajKdMvqYFqXiolSPDlZNoGIvIKqg9Voyn3ChCG9UI9glRsANZ+g
 5H4KKLgNW934lKUFbc3lTVL8ZWoWVuT6F8VpPKLo=
Subject: Re: [PATCH 34/38] ASoC: samsung: i2s: mark OF related data as maybe
 unused
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 alsa-devel@alsa-project.org
References: <20201120161653.445521-1-krzk@kernel.org>
 <20201120161653.445521-34-krzk@kernel.org>
From: Sylwester Nawrocki <snawrocki@kernel.org>
Message-ID: <d4387617-bdfe-e80c-8d8a-5597d3bf67f4@kernel.org>
Date: Fri, 20 Nov 2020 17:41:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201120161653.445521-34-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.com>
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

On 11/20/20 17:16, Krzysztof Kozlowski wrote:
> The driver can be compile tested with !CONFIG_OF making certain data
> unused:
> 
>    sound/soc/samsung/i2s.c:1646:42: warning: ‘i2sv5_dai_type_i2s1’ defined but not used [-Wunused-const-variable=]
>    sound/soc/samsung/i2s.c:1639:42: warning: ‘i2sv7_dai_type’ defined but not used [-Wunused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski<krzk@kernel.org>

Reviewed-by: Sylwester Nawrocki <snawrocki@kernel.org>
