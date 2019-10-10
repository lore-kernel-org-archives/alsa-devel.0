Return-Path: <SRS0=8UIF=YD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E5FECE58C
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Oct 2019 02:21:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 471A721848
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Oct 2019 02:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IZc/BU1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 471A721848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E797C950;
	Thu, 10 Oct 2019 04:20:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E797C950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570674100;
	bh=E3ukQ5/WCSkgpzShYzBy3BBxLpppmOzbkVJSziiBRlk=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IZc/BU1mK4TRCH8Bk95pa8TYOxMmwLxtfMTLoxNSGzuHhhHKnHizFDcrmmEEqEUd3
	 Pqb3xeKfEVB4eyvlVejFiPC0xEOHbYPYfUzeRLyFf3F6sctxCVTWaZ/zeTqMw8DXbq
	 xn14yTILu+1IhzgwqPoaboDiAVLXNw9nPOLua+H0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 70033F80322;
	Thu, 10 Oct 2019 04:20:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 949F7F8038F; Thu, 10 Oct 2019 04:20:47 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1A466F80113
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2019 04:20:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1A466F80113
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Oct 2019 19:20:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,278,1566889200"; d="scan'208";a="207086506"
Received: from peterngx-mobl.amr.corp.intel.com (HELO [10.252.193.198])
 ([10.252.193.198])
 by fmsmga001.fm.intel.com with ESMTP; 09 Oct 2019 19:20:40 -0700
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <87r23mgxl7.wl-kuninori.morimoto.gx@renesas.com>
 <2a28be44-91ad-c140-062b-4d14982042e9@linux.intel.com>
 <87pnj57a2w.wl-kuninori.morimoto.gx@renesas.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <70a91c94-3c4d-6f78-7a71-bb8bdbc28b6a@linux.intel.com>
Date: Wed, 9 Oct 2019 21:20:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87pnj57a2w.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] Question about DPCM FE vs BE
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


>> It is my understanding that the current code would not support a case
>> where a FE is also a BE.
>>
>> That said, do we want to preclude it? at some point we probably want
>> to get rid of the FE/BE distinction and have 'domains' that can be
>> chained. So it may not be a good thing to cast a restriction in
>> stone. If at some point we need a list of upstream/downstream clients
>> maybe we should keep this.
> 
> Yeah, "domains" is nice idea !!
> 
> But, before that, I think we need to cleanup soc-pcm.
> I'm reading it, but it is too much complex, and too unreadable...
> I want to cleanup it first. I believe it can help
> the conversion (= FE/BE to domains).

The idea of domains/constraint propagation is not mine BTW, it was 
presented by Lars some 2-3 years ago. there may be a note somewhere in 
the audio miniconference minutes.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
