Return-Path: <SRS0=We8V=6G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395CFC54FCB
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:14:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B54FF2077D
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sGmngXxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54FF2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E4E9E16A1;
	Wed, 22 Apr 2020 15:14:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E4E9E16A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587561296;
	bh=v5rlyI6ISjDru+lSklmpfMdYbXOaDDaD2Lid2ZaYNqc=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sGmngXxmlWytc7EjyDiSkfYtHdQ2d3uy9c9//F4WvmpTX7jeHP3yljlyaGxQIxhET
	 73DIpHyGol/+RSvy0A3Sy6IpKzkLeGzUYI5BtVNbBuka2w6mgS4EG/+YQsSlzEShvX
	 nwVaOi5gQ+2tqkiXK7HEotkM7gieHV5y/DKuypNc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 515A2F80142;
	Wed, 22 Apr 2020 15:14:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5937DF801D9; Wed, 22 Apr 2020 15:14:03 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CC5C5F80108
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2020 15:13:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CC5C5F80108
IronPort-SDR: xT3YzGMRj28mMgXiGLxFWNKn3AOsbM7GD36niB20adz1+JyWFJaCjCl9Zr3A75Ilc/DrntjFmM
 k3OqROYUFpaw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2020 06:13:58 -0700
IronPort-SDR: LmhF22Iq50YP14UoTMT3dacjuACUNHSHyoy5WK3W8cncjpjfz73vkq8aleuHbBA5I9lNfhdt4U
 MSrdqD7zuREg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,414,1580803200"; d="scan'208";a="259064644"
Received: from lokoro-mobl.amr.corp.intel.com (HELO [10.251.147.75])
 ([10.251.147.75])
 by orsmga006.jf.intel.com with ESMTP; 22 Apr 2020 06:13:57 -0700
Subject: Re: [PATCH] ASoC: SOF: Fix build
To: Mark Brown <broonie@kernel.org>
References: <20200422112602.13109-1-broonie@kernel.org>
 <2c307fac-077e-6692-a57a-2c2084a4742f@linux.intel.com>
 <20200422125145.GE4898@sirena.org.uk>
 <276595db-6a14-d4c4-8490-33a0b06b241b@linux.intel.com>
 <20200422130128.GF4898@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a2a6f2d6-62f7-8ad7-4ee2-4b3d15060fa5@linux.intel.com>
Date: Wed, 22 Apr 2020 08:13:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422130128.GF4898@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org,
 Karol Trzcinski <karolx.trzcinski@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>
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



On 4/22/20 8:01 AM, Mark Brown wrote:
> On Wed, Apr 22, 2020 at 07:59:37AM -0500, Pierre-Louis Bossart wrote:
>> On 4/22/20 7:51 AM, Mark Brown wrote:
> 
>>> As the above and Stephen's report said it shows up in allmodconfig,
>>> that's the one I tested.  I'm guessing it should show up in most
>>> configurations where that code gets built.
> 
>> Gah, yes, I missed this report. I still don't get how this error went
>> undetected for weeks on the SOF side, will look into this.
>> We'll resubmit the whole thing.
> 
> It smells like there's a missing patch that got dropped during
> upstreaming.

No, this breaks with the SOF tree as well. Clearly our CI setup is not 
good enough.
