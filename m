Return-Path: <SRS0=EjE+=M2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4B5C4338F
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 13:21:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5F4260EB9
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 13:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C5F4260EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 93FAA1797;
	Tue,  3 Aug 2021 15:20:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 93FAA1797
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627996880;
	bh=nev0SuVC38EM9PEepSTCBs6PScF4sxHdjQ2dLWociJw=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r28miZ++RtEJz/1KpPxH6/udqraIBx9VUKGqEv4usRXSKwuKayfRRWjDPDjbwTWj8
	 xOZabEsrQ+JP7CJcsmfbo1zHLxMr82BWQwTMMDa3eR/1w/TKoB26M2nsq0WGQI8Pxy
	 MXEwjDX0jivu2XXq0CeGliWmIqo2s+3cz1KCGgS4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 26898F8014D;
	Tue,  3 Aug 2021 15:20:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 05558F802E8; Tue,  3 Aug 2021 15:20:28 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0AD15F80095
 for <alsa-devel@alsa-project.org>; Tue,  3 Aug 2021 15:20:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0AD15F80095
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="299274390"
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; d="scan'208";a="299274390"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2021 06:20:20 -0700
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; d="scan'208";a="521246523"
Received: from vmustya-mobl1.amr.corp.intel.com (HELO [10.213.171.71])
 ([10.213.171.71])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2021 06:20:19 -0700
Subject: Re: [PATCH v3 2/4] ASoC: codecs: wcd: add multi button Headset
 detection support
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, broonie@kernel.org
References: <20210604115230.23259-1-srinivas.kandagatla@linaro.org>
 <20210604115230.23259-3-srinivas.kandagatla@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <139e6867-2d29-09e0-d059-399917e5962d@linux.intel.com>
Date: Mon, 2 Aug 2021 19:03:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210604115230.23259-3-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: robh@kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
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

Hi Srinivas,
cppcheck reports an issue with the use of 'hphpa_on' below

> +static irqreturn_t wcd_mbhc_adc_hs_rem_irq(int irq, void *data)
> +{
> +	struct wcd_mbhc *mbhc = data;
> +	unsigned long timeout;
> +	int adc_threshold, output_mv, retry = 0;
> +	bool hphpa_on = false;

assigned here

> +
> +	mutex_lock(&mbhc->lock);
> +	timeout = jiffies + msecs_to_jiffies(WCD_FAKE_REMOVAL_MIN_PERIOD_MS);
> +	adc_threshold = wcd_mbhc_adc_get_hs_thres(mbhc);
> +
> +	do {
> +		retry++;
> +		/*
> +		 * read output_mv every 10ms to look for
> +		 * any change in IN2_P
> +		 */
> +		usleep_range(10000, 10100);
> +		output_mv = wcd_measure_adc_once(mbhc, MUX_CTL_IN2P);
> +
> +		/* Check for fake removal */
> +		if ((output_mv <= adc_threshold) && retry > FAKE_REM_RETRY_ATTEMPTS)
> +			goto exit;
> +	} while (!time_after(jiffies, timeout));
> +
> +	/*
> +	 * ADC COMPLETE and ELEC_REM interrupts are both enabled for
> +	 * HEADPHONE, need to reject the ADC COMPLETE interrupt which
> +	 * follows ELEC_REM one when HEADPHONE is removed.
> +	 */
> +	if (mbhc->current_plug == MBHC_PLUG_TYPE_HEADPHONE)
> +		mbhc->extn_cable_hph_rem = true;
> +
> +	wcd_mbhc_write_field(mbhc, WCD_MBHC_DETECTION_DONE, 0);
> +	wcd_mbhc_write_field(mbhc, WCD_MBHC_ADC_MODE, 0);
> +	wcd_mbhc_write_field(mbhc, WCD_MBHC_ADC_EN, 0);
> +	wcd_mbhc_elec_hs_report_unplug(mbhc);
> +	wcd_mbhc_write_field(mbhc, WCD_MBHC_BTN_ISRC_CTL, 0);

not used, so hphpa_on == false

> +	if (hphpa_on) {
> +		hphpa_on = false;
> +		wcd_mbhc_write_field(mbhc, WCD_MBHC_HPH_PA_EN, 3);
> +	}

And this branch is never taken.

Is there a missing hphpa = true assignment somewhere?


There's an additional issue while I am at it:

sound/soc/codecs/wcd-mbhc-v2.c:1225:17: style: Variable 'clamp_state' is
assigned a value that is never used. [unreadVariable]
 u8 clamp_state = 0;
                ^

-Pierre
