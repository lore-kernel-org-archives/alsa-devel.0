Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31FBC433F5
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Apr 2022 03:37:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EAADE1700;
	Thu,  7 Apr 2022 05:36:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EAADE1700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649302649;
	bh=fNARzUYWCWEFMOy3OrUny7NCKu8gMH3rlx8PZw5PQfw=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vPhQ96J/7iMhDKnJMGmTbBsXP759M2PREkAp0KcrnfuxE9Glg2qlgR6CSZbND4GO0
	 rCCBhDOxONE6jyOFIRhWkMjJ5nKijhgzylJt7rFvOcWXCgH8dtmzFCnboAg06LeomB
	 MIZYDDF4PAtu2B3mpjtwdxcD23XmOcUdV7uFgMs8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7FD7DF80141;
	Thu,  7 Apr 2022 05:36:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D8FECF8024C; Thu,  7 Apr 2022 05:36:36 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 38E3FF8012A
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2022 05:36:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 38E3FF8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="ROy0m9gE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649302594; x=1680838594;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=fNARzUYWCWEFMOy3OrUny7NCKu8gMH3rlx8PZw5PQfw=;
 b=ROy0m9gEUm+lQCQYliRL5lfLoCZt0hfNLKAg3Q+uhT5CQ2czOp3Bh8Qc
 D0WyiLDWbJ+9DI4+B+Km+hNHxuIbGktkLxbfZsJC80Zq3BWvQiHK+K3ck
 rWTgaYFoRVIDJ84iabWa3D8Dpuz/SPKUEUQvapqS/GeKsFAH4nWWk4Qkd
 7oAVOyMojVXllvAAWWQLmDqLpp0Y1htuN7kND48VSuA1ydFfOrm8OQ+RH
 YXfXn4o1Tb5rNWLuWgKHPvfJcBExzpBxudFnxmzv8o8AbVLE2nKYfWYAF
 jRbhnXDFo2PJZ3D1hmTaN/F5Tlu7SI8TJ0ruxS6np07o0xlZxhI5raAQ6 Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="258810964"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; d="scan'208";a="258810964"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2022 20:36:28 -0700
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; d="scan'208";a="505987677"
Received: from arkadee1-mobl.amr.corp.intel.com (HELO [10.209.98.109])
 ([10.209.98.109])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2022 20:36:27 -0700
Message-ID: <0dac70ef-1355-3379-ef41-eec6467886b1@linux.intel.com>
Date: Wed, 6 Apr 2022 22:08:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v4 3/4] ASoC: Intel: sof_es8336: add a quirk for headset
 at mic1 port
Content-Language: en-US
To: Mauro Carvalho Chehab <mchehab@kernel.org>, alsa-devel@alsa-project.org
References: <cover.1649275618.git.mchehab@kernel.org>
 <baf412bc431650fc7f3a157c6ab96d08120940fc.1649275618.git.mchehab@kernel.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <baf412bc431650fc7f3a157c6ab96d08120940fc.1649275618.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>,
 =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 linux-kernel@vger.kernel.org
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


>   static int sof_es8316_speaker_power_event(struct snd_soc_dapm_widget *w,
> @@ -145,13 +148,23 @@ static const struct snd_soc_dapm_route sof_es8316_audio_map[] = {
>   	{"Speaker", NULL, "HPOL"},
>   	{"Speaker", NULL, "HPOR"},
>   	{"Speaker", NULL, "Speaker Power"},
> +
> +	{"Differential Mux", "lin1-rin1", "MIC1"},
> +	{"Differential Mux", "lin2-rin2", "MIC2"},
> +	{"Differential Mux", "lin1-rin1 with 20db Boost", "MIC1"},
> +	{"Differential Mux", "lin2-rin2 with 20db Boost", "MIC2"},

this is surprising, shouldn't this be part of the codec driver?

The part that should be machine-specific is really how MIC1 or MIC2 are 
connected (as done below), but the routes above seem machine-independent?

Or is this a work-around for a miss in the codec driver?

Confused...

>   };
>   
> -static const struct snd_soc_dapm_route sof_es8316_intmic_in1_map[] = {
> +static const struct snd_soc_dapm_route sof_es8316_headset_mic2_map[] = {
>   	{"MIC1", NULL, "Internal Mic"},
>   	{"MIC2", NULL, "Headset Mic"},
>   };
>   
> +static const struct snd_soc_dapm_route sof_es8316_headset_mic1_map[] = {
> +	{"MIC2", NULL, "Internal Mic"},
> +	{"MIC1", NULL, "Headset Mic"},
> +};
> +

