Return-Path: <SRS0=zQEr=Y6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC199C5DF63
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Nov 2019 18:16:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68213217F5
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Nov 2019 18:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CeQ7s+fF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68213217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5BDE515E2;
	Wed,  6 Nov 2019 19:15:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5BDE515E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573064160;
	bh=YbRi84MXHi/m93tc9iufIUY5H9A1QGLi5cP9JE2bg1s=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CeQ7s+fF5r0jPoZtr/w3cyeUWuCP/cZqFONzvpg5ZIa5t9iIjVxJdgdEHPsXcw43O
	 NEMsclyiMfPdt743dqVFVr2PupO6IJ33n9herCQyPqx59iF6JPkuCJn87/oeDx0OQp
	 lE+bOahzEEW+7+QDkYBQqf206a8UgxJJDmdIqZ9o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DDB1DF800F3;
	Wed,  6 Nov 2019 19:15:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EF610F8015B; Wed,  6 Nov 2019 19:15:07 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4E7B1F8015B
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2019 19:15:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4E7B1F8015B
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Nov 2019 10:15:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; d="scan'208";a="228455340"
Received: from ppaladu-mobl1.amr.corp.intel.com (HELO [10.255.230.49])
 ([10.255.230.49])
 by FMSMGA003.fm.intel.com with ESMTP; 06 Nov 2019 10:15:00 -0800
To: Mark Brown <broonie@kernel.org>
References: <20191106145816.9367-1-pierre-louis.bossart@linux.intel.com>
 <20191106162146.292802743193@ypsilon.sirena.org.uk>
 <20191106162927.GC11849@sirena.co.uk>
 <14d026ab-a898-358e-34ea-4f73d6c0fc0a@linux.intel.com>
 <20191106165432.GD11849@sirena.co.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ad2f2082-68da-5d36-5fd7-532012871419@linux.intel.com>
Date: Wed, 6 Nov 2019 12:15:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191106165432.GD11849@sirena.co.uk>
Content-Language: en-US
Cc: Dragos Tarcatu <dragos_tarcatu@mentor.com>, tiwai@suse.de,
 alsa-devel@alsa-project.org, Jaska Uimonen <jaska.uimonen@intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [alsa-devel] Applied "ASoC: SOF: topology: Fix bytes control
 size checks" to the asoc tree
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



On 11/6/19 10:54 AM, Mark Brown wrote:
> On Wed, Nov 06, 2019 at 10:49:20AM -0600, Pierre-Louis Bossart wrote:
>> On 11/6/19 10:29 AM, Mark Brown wrote:
>>> On Wed, Nov 06, 2019 at 04:21:46PM +0000, Mark Brown wrote:
> 
>>> It's not immediately obvious if something similar is needed for -next,
>>> the relevant code has been redone since v5.4 was branched off.  If
>>> something is needed someone will have to send something.
> 
>> I checked that the patch applies even before Jaska's October rework, where
>> the same bug was present. so in theory picking this fix for 5.2..5.4 would
>> work as usual.
> 
> What I'm saying is that I did that and if the fix is still needed after
> the rework someone will need to send a version that applies after the
> rework.

Sorry, the same patch will apply before and after the rework, so you can 
apply it to for-next as well. You don't need a new version.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
