Return-Path: <SRS0=WtzT=H7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CDEC433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 17:43:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FBDC65318
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 17:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FBDC65318
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 15E6A1668;
	Mon,  1 Mar 2021 18:42:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 15E6A1668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614620589;
	bh=Ovu3EtIrrYN3YBlxbX1JfEUeHRIwSnyg8GxnRZpD+v4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=adHMK36vh0xha+BnzoLIa3idft0IfZ7HBkEOYGHZABAhhT9yR/3qaCyoKP3h6AU/M
	 +Y9DCxMJHCZiZ+g7AGTC15P4TWmkpPSn2OIfNlKNBIaXg2BXpPLy8tYPpsFdHazXf/
	 15PUXR4gWuOrEswmhybb8n7NBnbVOSml3aKMNn1s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 50808F80150;
	Mon,  1 Mar 2021 18:42:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E1A2EF800E0; Mon,  1 Mar 2021 18:42:16 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 93224F800E0
 for <alsa-devel@alsa-project.org>; Mon,  1 Mar 2021 18:42:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 93224F800E0
IronPort-SDR: wmrO3OEMhSYk7ObiwTdSzWbqtW3Y7NJeNtziggCXmp5+bUCEaVHwMQCAK6aUImdbyNWXR1sk3a
 cqDWcBc43wVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="173676793"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; d="scan'208";a="173676793"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2021 09:42:08 -0800
IronPort-SDR: jl+J2kgcV63XgwX3vC5PVO0aa9FNRbO4sj4g41+/GaYFUXTwIJV71lE+eJUt3mgiYnVi2R21Qo
 Mo+vG8xxcoNw==
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; d="scan'208";a="397840100"
Received: from mhuang8-mobl3.amr.corp.intel.com (HELO [10.212.25.220])
 ([10.212.25.220])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2021 09:42:08 -0800
Subject: Re: [PATCH] ASoC: codecs: nau8825: fix kernel-doc
To: Mark Brown <broonie@kernel.org>
References: <20210301165349.114952-1-pierre-louis.bossart@linux.intel.com>
 <20210301165349.114952-2-pierre-louis.bossart@linux.intel.com>
 <20210301171416.GF4628@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <79796455-2aa8-7873-31d1-e5bae6e49dc4@linux.intel.com>
Date: Mon, 1 Mar 2021 11:42:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210301171416.GF4628@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, vkoul@kernel.org
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



On 3/1/21 11:14 AM, Mark Brown wrote:
> On Mon, Mar 01, 2021 at 10:53:46AM -0600, Pierre-Louis Bossart wrote:
>> v5.12-rc1 flags new warnings with make W=1, fix missing or broken
>> function descriptors.
> 
> You've sent five patches (for multiple subsystems) in a thread but not
> as a series - please don't do this, it confuses tools like b4 since they
> can't figure out if this is a series or multiple revisions of a single
> patch.  Please don't do this, if things are a series send them as such
> or if it's a collection of unrelated patches send them separately.

Humm yes, I thought git sendmail would be smart enough to detect it 
wasn't a series...oh well, will resend a v2.
