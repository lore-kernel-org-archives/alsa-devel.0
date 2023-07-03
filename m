Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E58EB64DC
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Jul 2023 10:18:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 717237F4;
	Mon,  3 Jul 2023 12:17:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 717237F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688379529;
	bh=i62GN2bf2WCmM4juVSyEvrOQ+WSzkAJn0/vXk83T9jw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=RAyW+SGUMjAueszDzBTkQAtNffySpnDuK2cTsOW8B+cKRCGIA6G9NkFQ8bNJRWma7
	 VsBbtjk6IzcjH7ZWYDqL6j8VVF0lZiZMBra3quBLNmRTOiLtb9PiRx+XGp6WwBjp8O
	 tCEgew6ZcZR2cXjvymwWavPYIho45vecgr21m98A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B1136F80132; Mon,  3 Jul 2023 12:17:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 47C3AF80132;
	Mon,  3 Jul 2023 12:17:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 36C41F80132; Mon,  3 Jul 2023 12:17:32 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 01D92F80104
	for <alsa-devel@alsa-project.org>; Mon,  3 Jul 2023 12:17:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01D92F80104
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=SJGCWUMq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688379447; x=1719915447;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i62GN2bf2WCmM4juVSyEvrOQ+WSzkAJn0/vXk83T9jw=;
  b=SJGCWUMqTACDeLk3OJEA2U4lP3Q7Qs8ICSfS4xvlLLO0pkhK1++TAM67
   E431xJLlWUaC0bSWOySlj4ds063Vi/CHVE8V72qFW3Ux4v1VbKN7CbGBY
   9BSLH3lWBekcwQq2VRIsSivR4ObRWlFPQGtYWkqd6WBaAiwNPN34Nz7x9
   ziX9SJk3MFSAvwbAzJMQrrgrU2dUgaabEoEngxb5UNaYXdxIxnA/DH1n6
   G5Sl5y6a0WUhWLSrO1uRqT7D20IGbtmh9t0QgZqaWLEYDvIZDk/X7mJ5y
   MvUaIqHaYBg5YAP7fIIGAOE/i/86qmHxeFwuPH9PxE4zZrszvErueP4Ym
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="428887764"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200";
   d="scan'208";a="428887764"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2023 03:17:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="965143810"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200";
   d="scan'208";a="965143810"
Received: from agherasi-mobl.ger.corp.intel.com (HELO [10.251.218.180])
 ([10.251.218.180])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2023 03:17:19 -0700
Message-ID: <f9e83b61-6e69-2467-d5a5-3c3a6a40e018@linux.intel.com>
Date: Mon, 3 Jul 2023 12:17:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 1/5] ASoC: rt5682-sdw: fix for JD event handling in
 ClockStop Mode0
Content-Language: en-US
To: shumingf@realtek.com, broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com,
 oder_chiou@realtek.com, jack.yu@realtek.com, derek.fang@realtek.com,
 Vijendar.Mukunda@amd.com, Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20230703090247.25261-1-shumingf@realtek.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230703090247.25261-1-shumingf@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: BMJ5XTKLATEUELJWLTTBO4XBUVOGEH2P
X-Message-ID-Hash: BMJ5XTKLATEUELJWLTTBO4XBUVOGEH2P
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BMJ5XTKLATEUELJWLTTBO4XBUVOGEH2P/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 7/3/23 11:02, shumingf@realtek.com wrote:
> From: Shuming Fan <shumingf@realtek.com>
> 
> During ClockStop Mode0, peripheral interrupts are disabled.

I can see that the interrupts are disabled in
rt5682_dev_system_suspend(), which is NOT a mode where the clock stop is
used... I don't think this commit message is correct.

The IMPL_DEF interrupt which is used for jack detection is not disabled
at all during any clock stop mode, and it shouldn't otherwise that would
break the jack detection.

> When system level resume is invoked, Peripheral SDCA interrupts
> should be enabled to handle JD events.

The initial 'when system level resume is invoked' is aligned with my
comment above, this interrupt disabling is only for system suspend.

In addition, I think it's a copy paste here, there is no SDCA support in
RT5682 or the initial RT711.

> Enable SDCA interrupts in resume sequence when ClockStop Mode0 is applied.

same comments for rt711-sdw.c and other codecs which use the same
pattern with the same comment

	/*
	 * prevent new interrupts from being handled after the
	 * deferred work completes and before the parent disables
	 * interrupts on the link
	 */

BTW if this is an issue for system suspend, maybe we should disable the
interrupts on the link in the .prepare stage, that would remove this
step in all codec drivers? The .prepare deals with the parent first,
while .suspend deal with child devices first. The drawback would be that
the codec driver would depend on the manager driver doing the right
thing, which isn't great.

> Signed-off-by: Shuming Fan <shumingf@realtek.com>
> ---
>  sound/soc/codecs/rt5682-sdw.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/rt5682-sdw.c b/sound/soc/codecs/rt5682-sdw.c
> index 67404f45389f..4968a8c0064d 100644
> --- a/sound/soc/codecs/rt5682-sdw.c
> +++ b/sound/soc/codecs/rt5682-sdw.c
> @@ -750,8 +750,15 @@ static int __maybe_unused rt5682_dev_resume(struct device *dev)
>  	if (!rt5682->first_hw_init)
>  		return 0;
>  
> -	if (!slave->unattach_request)
> +	if (!slave->unattach_request) {
> +		if (rt5682->disable_irq == true) {
> +			mutex_lock(&rt5682->disable_irq_lock);
> +			sdw_write_no_pm(slave, SDW_SCP_INTMASK1, SDW_SCP_INT1_IMPL_DEF);
> +			rt5682->disable_irq = false;
> +			mutex_unlock(&rt5682->disable_irq_lock);
> +		}
>  		goto regmap_sync;
> +	}
>  
>  	time = wait_for_completion_timeout(&slave->initialization_complete,
>  				msecs_to_jiffies(RT5682_PROBE_TIMEOUT));
