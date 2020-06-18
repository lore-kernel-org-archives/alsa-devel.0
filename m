Return-Path: <SRS0=r+qN=77=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2DFC433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 14:31:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21937207E8
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 14:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RS2t3qNT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLAR0Z+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21937207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 843A3178B;
	Thu, 18 Jun 2020 16:30:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 843A3178B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592490708;
	bh=obOL30SQn9wE32rmVgFOC0DRObEfMlUdqxWbZkdA/zk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RS2t3qNTXClx+lVCcHr92jTh/NLqzXbAeTLM5uNDSHPfHimr7JMMHxVg+T94ojnTN
	 qvASHcskBNdGYHC++PZ6y8x4lGcUPqVaYyCWPV2iRHNlAVLqZdBho9n4h3MXImlCCZ
	 8878hPvcchZJN+jxz4yIYwY7NrMKWJ6l5xkjpjjA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E429EF8010E;
	Thu, 18 Jun 2020 16:30:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9E1FFF80116; Thu, 18 Jun 2020 16:30:54 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0B657F800EF
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2020 16:30:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B657F800EF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="MLAR0Z+X"
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4809E207E8;
 Thu, 18 Jun 2020 14:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592490647;
 bh=obOL30SQn9wE32rmVgFOC0DRObEfMlUdqxWbZkdA/zk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MLAR0Z+XKCoWsWUztqZIKmKpbTfIvoXxXpVb57ccLX3wqamwcWmdavGWQEDSabc7o
 RiNyr0iPWgpKrnpklb+iGwNvHEmN/5sR9r7KAPkbokHsovHisg/go7+5bFIF9n90cT
 17pOBbSz12/hBbeKYEC9PRlq0Zw6x0u72Lr7XirA=
Date: Thu, 18 Jun 2020 10:30:46 -0400
From: Sasha Levin <sashal@kernel.org>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.7 004/388] ASoC: tegra: tegra_wm8903: Support
 nvidia, headset property
Message-ID: <20200618143046.GT1931@sasha-vm>
References: <20200618010805.600873-1-sashal@kernel.org>
 <20200618010805.600873-4-sashal@kernel.org>
 <20200618110023.GB5789@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200618110023.GB5789@sirena.org.uk>
Cc: linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
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

On Thu, Jun 18, 2020 at 12:00:23PM +0100, Mark Brown wrote:
>On Wed, Jun 17, 2020 at 09:01:41PM -0400, Sasha Levin wrote:
>> From: Dmitry Osipenko <digetx@gmail.com>
>>
>> [ Upstream commit 3ef9d5073b552d56bd6daf2af1e89b7e8d4df183 ]
>>
>> The microphone-jack state needs to be masked in a case of a 4-pin jack
>> when microphone and ground pins are shorted. Presence of nvidia,headset
>> tells that WM8903 CODEC driver should mask microphone's status if short
>> circuit is detected, i.e headphones are inserted.
>
>This is a new feature not a bugfix.

I saw this patch more as a hardware quirk.

-- 
Thanks,
Sasha
