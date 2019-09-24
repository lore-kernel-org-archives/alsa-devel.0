Return-Path: <SRS0=SJ4a=XT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08BEC432C2
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:54:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C07F214DA
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="l0J7bd7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C07F214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 499E31694;
	Tue, 24 Sep 2019 15:53:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 499E31694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569333255;
	bh=nbg7nw4Q1mNdXIPDluFhHnumA5lCmC1hc4rb7HIku4A=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l0J7bd7ae9wdInmqEg1toDADGsV4LQhm5eK97wFlXsN0HLkX7Sd5BC2F/oVLCG8ci
	 UHwHefRPbOScesUC+VfxVsV7/tCRyDOlUEBx0xIu52bc57SKF1uSfYz4HeoBwtv8ue
	 4PpgtAZBHUCKMUE07hHGdELZA6/c0vjAK1U61/Jk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EBF2FF8048D;
	Tue, 24 Sep 2019 15:52:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 23629F80213; Tue, 24 Sep 2019 15:52:50 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A0C4DF80213
 for <alsa-devel@alsa-project.org>; Tue, 24 Sep 2019 15:52:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0C4DF80213
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Sep 2019 06:52:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,544,1559545200"; d="scan'208";a="389865974"
Received: from conradji-mobl.amr.corp.intel.com (HELO [10.255.94.212])
 ([10.255.94.212])
 by fmsmga006.fm.intel.com with ESMTP; 24 Sep 2019 06:52:45 -0700
To: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>, sathya.prakash.m.r@intel.com
References: <1569312546-16393-1-git-send-email-sathya.prakash.m.r@intel.com>
 <1569312546-16393-2-git-send-email-sathya.prakash.m.r@intel.com>
 <20190924110700.2897cc18@xxx>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <01929cf2-6bae-8099-e432-d76286ab0114@linux.intel.com>
Date: Tue, 24 Sep 2019 08:52:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924110700.2897cc18@xxx>
Content-Language: en-US
Cc: naveen.m@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: Intel: boards: Add CML m/c using
 RT1011 and RT5682
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



>> +static const struct snd_soc_dapm_route cml_rt1011_rt5682_map[] = {
>> +	/*speaker*/
>> +	{"TL Ext Spk", NULL, "TL SPO"},
>> +	{"TR Ext Spk", NULL, "TR SPO"},
>> +	{"WL Ext Spk", NULL, "WL SPO"},
>> +	{"WR Ext Spk", NULL, "WR SPO"},
>> +
>> +	/* HP jack connectors - unknown if we have jack detection */
>> +	{ "Headphone Jack", NULL, "HPOL" },
>> +	{ "Headphone Jack", NULL, "HPOR" },
>> +
>> +	/* other jacks */
>> +	{ "IN1P", NULL, "Headset Mic" },
>> +
>> +	/* DMIC */
>> +	{"DMic", NULL, "SoC DMIC"},
> 
> There is some inconsistent spacing around the braces.

Indeed, thanks for spotting this. checkpatch did not complain in the 
previous reviews.

>> +	for (i = 0; i < rtd->num_codecs; i++) {
>> +		codec_dai = rtd->codec_dais[i];
> 
> This looks like candidate for for_each_rtd_codec_dai macro


Good suggestion.

Sathya P, can you update this patch and send a v2? Thanks!
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
