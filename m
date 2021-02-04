Return-Path: <SRS0=grW5=HG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B1BC433E9
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 11:14:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A4E64F60
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 11:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A4E64F60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 53BF51701;
	Thu,  4 Feb 2021 12:13:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 53BF51701
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612437277;
	bh=7/eHfKNTEC0+HH98ZM/GpHNXW/8H/HmztxzklvHGCUE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iP6o5S8OCO7ga14TkHcLE+lI5NyiRl4EeYvprbL6AxwbS8H3oHA+gbRr55nFHMnzg
	 sJ6vpwb7mt9T+Pp3X3/Oz/jGQBUKPVArl8IgtxNPIVRlUjjsmaWxeJdbHffeiw+63w
	 hg40XwIv3Tr0BVWB/n8iUftl7DXl1H9ks/UyNGNs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D5CA1F80155;
	Thu,  4 Feb 2021 12:13:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1C6B2F80171; Thu,  4 Feb 2021 12:13:46 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 92951F80154
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2021 12:13:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 92951F80154
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="mBZTKoHY"
Received: by mail-wr1-x435.google.com with SMTP id m13so2975466wro.12
 for <alsa-devel@alsa-project.org>; Thu, 04 Feb 2021 03:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=hDqkZ034GsWBNXf5wCFh1fktNzwoeRLyXm2KKed+4t4=;
 b=mBZTKoHYlY2De5z/mqTT2QRil7LYGw3eCThaEcw+X0pMRocirE4uHgdj2yOv74ZDDM
 zyMgrqbEFXKVuvGuUjZmLgIoNOFy1CYwJY82ZzV0f0cO4RwFmj7ovGKaXJammO5oUSVM
 9M+3q2B5Bxz12ilMlxblEMHSfKP0xKl0eRoWTxnOd3VgY7++Lpise1AfZzqp3+HpPCzM
 //hQSb/Su5sI0RvlWD/c3GdYiRZQQVcmsdmYKbNOabxSDMSly4t0l90zmV8hsYoy16OZ
 oB+h4SfR+Pp95D3/9ozzdhkQu1Nl/iMu9ZoejdS75nURuCA7zVOu0Zuiy3BWJUl+GD9W
 yPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=hDqkZ034GsWBNXf5wCFh1fktNzwoeRLyXm2KKed+4t4=;
 b=HPWkHf+xgs9OhI0FWSSvZCkQ3H6EWawLTANg34BkHIgXytiE6wO2nsCciCc4/tv817
 nkOLSbEle7Lu7HiJn1n5VAK+Mf9sgJFdkeslbre+5snO+RhUm4PIBWOaI0WhLhvdKmfC
 7Dqlkw2Y0BX/oAwk+sDX2To5Tby9EzbwuZ53DGVJKKW6xImphE5McBtMRNZYA8gGPl5N
 wkk7Oqt3OI1NMdr2KGDzQJUnZrVJDb3HLUKJ7i/us8RrYTsBrd3pk050sdcjhOY/QazE
 gtsje1nIXNNQe26sKBUDbPiYk5ESZaZGM+QrKgwvvC24ycp1454TgfOhvx/mLWAIVCfE
 HDAQ==
X-Gm-Message-State: AOAM530xQ7xpQmwSrkY1UWgwS19eScpagxDoLPPzqFoxzUeWmBaB3VlI
 IhU/o6Qc4sET2Qq43rqBt8tO+A==
X-Google-Smtp-Source: ABdhPJwBys/RVOGfm9bB2CtIW7htZKhreS+jn/9NWZuUmHKQ3dZHFqkcCAkwCP6avn8JNKjHF0kd9Q==
X-Received: by 2002:adf:a2ca:: with SMTP id t10mr8672064wra.370.1612437222674; 
 Thu, 04 Feb 2021 03:13:42 -0800 (PST)
Received: from dell ([91.110.221.188])
 by smtp.gmail.com with ESMTPSA id q6sm7056367wrw.43.2021.02.04.03.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Feb 2021 03:13:42 -0800 (PST)
Date: Thu, 4 Feb 2021 11:13:40 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v4 00/13] MFD/extcon/ASoC: Rework arizona codec
 jack-detect support
Message-ID: <20210204111340.GF2789116@dell>
References: <20210123121313.79530-1-hdegoede@redhat.com>
 <20210204110539.GE2789116@dell>
 <3c996ea7-57dc-11ba-adc1-15fb7b97f107@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c996ea7-57dc-11ba-adc1-15fb7b97f107@redhat.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Mark Brown <broonie@kernel.org>
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

On Thu, 04 Feb 2021, Hans de Goede wrote:

> Hi,
> 
> On 2/4/21 12:05 PM, Lee Jones wrote:
> > On Sat, 23 Jan 2021, Hans de Goede wrote:
> > 
> >> Hi all,
> >>
> >> Here is v4 of my series to rework the arizona codec jack-detect support
> >> to use the snd_soc_jack helpers instead of direct extcon reporting.
> >>
> >> This is done by reworking the extcon driver into an arizona-jackdet
> >> library and then modifying the codec drivers to use that directly,
> >> replacing the old separate extcon child-devices and extcon-driver.
> >>
> >> This brings the arizona-codec jack-detect handling inline with how
> >> all other ASoC codec driver do this. This was developed and tested on
> >> a Lenovo Yoga Tablet 1051L with a WM5102 codec.
> >>
> >> There are various interdependencies between the patches in this
> >> series, so IMHO it would be best if this entire series would be merged
> >> through the MFD tree.
> >>
> >> Note this series applies on top of my "[PATCH v4 0/5] MFD/ASoC: Add
> >> support for Intel Bay Trail boards with WM5102 codec" series.
> >>
> >> Changes in v4:
> >> - Add sound/soc/codecs/arizona-jack.c to the WOLFSON MICROELECTRONICS DRIVERS
> >>   MAINTAINERS section
> >> - Small codying style tweaks to the "ASoC: arizona-jack: Cleanup logging" patch
> >>
> >> Changes in v3:
> >> - Move the bugfix patches to earlier in the series so that they
> >>   apply to drivers/extcon/extcon-arizona.c so that they can be
> >>   cherry-picked into the stable series
> >> - Split runtime_pm_get -> runtime_pm_get_sync changes out into their
> >>   own patch
> >> - Simply move drivers/extcon/extcon-arizona.c to
> >>   sound/soc/codecs/arizona-jack.c instead of first adding arizona-jack.c
> >>   as a copy and then later removing extcon-arizona.c
> >> - Some other small tweaks, see individual patch changelogs
> >>
> >> Regards,
> >>
> >> Hans
> >>
> >>
> >> Hans de Goede (13):
> >>   mfd: arizona: Drop arizona-extcon cells
> >>   extcon: arizona: Fix some issues when HPDET IRQ fires after the jack
> >>     has been unplugged
> >>   extcon: arizona: Fix various races on driver unbind
> >>   extcon: arizona: Fix flags parameter to the gpiod_get("wlf,micd-pol")
> >>     call
> >>   extcon: arizona: Always use pm_runtime_get_sync() when we need the
> >>     device to be awake
> >>   ASoC/extcon: arizona: Move arizona jack code to
> >>     sound/soc/codecs/arizona-jack.c
> >>   ASoC: arizona-jack: Move jack-detect variables to struct arizona_priv
> >>   ASoC: arizona-jack: Use arizona->dev for runtime-pm
> >>   ASoC: arizona-jack: convert into a helper library for codec drivers
> >>   ASoC: arizona-jack: Use snd_soc_jack to report jack events
> >>   ASoC: arizona-jack: Cleanup logging
> >>   ASoC: arizona: Make the wm5102, wm5110, wm8997 and wm8998 drivers use
> >>     the new jack library
> > 
> >>   ASoC: Intel: bytcr_wm5102: Add jack detect support
> > 
> > Can't apply this patch ...
> > 
> >>  MAINTAINERS                                   |   3 +-
> >>  drivers/extcon/Kconfig                        |   8 -
> >>  drivers/extcon/Makefile                       |   1 -
> >>  drivers/mfd/arizona-core.c                    |  20 -
> >>  sound/soc/codecs/Makefile                     |   2 +-
> >>  .../soc/codecs/arizona-jack.c                 | 577 +++++++-----------
> >>  sound/soc/codecs/arizona.h                    |  44 ++
> >>  sound/soc/codecs/wm5102.c                     |  12 +-
> >>  sound/soc/codecs/wm5110.c                     |  12 +-
> >>  sound/soc/codecs/wm8997.c                     |  14 +-
> >>  sound/soc/codecs/wm8998.c                     |   9 +
> >>  sound/soc/intel/boards/bytcr_wm5102.c         |  28 +-
> > 
> > ... since this file doesn't exist?
> 
> As mentioned this is a follow-up series on top of the:
> 
> "[PATCH v4 0/5] MFD/ASoC: Add support for Intel Bay Trail boards with WM5102 codec"
> 
> Series, that series adds that file.

Okay, that makes sense.  Thanks.

> Regards,
> 
> Hans
> 
> p.s.
> 
> Do you want a resend of this one, with the new *-bys added too ?

Only this one please.

I'll try to take the other one through now.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
