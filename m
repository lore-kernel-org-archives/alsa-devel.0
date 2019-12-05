Return-Path: <SRS0=LzfN=Z3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E66C43603
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Dec 2019 03:59:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D1AA20707
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Dec 2019 03:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XZ9+jbkh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D1AA20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 48AD71660;
	Thu,  5 Dec 2019 04:59:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 48AD71660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575518394;
	bh=EmVjIK3Omk4T3KTna4V7TXKLsN8OPvhiWMvEQKzeVN4=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XZ9+jbkhNr11qbGb+ejYKZV8hqkOPFuli7IX9mnZAjo5e1cnLrIkNrCmm0Xe6iUDN
	 GLD6A/7pema0hK6ImWz5QmbsyBueRu/ILg9ion2TYDgYWXityKfJUs9PVi0cfPYG4y
	 le7t5HYoKLmLXgDzDIAU0qaBnn3r2obbL/3JLsDU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AD258F8015A;
	Thu,  5 Dec 2019 04:59:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D39EFF801F8; Thu,  5 Dec 2019 04:58:58 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0C9E4F8010F
 for <alsa-devel@alsa-project.org>; Thu,  5 Dec 2019 04:58:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0C9E4F8010F
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Dec 2019 19:58:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,279,1571727600"; d="scan'208";a="219097101"
Received: from bcmarin-mobl.amr.corp.intel.com (HELO [10.255.230.27])
 ([10.255.230.27])
 by fmsmga001.fm.intel.com with ESMTP; 04 Dec 2019 19:58:47 -0800
To: Curtis Malainey <cujomalainey@google.com>
References: <20191204011118.74217-1-cujomalainey@chromium.org>
 <a828597a-2faa-d672-a6a0-43fcaaa6bca1@linux.intel.com>
 <CAOReqxjqF6kPyX99i7CzLeTip2yVKezo=Laobuk-SRg6_D2n1Q@mail.gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <359b7c67-dae5-b855-ff0f-226aea1e092b@linux.intel.com>
Date: Wed, 4 Dec 2019 21:58:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAOReqxjqF6kPyX99i7CzLeTip2yVKezo=Laobuk-SRg6_D2n1Q@mail.gmail.com>
Content-Language: en-US
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 ALSA development <alsa-devel@alsa-project.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Hui Wang <hui.wang@canonical.com>, Ben Zhang <benzh@chromium.org>,
 Mac Chiang <mac.chiang@intel.com>, Mark Brown <broonie@kernel.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jenny TC <jenny.tc@intel.com>, Bard Liao <bardliao@realtek.com>,
 Sathya Prakash M R <sathya.prakash.m.r@intel.com>,
 Naveen Manohar <naveen.m@intel.com>,
 Curtis Malainey <cujomalainey@chromium.org>, Jon Flatley <jflat@chromium.org>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>
Subject: Re: [alsa-devel] [RESEND PATCH] ASoC: intel: Add Broadwell rt5650
 machine driver
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



On 12/4/19 4:51 PM, Curtis Malainey wrote:
>>
>>> +/* ASoC machine driver for Broadwell DSP + RT5650 */
>>> +static struct snd_soc_card bdw_rt5650_card = {
>>> +     .name = "bdw-rt5650",
>>> +     .owner = THIS_MODULE,
>>
>> is this needed?
> Left over from older conventions, any harm in keeping it? All modules
> from that era appear to have it on the card.
>>
>>> +     .dai_link = bdw_rt5650_dais,
>>> +     .num_links = ARRAY_SIZE(bdw_rt5650_dais),
>>> +     .dapm_widgets = bdw_rt5650_widgets,
>>> +     .num_dapm_widgets = ARRAY_SIZE(bdw_rt5650_widgets),
>>> +     .dapm_routes = bdw_rt5650_map,
>>> +     .num_dapm_routes = ARRAY_SIZE(bdw_rt5650_map),
> 
>>> +static struct platform_driver bdw_rt5650_audio = {
>>> +     .probe = bdw_rt5650_probe,
>>> +     .remove = bdw_rt5650_remove,
>>> +     .driver = {
>>> +             .name = "bdw-rt5650",
>>> +             .owner = THIS_MODULE,
>>
>> is this needed?
> Same as above comment

I am pretty sure Coccinelle detects this pattern and would tell you the 
core takes care of the .owner for platform drivers. I can't recall for 
snd_soc_card.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
