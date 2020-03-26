Return-Path: <SRS0=OLeW=5L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588BBC43331
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Mar 2020 15:01:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D855620737
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Mar 2020 15:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="m0l7kC0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D855620737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 29F391665;
	Thu, 26 Mar 2020 16:00:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 29F391665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585234869;
	bh=NEsefb6KXBbtCUvnJ15vHGn1PKiWmXbT+Jr42oXkRSE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m0l7kC0zOiZ9V3GOcLXSUiNuLWmUYO3ZmV/hbQ0LtlcL5dt2TrlXZFx2U2MrBiqLl
	 xDxftL+sNWc4YQJ23MDNnqZSke72mo05ny/bfVffogvip5VT12sYvbZz8tTjXA8sa0
	 GMuLY1un/5ycx2N/LBWZfDureBtQhcoG+5VX7F/Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A1E98F80095;
	Thu, 26 Mar 2020 16:00:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E0A9CF80227; Thu, 26 Mar 2020 16:00:16 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7763F80095
 for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2020 16:00:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7763F80095
IronPort-SDR: iuZh6NIWjdAm4k3liF5E+OJHqRAtWdATBtgHSKaSjHtj/SaCIwRtCNJ8/NOI3FgsvPYS4b8kE7
 Vzk3fEdI+O1g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2020 08:00:10 -0700
IronPort-SDR: D4WI8SF2LckJyfFTetYlvAUTycmPhkVjJKllsaLHS5Dyp6ZvL5ECzq3sElRovdqSm2Kq8Frw3d
 K3ghitsJPyHg==
X-IronPort-AV: E=Sophos;i="5.72,308,1580803200"; d="scan'208";a="240981478"
Received: from mgorski-mobl.ger.corp.intel.com (HELO [10.212.133.193])
 ([10.212.133.193])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2020 08:00:09 -0700
Subject: Re: [PATCH] ASoC: Intel: Skylake: Add alternative topology binary name
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
References: <20200325122230.12172-1-mateusz.gorski@linux.intel.com>
 <70860cdd-0017-7e6c-3a87-85e125e236fe@linux.intel.com>
From: "Gorski, Mateusz" <mateusz.gorski@linux.intel.com>
Message-ID: <49890f9b-f6db-c989-6072-312014a1a1f2@linux.intel.com>
Date: Thu, 26 Mar 2020 16:00:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <70860cdd-0017-7e6c-3a87-85e125e236fe@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: pl
Cc: cezary.rojewski@intel.com, tiwai@suse.com
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


> That's progress but is this complete?
>
> skl->i2s_dev->name is the name of the machine driver, I don't see the 
> part where this is modified to deal with the number of dmics?
>
> In your topology patches, the names are: hda_dsp_noDMIC 
> hda_dsp_DMIC_2ch hda_dsp_DMIC_4ch
>
> How would the relevant file be found based on the number of DMICs on 
> the platform? I must be missing something here?
>

The intention of this patch was not to deal with the different DMIC 
configurations problem. It only simplifies the topology binary 
selection. As you mentioned in one of previous mails, currently there 
are two options:

- name based on NHLT, which is pretty complicated, especially for end 
user, and is also depending on things like OEM name so the same topology 
will need to be renamed multiple times different devices (additionally, 
there are laptops on the market that do not have NHLT table at all)

- dfw_sst.bin, which is only a fallback binary name and should not be 
actually used because it could be misleading for users/distro intergrators

This change adds the third option, which is, in my opinion, the right 
way to deal with this problem. This name is simpler, does not depend on  
existence of NHLT, and makes life easier for users/distros.


And as for the mentioned DMIC confguration problem - I am doing a 
research to find the simplest way to deal with this.


Mateusz

