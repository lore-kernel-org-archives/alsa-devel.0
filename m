Return-Path: <SRS0=eswj=3E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24EFC33C9E
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jan 2020 01:42:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47C0524658
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jan 2020 01:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="R7iSz2K1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C0524658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 789B217AA;
	Wed, 15 Jan 2020 02:41:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 789B217AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579052550;
	bh=JX98q9zWc/mxkeau6HRn8GKgauRVjKLODFdOHG8fjV4=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R7iSz2K13zAcA9qqtPqH++VAU+fP/Zqj1JW/P0X7OLcYF/i9xW81BBrCh+QVITIkW
	 XYE4Hmy0V9XyrXV9vCevZoObhrtBHFWTz7sO4VvpnEIUhJUHE2geYr3lywOxgHI/1h
	 PiBKBblVhBNquCljyHirxe318xjiWIKSMIUNYzHo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DD105F8014D;
	Wed, 15 Jan 2020 02:41:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 64303F8014E; Wed, 15 Jan 2020 02:41:36 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 372AAF80121
 for <alsa-devel@alsa-project.org>; Wed, 15 Jan 2020 02:41:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 372AAF80121
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Jan 2020 17:41:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,320,1574150400"; d="scan'208";a="305339471"
Received: from sbreyer-mobl.amr.corp.intel.com (HELO [10.255.228.18])
 ([10.255.228.18])
 by orsmga001.jf.intel.com with ESMTP; 14 Jan 2020 17:41:27 -0800
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 ojab // <ojab@ojab.ru>
References: <CAKzrAgTD2oeyajKGOaPea98vZ-uKJOn6uOqABA+CKtpvYpWYvQ@mail.gmail.com>
 <CAKzrAgTCE4btXr04pkvLUG6PPbtn9dm5h_9rjqDYG0HrTZ0zbg@mail.gmail.com>
 <87h80x8t41.wl-kuninori.morimoto.gx@renesas.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <130af222-1086-ebcf-6a0f-9a390f9afbc3@linux.intel.com>
Date: Tue, 14 Jan 2020 19:41:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87h80x8t41.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] No sound since 5.4 on skl_n88l25_s4567
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


>>> Please take a look, I want my sound back ._.
>>
>> Forgot to mention, it's reproducible on linux master git.
> 
> Hmm...
> This patch
> 	1) removes unneeded if check
> 	2) adds missing error check.
> 
> 1) shouldn't have effect to your PC.
> Thus, maybe your PC failed by 2).
> It had been worked by accident before ?
> I guess your kernel is telling some message like this ?
> 
> 	ASoC: no dapm match for %s --> %s --> %s

It's likely that the topology file does not contain all the widgets/dais 
required by the hard-coded routes the machine driver, and by becoming 
stricter warnings became errors which in turn prevent the card from 
being created. It may be that we have to define a backwards compatible 
behavior that's enabled only for Intel legacy cases.

Please post the results of alsa-info.sh somewhere so that we can take a 
look.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
