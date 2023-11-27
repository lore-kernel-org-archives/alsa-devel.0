Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECB7C4167B
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Nov 2023 14:13:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4AA8E83E;
	Mon, 27 Nov 2023 15:12:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4AA8E83E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701094389;
	bh=Qvo3OHW5TO8LFIWZGXILVCyCq2+BIUOQXt5+5AklOAU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=dG5mBiCXUzJbL+Enrx1IknyZ5bjdUk9UriEVnREqzfAD4ZdoH2I6fQOyo09d+MT/t
	 YdcAAX1vYOZggwW7x/J78iSuXsF8h9G/P/KOY6XIIQsl3PE4UHcsUFIh2j//2FFABr
	 BOrCE2GAlXKM+VxbVZxWwjvzEvg7CwhlBXhXXbPs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 09548F80589; Mon, 27 Nov 2023 15:12:36 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 851F5F8056F;
	Mon, 27 Nov 2023 15:12:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A1CA8F8016E; Mon, 27 Nov 2023 15:12:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DC28BF800F5
	for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2023 15:12:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC28BF800F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=dZ0NA9RS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701094348; x=1732630348;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Qvo3OHW5TO8LFIWZGXILVCyCq2+BIUOQXt5+5AklOAU=;
  b=dZ0NA9RSzLLy/U4lrc44VHHGBgUugweU5ogBT4oKXkAJsuttrQ6Xhs6C
   4VDPVwTtizZNNqavDRAA71bxvo0V+Fn0Gfedl8tqpMN/d8HLs+2xcyWpR
   qzKjkSoalrb44suRMKqnh9Uk6h/zTBNpkmzBfVwQ/LHFfuLd3VweASgLu
   F65tiAjQdcLWH2qKe8MxD0trn1vzjgdAjdz7C8ivS+5HQPDyWaHrL7Upi
   gLTSGDI3yzJ7BO8Fg7TpcQLGNZ4sB2Vmeg19UZwcGAeALSP/yAkwWu8ie
   9wYPc4Nn01zdn9aBDJPPfe+hb+SqLsr/5FmFk7O44zxHOERDhiQSqScPg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="391588414"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600";
   d="scan'208";a="391588414"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2023 06:12:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="834330257"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600";
   d="scan'208";a="834330257"
Received: from acornagl-mobl.ger.corp.intel.com (HELO [10.252.58.144])
 ([10.252.58.144])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2023 06:12:19 -0800
Message-ID: <d2fff7cd-ea4b-41b9-992b-fab6ba6549ec@linux.intel.com>
Date: Mon, 27 Nov 2023 16:12:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ALSA: hda/hdmi: Add helper function to check if a
 device is HDMI codec
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
 ranjani.sridharan@linux.intel.com
References: <20231127130245.24295-1-peter.ujfalusi@linux.intel.com>
 <20231127130245.24295-2-peter.ujfalusi@linux.intel.com>
 <87jzq3pc6r.wl-tiwai@suse.de>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <87jzq3pc6r.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: QUJKDSXQLAIJNZJ3PWY44AING4M7A5QA
X-Message-ID-Hash: QUJKDSXQLAIJNZJ3PWY44AING4M7A5QA
X-MailFrom: peter.ujfalusi@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QUJKDSXQLAIJNZJ3PWY44AING4M7A5QA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 27/11/2023 15:18, Takashi Iwai wrote:
>> +bool snd_hda_device_is_hdmi(struct hdac_device *hdev)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(snd_hda_id_hdmi); i++) {
>> +		if (snd_hda_id_hdmi[i].vendor_id == hdev->vendor_id)
>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +EXPORT_SYMBOL_GPL(snd_hda_device_is_hdmi);
> 
> I'm afraid that this will bring unnecessary dependency on HDMI codec
> driver.

For HDMI support we anyways need HDMI code?

> IMO, it's better to add a bool flag is_hdmi to struct hdac_device, and
> let the HDMI codec driver setting it at the probe, instead.  Then we
> can save an extra exported symbol, too.

We only use a combined generic codec driver which just supports 'HDA'
codecs regardless of what type they are.

When things probed via ASoC/SOF I just could not find any other way to
access to this table inside of patch_hdmi.c.

We could sort of 'cheat' and look for a specific (I'm not sure if it is
Intel or HDA generic) mask: 0x4
It is used in Intel drivers to identify the display codec, so the HDMI/DP.
If the 0x4 is universal among all HDA platforms for HDMI/DP then I'm
more than happy to drop this patch, but I'm not sure about  that.

-- 
Péter
