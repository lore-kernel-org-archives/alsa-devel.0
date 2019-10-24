Return-Path: <SRS0=DG6G=YR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FB2CA9EAF
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:21:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BBB121A4C
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WmyiccsY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZwINPQH3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pHfBmQFo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBB121A4C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 12FFA16DC;
	Thu, 24 Oct 2019 16:20:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 12FFA16DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571926871;
	bh=nmDVp/kJo67s6KN1l8iRhUKTodBuOLqSflg5dk5RD/s=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WmyiccsYNRuHeKbCi2vHRiqDzb6jLHw5M9d8N1lSiSr5bDGD3iSz6hB3lFC4vsU4F
	 XTZOVCPJ8pNwXJOIQsZn2unnrchVlS50a0OVoPLDWhSdsnK42mN6ThwCoehjiV+BA8
	 RR6zQNe+P4N0iurq/K9OTrI6sGphbX7YmjfSlRG8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 95CB0F80274;
	Thu, 24 Oct 2019 16:20:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 052A0F8036B; Thu, 24 Oct 2019 16:20:19 +0200 (CEST)
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B993CF80274
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2019 16:20:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B993CF80274
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org
 header.b="ZwINPQH3"; 
 dkim=pass (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org
 header.b="pHfBmQFo"
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 193D860614; Thu, 24 Oct 2019 14:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1571926814;
 bh=unZI5iQgmbm9vDtcQ3kjGY5Tz9gVZ0ku54KpdtlxyJU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=ZwINPQH3IP3FinMTPzdyRofEz20cXFrTO8z47eU5z/lYXHNMq0+kkE7T4J6JRzm/C
 OjZI+wR6tLU7uPpLOf8gogcnwMl3dzkkETKrRCkMg/JFTY6Z8/UCi7NaDogQ2CcXMq
 KJq2RheTy9frNah+8YhyeOnCpiF3huP1Q3kckiMU=
Received: from [192.168.86.240] (cpe-76-93-183-12.san.res.rr.com
 [76.93.183.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: plai@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id C34D36039C;
 Thu, 24 Oct 2019 14:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1571926813;
 bh=unZI5iQgmbm9vDtcQ3kjGY5Tz9gVZ0ku54KpdtlxyJU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=pHfBmQFopgQaSdwiJEnYTud7qeoKD+5Pnv2wCWeIjhLsP22RCjEgmLvaAiLjkFutB
 2bN9h4JzdN0E2GzPu194kzoY3upmu/MssRUQ8p92eYwJ2Eb0jEIeOTkPNrGGh4PKjQ
 bT6C7AuP3eYmJEOgZ15Zb96pTs61jSzKsBFCl1s0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C34D36039C
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=plai@codeaurora.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
References: <20191009181356.GO2036@sirena.org.uk>
 <20191022185906.GZ5554@sirena.co.uk>
From: Patrick Lai <plai@codeaurora.org>
Message-ID: <204150f3-2d0f-e2df-e4d0-7324b4788e99@codeaurora.org>
Date: Thu, 24 Oct 2019 07:20:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191022185906.GZ5554@sirena.co.uk>
Content-Language: en-US
Cc: Takashi Iwai <tiwai@suse.de>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Daniel Baluta <daniel.baluta@gmail.com>,
 Curtis Malainey <cujomalainey@google.com>
Subject: Re: [alsa-devel] [ANNOUNCE] 2019 Linux Audio miniconference
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

On 10/22/19 11:59 AM, Mark Brown wrote:
> Hi,

> 
> As with previous years let's pull together an agenda through a mailing
> list discussion - if people could reply to this mail with any topics
> they'd like to discuss we can take it from there.  Of course if we can
> sort things out more quickly via the mailing list that's even better!

1. Gapless playback handling between two playbacks with different format
2. Passing timestamp along with buffer for both playback and capture
3. PCM device volume control
4. Unified audio graph building across multiple subsystems

Thanks
Patrick

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
