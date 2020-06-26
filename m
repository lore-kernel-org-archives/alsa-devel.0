Return-Path: <SRS0=sUwr=AH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8826C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:02:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AF7A2053B
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QUOVo/3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF7A2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B2742167A;
	Fri, 26 Jun 2020 18:01:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B2742167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593187354;
	bh=q81vYtppbtnbS1L3FYvJIHBaVWIwGiCrtwhcPAwoXPs=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QUOVo/3/78tU1jYo4lIkand/ut8ZP5FqXjuF/foDL8hxaxgk50/z1Rtmc3mxHXe6F
	 yERhVpvEJJQ6ZsBelpLOrMybM3LBtq5jOY24iOH9lkrNs/XyCEi1nG2JcE9s2xO/QX
	 V6JaWFKAPv9/ZwrwYIBPlYUdptfmMXcpTPZBDGPA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1F67EF8015A;
	Fri, 26 Jun 2020 18:01:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8C898F8015B; Fri, 26 Jun 2020 18:01:42 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B2FAEF800F1
 for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2020 18:01:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2FAEF800F1
IronPort-SDR: sxndj8G7PrgQMw9xRwpI4FzV00Sf5XNQ7GIMKQ4ddO2nouFYDYBuOK/M5/MdXKaSq5T8opCzPh
 3YyvhaVDA43w==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="133755840"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; d="scan'208";a="133755840"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 09:01:32 -0700
IronPort-SDR: UIqTUf7xN9RyvrFlWyQQXM8UyZ38sH5NdpW8GkAHrdckXvzJy7LDHtlStt+fB4Zarzu8HQsp3g
 Qy0ec96jZuBQ==
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; d="scan'208";a="280189871"
Received: from avenkat1-mobl2.amr.corp.intel.com (HELO [10.254.109.204])
 ([10.254.109.204])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 09:01:31 -0700
Subject: Re: [PATCH 16/17] ASoC: Intel: sdw_max98373: add card_late_probe
 support
To: Mark Brown <broonie@kernel.org>
References: <20200625192652.4365-1-pierre-louis.bossart@linux.intel.com>
 <20200626143732.GA34281@sirena.org.uk>
 <2ca5ecb6-8827-458a-4db2-4232818a6841@linux.intel.com>
 <20200626151622.GG5289@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b1b812de-b3b2-62fc-9298-1cfd7d0ac839@linux.intel.com>
Date: Fri, 26 Jun 2020 11:01:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200626151622.GG5289@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: tiwai@suse.de, alsa-devel@alsa-project.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 randerwang <rander.wang@linux.intel.com>
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



On 6/26/20 10:16 AM, Mark Brown wrote:
> On Fri, Jun 26, 2020 at 09:52:41AM -0500, Pierre-Louis Bossart wrote:
>> On 6/26/20 9:37 AM, Mark Brown wrote:
> 
>>> This doesn't apply against current code, please check and resend.
> 
>> Not sure what happened here, I always apply the patches on your latest
>> branch in a separate tree, then re-extract them and recheck. maybe an email
>> glitch, SMTP was behaving yesterday?
> 
> You didn't thread a bunch of patches in your series yesterday, if there
> were dependencies within the series they may have been disrupted.

that's probably it. git send-email died after a timeout at about 2/3rds 
of the series. I wasn't sure what to do so sent the missed patches 
separately. I didn't think of threading...
Not sure however if there's a way to recover from this sort of errors. 
Maybe use -in-reply-to=<patch0 id> --nothread ?
