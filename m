Return-Path: <SRS0=LtCP=G4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0E8C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jan 2021 15:28:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00997230FA
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jan 2021 15:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00997230FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 821751800;
	Mon, 25 Jan 2021 16:27:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 821751800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611588511;
	bh=0j8wGW1ENpx9bP0UfAqfN8LbD2XH46Fy9VKAfRpFTCU=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EfnPvANgKoQYVA9HWYBLDjzw7kxcqzLySUURhN75N1Cz7rFTgwqw/YNAMK6zqaMwf
	 vhGfcE4cg8NHATfkix7BBCj3hqkLPTcnZMbCHzYlSJ6UxJY8a3Cjx2pDnZHdU/9njB
	 Ul+Xb04j0wErkH9qPZxiTBCXuVysxWUfnvuC3Q+U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 072E6F80259;
	Mon, 25 Jan 2021 16:27:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 391D5F8025F; Mon, 25 Jan 2021 16:27:39 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 58186F80130
 for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2021 16:27:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 58186F80130
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="apX8fpQR"
Received: by mail-lf1-x12c.google.com with SMTP id v24so18337197lfr.7
 for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2021 07:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=UoWqLYFxEb3nF4ce0Tbsv2hSrI7OApPalzEh2y4l+cg=;
 b=apX8fpQRgXrDIIQdjhUlTMXanMxM8vUDXIXSQxsrotsPIpCU3fVl8nY1YSQaDejIuV
 dMgju/qSlputc6pRNtgKBzQxzNpw4j9gADNtjJHru12juCIpeM8mif1GHz2d0r/2k16o
 aSR7B67E5usnCWLnTai1SHUwssmY+SFCBsktn2XmcUibTdzawm4AHdcZ/mq1ZYxmQwvb
 qfUNzewXuyTQMasbbW02FnhTG71BJB5ta2ayJHvm+eYvOxS8NSUQKUikYW+vBWlcNs1a
 fUKPSWRLzYwNO2Q7MVbX90QA18Fe7TsS8XixZVhjR7DOjzoEljVqH9PhXu06e64suN7K
 HTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UoWqLYFxEb3nF4ce0Tbsv2hSrI7OApPalzEh2y4l+cg=;
 b=e2t0obAEFIHiER7eMEI8g8yVGzKLTGZ2c71t0BoHjvGUmp5qikQRS8afCH+ywvu0Jf
 8okAt8L5L9Ac7dpF7yrutfsutFLGzlc/DYqMMATkjrApQjNIFMelveKksMF+aWgPPV2X
 p2wQPUMLXlKCzKCGLzYa5pTS2sCypheESgN7QyzGDOVF6p9qXl0j611rXdBtkmPuKNuq
 ZP9uAn2g5eEpbWzeE9xBszx8OYpClKroescr8OfYw/2F7XtbZXZZ6p7P2tpo4iCSHiNe
 NEVXcQh37nWjA2sTVLHt3J6LaM/Qcgzjltpz1ikj+6b5FAsSXylYcV4qnuBRIzoOaohl
 pA3A==
X-Gm-Message-State: AOAM530hd8xBlZ8/SRAq5djbTvUxde1MUssica37DQqHnyDlYRUJkrDU
 iRPaoFgGs/Jquk35ALVBD3U=
X-Google-Smtp-Source: ABdhPJzDcoM6wlnR4aq1O5cH1RDetElITIqHpJu7IarP73ywYIe7RT+4sbqdWBMZvwGLKk3tZuJ6Fg==
X-Received: by 2002:a19:d83:: with SMTP id 125mr460486lfn.651.1611588451591;
 Mon, 25 Jan 2021 07:27:31 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru.
 [109.252.192.57])
 by smtp.googlemail.com with ESMTPSA id x2sm1928237ljd.63.2021.01.25.07.27.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Jan 2021 07:27:31 -0800 (PST)
Subject: Re: [PATCH v3 2/6] ALSA: hda/tegra: Reset hardware
To: Takashi Iwai <tiwai@suse.de>
References: <20210120003154.26749-1-digetx@gmail.com>
 <20210120003154.26749-3-digetx@gmail.com> <s5h35yp3uzn.wl-tiwai@suse.de>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7535a927-5246-4ccf-63fe-f8ded9eb6c52@gmail.com>
Date: Mon, 25 Jan 2021 18:27:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <s5h35yp3uzn.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Nicolas Chauvet <kwizart@gmail.com>,
 linux-kernel@vger.kernel.org, Sameer Pujar <spujar@nvidia.com>,
 Takashi Iwai <tiwai@suse.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Matt Merhar <mattmerhar@protonmail.com>, Peter Geis <pgwipeout@gmail.com>,
 linux-tegra@vger.kernel.org
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

25.01.2021 18:18, Takashi Iwai пишет:
> On Wed, 20 Jan 2021 01:31:50 +0100,
> Dmitry Osipenko wrote:
>>
>> Reset hardware on RPM-resume in order to bring it into a predictable
>> state.
>>
>> Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30 audio works
>> Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30 boot-tested
>> Tested-by: Nicolas Chauvet <kwizart@gmail.com> # TK1 boot-tested
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> 
> Currently we have neither dependency nor reverse-selection of
> CONFIG_RESET_CONTROLLER.  It wouldn't be a problem for builds, but
> you'll get a runtime error from
> devm_reset_control_array_get_exclusive() always when
> CONFIG_RESET_CONTROLLER=n.
> 
> I guess it must be a corner case, but just to be sure.

The CONFIG_RESET_CONTROLLER=y at least for ARM32 Tegra builds.

https://elixir.bootlin.com/linux/v5.11-rc5/source/arch/arm/mach-tegra/Kconfig#L15

Not sure about ARM64.
