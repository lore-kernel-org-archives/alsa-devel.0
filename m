Return-Path: <SRS0=4V3b=E2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38E3C56201
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:44:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C96ED2078B
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dmRjuvg3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="duNB48DL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C96ED2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DB86417F4;
	Fri, 20 Nov 2020 17:43:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DB86417F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605890662;
	bh=PwH+APuoJLyv528NX3V9K8rdYW/pwTr0f7Bzs7lMaCE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dmRjuvg33mxPcr8CEnB3OHZu3feXEmCBtr/ZJEEIfQdUeFt1/Lfr2H3dgPGBRYNyT
	 8raC8VD+bA7tVquLXylAT+iKcJ62tDTAIQmTc1WwiXafuM1fTAvefCEeHef52QNwVU
	 hB0KoW04naWIdXVhN2cJ/lstiHJ5lF3Mul3urKc0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A956F8016C;
	Fri, 20 Nov 2020 17:43:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 69B6DF8016E; Fri, 20 Nov 2020 17:43:30 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0CFCBF80168
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 17:43:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0CFCBF80168
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="duNB48DL"
Received: from [192.168.0.50] (89-70-52-201.dynamic.chello.pl [89.70.52.201])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C160E2078B;
 Fri, 20 Nov 2020 16:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605890606;
 bh=PwH+APuoJLyv528NX3V9K8rdYW/pwTr0f7Bzs7lMaCE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=duNB48DL4PCS+983OUMPYfZ/Kk7QA5ODSfPmtduzzCmKf4/1e2D5Khp5aOR5IVUiL
 dQnCuzXo26BnRq8++xlGBXa21FIiQ4dnS83QEV5LVpjo9q4uIBOqa61x7Coosrey+B
 QzCPRvcsMq93n2rkF7liKqrUJU5i1PeGAKvxC2jo=
Subject: Re: [PATCH 09/38] ASoC: samsung: smdk_wm8994: drop of_match_ptr from
 of_device_id table
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 alsa-devel@alsa-project.org
References: <20201120161653.445521-1-krzk@kernel.org>
 <20201120161653.445521-9-krzk@kernel.org>
From: Sylwester Nawrocki <snawrocki@kernel.org>
Message-ID: <24ffbe28-2057-245e-fad4-55cedbd9ab4f@kernel.org>
Date: Fri, 20 Nov 2020 17:43:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201120161653.445521-9-krzk@kernel.org>
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
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it is not relevant here).  This fixes
> compile warning (!CONFIG_OF on x86_64):
> 
>    sound/soc/samsung/smdk_wm8994.c:139:34: warning: ‘samsung_wm8994_of_match’ defined but not used [-Wunused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski<krzk@kernel.org>

Reviewed-by: Sylwester Nawrocki <snawrocki@kernel.org>
