Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54488C4727C
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:08:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D78C2087D
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MGY6h+xt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D78C2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E49CF176C;
	Thu,  1 Oct 2020 16:07:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E49CF176C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601561307;
	bh=zvHiZ8+eyEevPSGHpN95aZg6RCG++BEMMBc7X3yRMQg=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MGY6h+xtI80PGV+2DwjpB5BqA/jVo410ehv4vYnoScGeCiZ+BNjn5lybCNnVh5aJ7
	 F1ZrmNfSqtz62rc6oPx2ZDa2zMhO/SnSFDY0Aiyggx+30EHxFQMStiv5kEBvHjofYJ
	 KQoVtlnALcEovT4krU3cjWFCvefBL2XzJtVdwtf4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 758FBF801D8;
	Thu,  1 Oct 2020 16:07:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6F9DEF801DB; Thu,  1 Oct 2020 16:07:34 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0EA76F800AB
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2020 16:07:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0EA76F800AB
IronPort-SDR: r8MP7Gh0gIVjp4zSriCN5o9EugTvBxyXIdthBoFBDtNQg0iSDnNTvVdZP/SHN34ZN2bnmZhDgh
 aLN8VtuZEaPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="226857109"
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; d="scan'208";a="226857109"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2020 07:07:21 -0700
IronPort-SDR: aPeskelyCaRPWqclFhf52a/NfkPQY8IRB6n9OSy2CKEGjdLmnyxUOjRZbjpCtBRUWoI8jnE+OR
 sFhhmxhyd/FA==
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; d="scan'208";a="308644438"
Received: from clittlet-mobl.amr.corp.intel.com (HELO [10.212.183.210])
 ([10.212.183.210])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2020 07:07:20 -0700
Subject: Re: [PATCH 0/6] Ancillary bus implementation and SOF multi-client
 support
To: Mark Brown <broonie@kernel.org>, Dave Ertman <david.m.ertman@intel.com>
References: <20200930225051.889607-1-david.m.ertman@intel.com>
 <20201001125038.GC6715@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ddb019b8-4370-eca8-911f-38adf0531076@linux.intel.com>
Date: Thu, 1 Oct 2020 09:07:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201001125038.GC6715@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 ranjani.sridharan@intel.com, parav@nvidia.com, jgg@nvidia.com
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



>> are controlled by DT/ACPI. The same argument applies for not using MFD
>> in this scenario as it relies on individual function devices being
>> physical devices that are DT enumerated.
> 
> MFD has no reliance on devices being DT enumerated, it works on systems
> that don't have DT and in many cases it's not clear that the split you'd
> want for the way Linux describes devices is a sensible one for other
> operating systems so we don't want to put it into DT.  Forcing things to
> be DT enumerated would just create needless ABIs.

I agree the "DT enumerated" part should be removed.

To the best of my knowledge, the part of 'individual function devices 
being physical devices' is correct though. MFDs typically expose 
different functions on a single physical bus, and the functions are 
separated out by register maps. In the case where there's no physical 
bus/device and no register map it's unclear how MFDs would help?
