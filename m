Return-Path: <SRS0=JS7s=PG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BBAC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Oct 2021 15:18:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D0B16056B
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Oct 2021 15:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1D0B16056B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D75A217DB;
	Mon, 18 Oct 2021 17:17:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D75A217DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634570282;
	bh=itaxzkHjpneG+zDclqwfkiBXjUdv1JqiPK1AtLNC+cg=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hc4C/dacjVDXLs3AwV5uNdT8akk3yv7tBhA6iDsaJ5pJxKcXtxoBw3kxo4cTe+gpc
	 ahTz/7Vwb5UFjN7uLo00ABXoEjYk0NpOQ5FBpySxyVz/QLX8eX0fbvmFZU0pwl+B+6
	 1IrxySrob/SI2ehvaWDJ64GuDSXWz16AXGfuPLqQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 64F58F80111;
	Mon, 18 Oct 2021 17:17:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8B60CF80224; Mon, 18 Oct 2021 17:17:09 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BB860F80111
 for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2021 17:17:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BB860F80111
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="314466193"
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; d="scan'208";a="314466193"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2021 08:15:11 -0700
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; d="scan'208";a="566102971"
Received: from dsardana-mobl.amr.corp.intel.com (HELO [10.209.189.174])
 ([10.209.189.174])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2021 08:15:11 -0700
Subject: Re: [PATCH] ASoC: Intel: sof_sdw: Initialize the sof_sdw_quirk with
 RT711_JD_NULL
To: Chris Chiu <chris.chiu@canonical.com>
References: <20211015133424.494463-1-chris.chiu@canonical.com>
 <c40282f6-cb8f-22ca-4a57-26fcbc39f423@linux.intel.com>
 <CABTNMG0oef2AQywfzQ3iMfHWXxi6RDUL9VaQ_cYfbFp1JZqAWg@mail.gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <16370bb9-51d4-69ab-8de9-b0dc09377f1c@linux.intel.com>
Date: Mon, 18 Oct 2021 10:15:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABTNMG0oef2AQywfzQ3iMfHWXxi6RDUL9VaQ_cYfbFp1JZqAWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 yang.jie@linux.intel.com, Linux Kernel <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, liam.r.girdwood@linux.intel.com,
 broonie@kernel.org
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


>> On 10/15/21 8:34 AM, Chris Chiu wrote:
>>> The jd_src of RT711 which is initialized in rt711/rt711_sdca_init
>>> will be overridden by rt711/rt711_sdca_add_codec_device_props when
>>> the sof_sdw_quirk is not RT711_JD_NULL. It will force the JD mode
>>> to RT711_JD1 and cause confusion while debugging the JD mode of
>>> the boards without quirk. Initialize sof_sdw_quirk with RT711_JD_NULL
>>> to honor the jd_src value in rt711/rt711_sdca init.
>>
>> Not able to follow what the "confusion while debugging the JD mode of
>> the boards without quirk" is. You need a DMI quirk or need to override
>> the default quirk with the kernel module parameter.
>>
> The JD mode will be set by rt711/rt711_sdca_init first (which is JD2
> as https://github.com/torvalds/linux/blob/master/sound/soc/codecs/rt711.c#L1209.
> Then it will be overridden by rt711_add_codec_device_props() while doing
> rt711_parse_dt(), which is now always JD1 since the current
> sof_sdw_quirk init value.
> I'm afraid that JD2 is a more preferable mode rather than JD1. Then we
> will have to
> maintain a bigger DMI quirk table for more and more coming alderlake machines.
> 
> Given the rt711 codec has initialized the jd_src to JD2, The
> sof_sdw_quirk should only
> override it unless necessary? But now it's forced to override. Or can
> we have a more
> generic solution for it?

I don't mind changing the default if the majority of devices uses JD2.
But your patch doesn't do this cleanly, it breaks all usages of JD1 that
relied on the previous default.

Changing the default for jack detection also doesn't really decrease the
need for quirks in itself, for this we would need to handle the RT715
quirk and also fix the amplifier link id, and also set the HDMI quirk
depending on the platform setting. Bard's working on this, see
https://github.com/thesofproject/linux/pull/3203
