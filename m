Return-Path: <SRS0=Vfj9=ZV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608E7C432C0
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Nov 2019 19:51:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3908216F4
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Nov 2019 19:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ACIAsnrd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="VTk6GEzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3908216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 19EA91654;
	Fri, 29 Nov 2019 20:50:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 19EA91654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575057073;
	bh=0KT39f0zgnghxgLVo2+BwxtXk+O8IN9VO2o+n0728LA=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ACIAsnrdK6BjEEPIbw9I1+zrWAQxSS7C5RBG9tRWdezyPGWccbBsVbdNem7HN9y3f
	 26sqTNVbtGhPpzCq+3cXyTRYTGDLHyTG8UyG6QnT61GBp+0rY/QePy0H2cECCyOrSh
	 p2JEUR3PErXv+nQ+Mr4AUSQWvKq4ZwPfSU5LKlXY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7DA2BF8014D;
	Fri, 29 Nov 2019 20:50:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BCCB7F8016F; Fri, 29 Nov 2019 20:50:20 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D9E20F800B3
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2019 20:50:17 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id EAD0CA003F;
 Fri, 29 Nov 2019 20:50:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz EAD0CA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1575057016; bh=TXhyhFG869np/RZDjt16vMPrByBHtdZfxA4JFnAJTm4=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=VTk6GEzPaAzwCystgepHk/4T86KAHTWubYVzcQz7+mg1HcEPSq/QufFJdrefDUCPc
 VQ6fkpxeX837FvIN8j8b1OwisJ6REtNqL0aWBeS/bHY1+smaX8ic19NRFlTyKQobhp
 tvNITqC5RNAV7F/tXZ/hOEYIpTrZjsEfek2kBy0Q=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Fri, 29 Nov 2019 20:50:11 +0100 (CET)
To: Chih-Yang Hsia <paulhsia@chromium.org>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>
References: <20191129193530.51415-1-paulhsia@chromium.org>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <61a10081-d7d4-eae1-49ed-d3db96957db3@perex.cz>
Date: Fri, 29 Nov 2019 20:50:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191129193530.51415-1-paulhsia@chromium.org>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH alsa-lib] ucm: Use strncmp to avoid
 access-out-of-boundary
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Dne 29. 11. 19 v 20:35 Chih-Yang Hsia napsal(a):
> From: paulhsia <paulhsia@chromium.org>
> 
> If the length of the identifier is less than the length of the prefix,
> access-out-of-boundary will occur in memcmp().

Applied. Thank you for your contribution.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
