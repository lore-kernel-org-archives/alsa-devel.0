Return-Path: <SRS0=LwrQ=AT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284ABC433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 12:51:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A391A20774
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 12:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RyWpOYBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A391A20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 221571658;
	Wed,  8 Jul 2020 14:50:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 221571658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594212667;
	bh=khkp5GjW0qQ9Abn36QCO7W/hWV1O284Dg8OXCSJ//kU=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RyWpOYBw0QKnGzRGQ3dTue9yGcMn+wCEQ/r6Ynz2+3aWEnOBtpcvC7x/MODf9uFtf
	 BIYpVZLC76GJ8WiRzf7h6t3aNES2p6JiDLvA0P6COn/Y4azzwre/VVoW+QOlGKsfdg
	 2RRgi/f8dfn2Q0106gTByhgXTwt1Iqap5DNNy+YM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A91DCF80150;
	Wed,  8 Jul 2020 14:50:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7371BF8015A; Wed,  8 Jul 2020 14:50:15 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E77D1F80115
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2020 14:50:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E77D1F80115
IronPort-SDR: Sb3Lysl4hb6Ia23Z06AUFrob+AQLnMyJk6u/ZROOy1tLscESG3YFiDOq6hRk1VCDlgH/S2xbRf
 mS/c8d6qmzZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="147793310"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; d="scan'208";a="147793310"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2020 05:50:00 -0700
IronPort-SDR: DN0OS/yAD7TWxMSC27q5Q8hSwZpsNC+8tCIRVJZ56RmolkuSHapYD7Za45C72XDIpIxy7hNdVi
 P+sMk1fM95AQ==
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; d="scan'208";a="323869563"
Received: from sare-mobl.amr.corp.intel.com (HELO [10.251.7.246])
 ([10.251.7.246])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2020 05:49:59 -0700
Subject: Re: [PATCH 0/3] ASoC: more fixes for dpcm checks
To: Mark Brown <broonie@kernel.org>
References: <20200707210439.115300-1-pierre-louis.bossart@linux.intel.com>
 <20200708115349.GK4655@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4290a302-e8a7-9b9b-7625-91f81a19aaf1@linux.intel.com>
Date: Wed, 8 Jul 2020 07:49:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708115349.GK4655@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: tiwai@suse.de, alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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



On 7/8/20 6:53 AM, Mark Brown wrote:
> On Tue, Jul 07, 2020 at 04:04:36PM -0500, Pierre-Louis Bossart wrote:
> 
>> base-commit: a5911ac5790acaf98c929b826b3f7b4a438f9759
> 
> These are fixes but you're basing them off for-5.9.

I wasn't sure which branch to use to be honest. It's late in the cycle 
for 5.8, the addition of the helper is new. I am happy to resubmit for 
5.8 if you prefer it this way.
