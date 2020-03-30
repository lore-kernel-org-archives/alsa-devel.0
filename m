Return-Path: <SRS0=jBUr=5P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7854BC43331
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:38:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D87082072E
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eaX4Ea3O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87082072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2EAD382B;
	Mon, 30 Mar 2020 17:38:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2EAD382B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585582733;
	bh=2lAbko2Y67SyLujiNLcxCpnRSuD6Cntd2N90QvcSWtw=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eaX4Ea3OfvZa1HtCRCU/dheHMqfNGEftNfvouCxh/A80zMjFM5apld8vVh4xtTpTw
	 Oln5wxd4FrMqnGmWWaGpQcT9afvuYHdVwo+jNmHtNcIpxWJTsDxz3SHNwl+0rQRn1k
	 u6DE4JfwPSnediwt/SFGdvpLkJY5ltywUUpEfCfk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CDA61F80145;
	Mon, 30 Mar 2020 17:38:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C8A1BF80148; Mon, 30 Mar 2020 17:37:44 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 915E3F800AA
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2020 17:37:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 915E3F800AA
IronPort-SDR: RDnvngSgfocgBRttpRhyATgJbD81VUd7LruttyYn85hI8SHHSqXWg6APup1URiGt1F52Nx4o2L
 lffLnsPGjSfw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2020 08:37:21 -0700
IronPort-SDR: rGfofEL0vyso2snjbsChk1/bvhIJvttkOoY8nj2MoiAnlDgt4nwnA7l4+c1eagK7/WENaaEzKM
 L9ExIccj2JDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,324,1580803200"; d="scan'208";a="395160763"
Received: from sgobriel-mobl.amr.corp.intel.com (HELO [10.212.145.94])
 ([10.212.145.94])
 by orsmga004.jf.intel.com with ESMTP; 30 Mar 2020 08:37:20 -0700
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
To: Mark Brown <broonie@kernel.org>,
 Cezary Rojewski <cezary.rojewski@intel.com>
References: <20200318192213.GA2987@light.dominikbrodowski.net>
 <b352a46b-8a66-8235-3622-23e561d3728c@intel.com>
 <20200318215218.GA2439@light.dominikbrodowski.net>
 <e7f4f38d-b53e-8c69-8b23-454718cf92af@intel.com>
 <20200319130049.GA2244@light.dominikbrodowski.net>
 <20200319134139.GB3983@sirena.org.uk>
 <a01359dc-479e-b3e3-37a6-4a9c421d18da@intel.com>
 <20200319165157.GA2254@light.dominikbrodowski.net>
 <20200330102356.GA16588@light.dominikbrodowski.net>
 <43c098c9-005e-b9f4-2132-ed6e4a65feee@intel.com>
 <20200330113929.GF4792@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <85dca962-58ad-6e00-c84b-10859ea127fe@linux.intel.com>
Date: Mon, 30 Mar 2020 10:37:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200330113929.GF4792@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com,
 curtis@malainey.com, Keyon Jie <yang.jie@linux.intel.com>, tiwai@suse.com,
 Dominik Brodowski <linux@dominikbrodowski.net>, linux-kernel@vger.kernel.org,
 liam.r.girdwood@linux.intel.com
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



On 3/30/20 6:39 AM, Mark Brown wrote:
> On Mon, Mar 30, 2020 at 01:10:34PM +0200, Cezary Rojewski wrote:
>> On 2020-03-30 12:23, Dominik Brodowski wrote:
> 
>>> Seems this patch didn't make it into v5.6 (and neither did the other ones
>>> you sent relating to the "dummy" components). Can these patches therefore be
>>> marked for stable, please?
> 
> I sent my pull request already sorry - once it hits Linus' tree I'd send
> a request to stable.
> 
>> While one of the series was accepted and merged, there is a delay caused by
>> Google/ SOF folks in merging the second one.
> 
>> Idk why rt286 aka "broadwell" machine board patch has not been merged yet.
>> It's not like we have to merge all (rt5650 + rt5650 + rt286) patches at
>> once. Google guys can keep verifying Buddy or whatnot while guys with Dell
>> XPS can enjoy smooth audio experience.
> 
> My scripting is set up to merge things sent to me as a patch series and
> we didn't get positive review from Pierre on any of it with the review
> on that one patch seeming to suggest it might also be waiting go go
> through a test farm.  TBH I also wasn't expecting it to take quite so
> long to get reviewed when it came in, it's been over 2 weeks now...

There are multiple problems with Broadwell and device-specific issues on 
suspend-resume - in which Cezary is involved. The tests are not 
automated so depend on people availability.

I tested this series last Friday and I didn't find any new problem on my 
side, so we should probably merge this series.

Everyone should be aware though that suspend-resume is far from stable 
on Broadwell, and if it works on Dell XPS 13 it doesn't work reliably on 
Chrome devices.
