Return-Path: <SRS0=LzfN=Z3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540B7C43603
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Dec 2019 04:11:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C927920640
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Dec 2019 04:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cib+4IQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C927920640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 22B451668;
	Thu,  5 Dec 2019 05:10:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 22B451668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575519096;
	bh=RVFy5E9dZPOstRQgicO6PVy/IBxJFBsi2ulSnh+QMl8=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cib+4IQhk5xsoxwZq6luz2fKowTsNjyZvy60NoHK5SQg4TFmuIGfVO5umHwv7DE2P
	 myg8jGerYPIwAqIfTL/sKZFftota+DiM5O1T57TXr8+bq09a/TIO6nDrbwgqCq0Hfl
	 kR+OTGIhuCDppuNXwDfkVMoKj3Kp2PNt9SwQG2yo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6F68BF8010F;
	Thu,  5 Dec 2019 05:10:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6586BF80227; Thu,  5 Dec 2019 05:10:41 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 439B4F8010F
 for <alsa-devel@alsa-project.org>; Thu,  5 Dec 2019 05:10:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 439B4F8010F
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Dec 2019 20:10:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,279,1571727600"; d="scan'208";a="219099125"
Received: from bcmarin-mobl.amr.corp.intel.com (HELO [10.255.230.27])
 ([10.255.230.27])
 by fmsmga001.fm.intel.com with ESMTP; 04 Dec 2019 20:10:30 -0800
To: "Sridharan, Ranjani" <ranjani.sridharan@intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Pierre-louis Bossart <pierre-louis.bossart@intel.com>
References: <20191204151333.26625-1-daniel.baluta@nxp.com>
 <CAFQqKeXG3ihj67L+KgKZW=Cp6ipJC18wUVci3hGTMutBv4boZw@mail.gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <82095ea8-fa9a-5c67-e0e6-1a886dfc4b0e@linux.intel.com>
Date: Wed, 4 Dec 2019 22:01:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAFQqKeXG3ihj67L+KgKZW=Cp6ipJC18wUVci3hGTMutBv4boZw@mail.gmail.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>, tiwai@suse.com,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-core: Set dpcm_playback /
 dpcm_capture
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



On 12/4/19 5:29 PM, Sridharan, Ranjani wrote:
> On Wed, Dec 4, 2019 at 7:16 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:
> 
>> When converting a normal link to a DPCM link we need
>> to set dpcm_playback / dpcm_capture otherwise playback/capture
>> streams will not be created resulting in errors like this:
>>
>> [   36.039111]  sai1-wm8960-hifi: ASoC: no backend playback stream
>>
>> Fixes: a655de808cbde ("ASoC: core: Allow topology to override machine
>> driver FE DAI link config")
>> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
>> ---
>>   sound/soc/soc-core.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
>> index 977a7bfad519..f89cf9d0860c 100644
>> --- a/sound/soc/soc-core.c
>> +++ b/sound/soc/soc-core.c
>> @@ -1872,6 +1872,8 @@ static void soc_check_tplg_fes(struct snd_soc_card
>> *card)
>>
>>                          /* convert non BE into BE */
>>                          dai_link->no_pcm = 1;
>> +                       dai_link->dpcm_playback = 1;
>> +                       dai_link->dpcm_capture = 1;
>>
> Hi Daniel,
> 
> Typically, for Intel platforms, this information comes from the machine
> driver and there are some DAI links that have either playback or capture
> set. But this change would set both for all DAI links.
> Not sure if this is the right thing to do.

I am with Ranjani, I don't get why we'd set the full-duplex mode by 
default. but to be honest I never quite understood what this code is 
supposed to do...
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
