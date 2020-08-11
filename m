Return-Path: <SRS0=37Wv=BV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E73C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Aug 2020 10:11:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 345EA2075D
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Aug 2020 10:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OsmtHNPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345EA2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C418A1670;
	Tue, 11 Aug 2020 12:10:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C418A1670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597140675;
	bh=djl1YsfqPwv1FnpADzoww/TuipDGXreNoBc3CKfQS70=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OsmtHNPpEPXC2tEJmUofvd6bMFflVNfKLyHW/qWF5f+Q8wc6gFn9JLG+jQrlKE0Mt
	 CS0WErinTTfLCd3Az87pA+sudAezt5np27dhd948myX/LAbb7r7HZqP73D98422bCv
	 eS4lDpdXAQICOXKhjWS4w335vfSHK+E3VC0bHfYU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A261CF800D3;
	Tue, 11 Aug 2020 12:05:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 342E6F80161; Tue, 11 Aug 2020 12:05:01 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F3326F80118
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2020 12:04:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F3326F80118
IronPort-SDR: fIWDZpYvsMht4rZLay0Mmm3/b2/Bwd1hNenWvB9DrRjZoJ6VdyccC9TyVSQArqzoBs9pZ0Lr/W
 WTi4aO+MSWgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="133240550"
X-IronPort-AV: E=Sophos;i="5.75,460,1589266800"; d="scan'208";a="133240550"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2020 03:04:47 -0700
IronPort-SDR: CmGVem5iHyBRHGX422QAA9YqDxIP75D5TBL+JTKlyqio4yyRL/K1HKQGqPC6WZ2qXMWCjtIBuc
 sLDBuGuYmrOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,460,1589266800"; d="scan'208";a="317672080"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.31.191])
 ([10.213.31.191])
 by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2020 03:04:40 -0700
Subject: Re: [PATCH 01/13] ASoC: Intel: Add catpt device
To: Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20200807110649.17114-1-cezary.rojewski@intel.com>
 <20200807110649.17114-2-cezary.rojewski@intel.com>
 <20200808115041.GN3703480@smile.fi.intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <e9c8786c-4d31-a85a-2a40-cfd29fd91b73@intel.com>
Date: Tue, 11 Aug 2020 12:04:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200808115041.GN3703480@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 filip.kaczmarski@intel.com, harshapriya.n@intel.com, marcin.barlik@intel.com,
 zwisler@google.com, lgirdwood@gmail.com, tiwai@suse.com,
 filip.proborszcz@intel.com, broonie@kernel.org, michal.wasko@intel.com,
 cujomalainey@chromium.org, ppapierkowski@habana.ai,
 vamshi.krishna.gopal@intel.com
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

On 2020-08-08 1:50 PM, Andy Shevchenko wrote:
> On Fri, Aug 07, 2020 at 01:06:37PM +0200, Cezary Rojewski wrote:
>> Declare base structures, registers and device routines for the catpt
>> solution. Catpt deprecates and is a direct replacement for
>> sound/soc/intel/haswell. Supports Lynxpoint and Wildcat Point both.
> 
> 
> ...
> 
>> +struct catpt_mregion {
>> +	u32 start;
>> +	u32 end;
>> +	bool busy;
>> +	struct list_head node;
>> +};
> 
> I'm wondering if struct resource can be used instead.
> 
> You know that you may introduce a new type of resource if you want to.
> 
>> +static inline size_t catpt_mregion_size(const struct catpt_mregion *reg)
>> +{
>> +	return reg->end - reg->start + 1;
>> +}
>> +
>> +/* True if region r1 intersects region r2 */
>> +static inline bool catpt_mregion_intersects(struct catpt_mregion *r1,
>> +					    struct catpt_mregion *r2)
>> +{
>> +	return (r1->start >= r2->start && r1->start <= r2->end) ||
>> +	       (r1->end >= r2->start && r1->end <= r2->end);
>> +}
>> +
>> +static inline bool catpt_mregion_intersecting(struct catpt_mregion *r1,
>> +					      struct catpt_mregion *r2,
>> +					      struct catpt_mregion *ret)
>> +{
>> +	if (!catpt_mregion_intersects(r1, r2))
>> +		return false;
>> +	ret->start = max(r1->start, r2->start);
>> +	ret->end = min(r1->end, r2->end);
>> +	return true;
>> +}
> 
> Yeah, it reminds the existing resource infrastructure. Why to repeat it?
> 

As mentioned in the followup message:
https://www.spinics.net/lists/alsa-devel/msg113563.html
(Resource management section)

I opted out of 'struct resource' usage due to differences in its layout 
and preferred usage. Perhaps I shouldn't have.

I've embraced 'struct resource' fully in v2. Your suggestion cascaded 
into several other changes and some things were made redundant with 
removal of struct catpt_mbank and catpt_mregion. Change log has been 
added in v2 cover-letter describing consequences of said change.

Thanks,
Czarek
