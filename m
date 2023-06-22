Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E7FEB64DA
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Jun 2023 08:35:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6BB7982C;
	Thu, 22 Jun 2023 10:34:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6BB7982C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687422926;
	bh=XgtNm+HD/SrGa3ByxHL3PTBnMHBtElsxgSR6rt60Ne4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=THI3n4IjowAHjqZNeGD6wBHyWR6qUFmqIDaC+U2cf8uttO80jwmRCRv5Q5OmGgarg
	 aJHFQK6PT34dbPgvG5KdZp25sOvc/kploU5lO1ratWv4e0FshfdPOyfuNbzUCcqyhp
	 dVh9HDBmPDijs3VpON14qHlkX6X/3hrOfoxEUbug=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 05F2BF80141; Thu, 22 Jun 2023 10:34:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 515DBF80141;
	Thu, 22 Jun 2023 10:34:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6E6A5F80141; Thu, 22 Jun 2023 10:34:03 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9B54FF80124
	for <alsa-devel@alsa-project.org>; Thu, 22 Jun 2023 10:33:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9B54FF80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Eb3IyCXm
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E97EF617B0;
	Thu, 22 Jun 2023 08:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD03C433C8;
	Thu, 22 Jun 2023 08:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687422834;
	bh=XgtNm+HD/SrGa3ByxHL3PTBnMHBtElsxgSR6rt60Ne4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Eb3IyCXmyj2S6adM6ACKO6YNPC4nqaAT+wPQxg9yTc5/WJ37OuWcQKNi5uofKL++Z
	 U01/zMz7j0x49zWR1xw52ZzwyYnmeIUqHYN6CBjfr4ZyNmDsBTktoUEfu0vg5ccuk8
	 QQ7jPFn4bOT1ckGitDj82+vvOwkqjVLqR2W/VjXnUMjnzYAgkhyctN52Kw0R9SPb+H
	 zEELxvfbTDsD7ytoxHzZjbZlU9sxqvteocJjFdWSceTDLwFgTo0jHvL1me2IF5hJoA
	 iPOwzVFzEx7/ULCQir4NKymwzEHpwwsUG7L6AL4K/WuaLAHdPZJtajPqPcorKms5V2
	 Ql65HdpouX9eQ==
Message-ID: <956657b8-bae1-2096-e932-3a1ae6852431@kernel.org>
Date: Thu, 22 Jun 2023 10:33:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ASoC: dt-bindings: nau8821: Convert to dtschema
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Seven Lee <wtli@nuvoton.com>
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, YHCHuang@nuvoton.com,
 KCHSU0@nuvoton.com, CTLIN0@nuvoton.com, SJLIN0@nuvoton.com,
 scott6986@gmail.com, supercraig0719@gmail.com, dardar923@gmail.com,
 devicetree@vger.kernel.org
References: <20230621093903.1077050-1-wtli@nuvoton.com>
 <99102ee0-ed59-4e60-89d2-60964cec012c@sirena.org.uk>
From: Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <99102ee0-ed59-4e60-89d2-60964cec012c@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: L2UTYP5H3VW7OBG4OX3YETVLZLQ4NOYX
X-Message-ID-Hash: L2UTYP5H3VW7OBG4OX3YETVLZLQ4NOYX
X-MailFrom: krzk@kernel.org
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
Archived-At: <>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 21/06/2023 20:13, Mark Brown wrote:
> On Wed, Jun 21, 2023 at 05:39:03PM +0800, Seven Lee wrote:
>> Convert the NAU8821 audio CODEC bindings to DT schema.
> 
> This wasn't sent to the DT list or maintainers, it should be in order to
> ensure they can review it.  Copying in the list and leaving the whole
> message for context.

Thanks.

DT list is being used for testing the patches, so this has to be resend
following get_maintainers.pl output.


Seven,

You already got such feedback before, so it's a repeat of same mistake
in the process. Use tools to automate such tasks, so the process is
being followed without need for additional steps.

Best regards,
Krzysztof

