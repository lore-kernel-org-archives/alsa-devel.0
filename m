Return-Path: <SRS0=TLt2=KT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC41C04FF3
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 14:23:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8350C61370
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 14:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8350C61370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C4397844;
	Mon, 24 May 2021 16:22:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C4397844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621866204;
	bh=4tnc0+n2Y4X8JIbtBHib+pNtE8xO/bgJkDWcJOfkJEI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b83UXmyGWU5UVZ018r0mDqI8ChVTtEq+tUO7QfZ4FWFljVLmXGnLTxXhHefJ8KRD9
	 pydNwKuYZ88cPuPMQzleQmNkDJxA+9SE+pVdxfH8fDcj1u4jKyeRNoBgiq+OGC0MI5
	 7HSHrnTOzh5XNXqAhESdakVM6KurYoAmqX5Z+nn0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 243E1F8023A;
	Mon, 24 May 2021 16:22:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B9B8F80149; Mon, 24 May 2021 16:22:00 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 16F12F80149
 for <alsa-devel@alsa-project.org>; Mon, 24 May 2021 16:21:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 16F12F80149
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="o6fgqnwr"
Received: by mail-lf1-x136.google.com with SMTP id v8so35929648lft.8
 for <alsa-devel@alsa-project.org>; Mon, 24 May 2021 07:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WvxUCc4ZAD7JYmOhdqHj+SdkI9uXTGsko5jiNtvAqJY=;
 b=o6fgqnwr/iJTavwVswhSV4k99P8BafEWqYYIfXXbwUtA4v60ZhFBYMCjHizLrbq+TX
 ++xPzdtG7C28hAOIPeCnIuNKQ4B5/WeEQKPyn+1PyauS2DaWhKb+Hi4oVeCq5byDTD+1
 CyRJ7XA8zUmuJzfHzdxwR5nqjPkVkptx9djQP+LypIKIkotsMNii8kfqgUjm2KgX3NBN
 NaNVJNKCd7zCBpaMBULzRuQK0acqq6tkta5q0n/AkVYdG1pwNwkhscwFGmgxy/ifJhBi
 FwI4kyX4SpaN8HTSKAOEdIHH4e+WH8B9cIdslznOyYOrKjvwhy4q0uppKB3mMSY9ggLL
 eSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WvxUCc4ZAD7JYmOhdqHj+SdkI9uXTGsko5jiNtvAqJY=;
 b=hBw6XxeEBWn2CB01f6xLtf/KlO6j5/QuVKsWnkoiaGuEctxXmX1NT1ahsyrW3iRVDO
 EVi2Cppne0hdvfWim7t+eVOCsTN1cPnbqayfnZHeC8Ba4a2Dgij9P3nu2x2KVgaaTIem
 J6wGt3XUrXWxnJySIWbcUgcNwvJDVmpagpoDUGB7wpA4ry3UAl3nEel9/9ruEirl0gHU
 oSyELZHba0bDA7NTTOyM5PU3WA7I/UFbgiVX+EZeRjNfOhATDVYJvtH4LTTumNA8VE46
 cWXB1D6qg/zgHFTT2x683tUrtOb3+IWhyaAvJ3wuIXF+0ac2BvcPP3iVHYFvTIb5IDVU
 88bA==
X-Gm-Message-State: AOAM530Aez4KCRfkd64aOpMNUsi2pbMNZ09cFwluuopbr2AG0yctxbdC
 SNP4ISn3uddcGwx+nqLMCBk=
X-Google-Smtp-Source: ABdhPJzFat9+xw6z6xb6vabA7m52F4NNlfFIXDqG7AykgsV5FYW7+YO6F4mWHEKuyGSkYVObuXic4Q==
X-Received: by 2002:a05:6512:1027:: with SMTP id
 r7mr10988589lfr.153.1621866117028; 
 Mon, 24 May 2021 07:21:57 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-110.dynamic.spd-mgts.ru.
 [109.252.193.110])
 by smtp.googlemail.com with ESMTPSA id v25sm1492344lfe.60.2021.05.24.07.21.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 May 2021 07:21:56 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] ASoC: tegra: Unify ASoC machine drivers
To: kernel test robot <lkp@intel.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>
References: <20210523234437.25077-3-digetx@gmail.com>
 <202105241048.gypbTx2I-lkp@intel.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <97f88bb4-2dcf-4905-ac07-f08adf2f6582@gmail.com>
Date: Mon, 24 May 2021 17:21:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <202105241048.gypbTx2I-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: linux-tegra@vger.kernel.org, clang-built-linux@googlegroups.com,
 alsa-devel@alsa-project.org, kbuild-all@lists.01.org
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

24.05.2021 05:34, kernel test robot пишет:
>     66	
>     67	static int tegra_machine_event(struct snd_soc_dapm_widget *w,
>     68				       struct snd_kcontrol *k, int event)
>     69	{
>     70		struct snd_soc_dapm_context *dapm = w->dapm;
>     71		struct tegra_machine *machine = snd_soc_card_get_drvdata(dapm->card);
>     72	
>   > 73		if (machine->asoc->dapm_event) {
>     74			int ret = machine->asoc->dapm_event(w, k, event);
>     75			if (ret <= 0)
>     76				return ret;
>     77		}

That dapm_event hook indeed shouldn't belong to this patch. I changed my
build scripts to compile-test sound drivers. This will be fixed in v4.
