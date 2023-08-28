Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADF9C83F12
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Aug 2023 20:25:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C06D41F6;
	Mon, 28 Aug 2023 22:24:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C06D41F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693254344;
	bh=O/WRNq9CKZeXYHbZTzZTT4pv7dU3hfELhmbUNVhV6Lo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=fOrPLiqIcPoFXwCctTtFB5H0FLpvhbaKhHZvGaVKzq2CtR1Dk9lOn8Yg513wWWd9j
	 yzqEm+Zn75MihXSqR3OQKjr4+U+D7WscjUq/Tuh7GAvUe91P90h5nXN61J+vB02fot
	 dW+kfP0lmC6Xi9/Ct0bHP+sSxSpHX3DJKpbULpI0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 10147F8025F; Mon, 28 Aug 2023 22:24:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 76A7DF80094;
	Mon, 28 Aug 2023 22:24:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0CEB8F80074; Mon, 28 Aug 2023 22:24:10 +0200 (CEST)
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 52E6EF80074
	for <alsa-devel@alsa-project.org>; Mon, 28 Aug 2023 22:24:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 52E6EF80074
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=mutex.one header.i=@mutex.one header.a=rsa-sha256
 header.s=default header.b=FCUXPpQ2
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.mutex.one (Postfix) with ESMTP id F211A16C004D;
	Mon, 28 Aug 2023 23:24:03 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
	by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cEbrxrMt26Y0; Mon, 28 Aug 2023 23:24:03 +0300 (EEST)
From: Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
	t=1693254242; bh=O/WRNq9CKZeXYHbZTzZTT4pv7dU3hfELhmbUNVhV6Lo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FCUXPpQ2+L4Syt4lkJAs6aH8lJ6k4gLeWwOzEV6wCjMoRhrfra5Ls1vbTEAs2g5xc
	 e4/btR60MJEPK9Zuqge71VrfJ/P5X2tXyVgo3OE5NgltNMoqEuhJzF2YdgEovqt0Cl
	 X7+xGxjKq8927tIIeyyLwoqgDrARQP4/q0ze1nKg=
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ASoC: es8316: Enable support for MCLK div by 2
In-Reply-To: <ZOzi9BuTo2oXcKta@finisterre.sirena.org.uk>
References: <20230824210135.19303-1-posteuca@mutex.one>
 <20230824210135.19303-3-posteuca@mutex.one>
 <ZOfRXjuSTxSV89SC@finisterre.sirena.org.uk> <87msyc9mtm.fsf@mutex.one>
 <ZOzi9BuTo2oXcKta@finisterre.sirena.org.uk>
Date: Mon, 28 Aug 2023 23:22:15 +0300
Message-ID: <87zg2ax6h4.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID-Hash: WZKGVRLIY5KUDYQWCQ3VGMIZGD5KFUQV
X-Message-ID-Hash: WZKGVRLIY5KUDYQWCQ3VGMIZGD5KFUQV
X-MailFrom: posteuca@mutex.one
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WZKGVRLIY5KUDYQWCQ3VGMIZGD5KFUQV/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Mark Brown <broonie@kernel.org> writes:

>
> In general a MCLK that allows you to configure the dividers in the CODEC
> appropriately for use.  So long as it works your change looks fine I
> think modulo.
Sorry, maybe this question is dumb, but I am not familiar with this
expression. What do you mean by "your change looks fine I think modulo"?

>> +	do {
>> +		/* Validate supported sample rates that are autodetected from MCLK */
>> +		for (i = 0; i < NR_SUPPORTED_MCLK_LRCK_RATIOS; i++) {
>> +			const unsigned int ratio = supported_mclk_lrck_ratios[i];
>> +
>> +			if (clk % ratio != 0)
>> +				continue;
>> +			if (clk / ratio == params_rate(params))
>> +				break;
>> +		}
>
> Use ARRAY_SIZE()
>
Do you mean instead of all instances of NR_SUPPORTED_MCLK_LRCK_RATIOS?
If so, it's already defined as:
#define NR_SUPPORTED_MCLK_LRCK_RATIOS ARRAY_SIZE(supported_mclk_lrck_ratios)

If not, then I don't see where else I could use it.

