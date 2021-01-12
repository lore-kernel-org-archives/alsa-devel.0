Return-Path: <SRS0=4l9v=GP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B8CC433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jan 2021 22:37:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CD67230FC
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jan 2021 22:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD67230FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E4C3D16BD;
	Tue, 12 Jan 2021 23:36:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E4C3D16BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610491067;
	bh=J7QjE17AqjvLbO+CmL4RXKquFskuE4WPyKHGjh/GR24=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eyBv2LJLavnurhCeBbxy5G+fURAY8fti/YDR/ibwbSicrxZeTWRqvO0VVjXJR/sxX
	 j5PX6bbusJdI+55iwrGaQkJM40XIGA/RAa9FK9ncB1Ejs4f0mXtmyxL26qJpvpuuz/
	 c7M36S1xyLR7BDINp3p3NHlB+kdLfYqwyycjUjfU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 26435F80249;
	Tue, 12 Jan 2021 23:36:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 40E66F8025E; Tue, 12 Jan 2021 23:36:53 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B1F48F80113;
 Tue, 12 Jan 2021 23:36:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B1F48F80113
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SBIoRO8d"
Received: by mail.kernel.org (Postfix) with ESMTPSA id CEA6923132;
 Tue, 12 Jan 2021 22:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610490992;
 bh=J7QjE17AqjvLbO+CmL4RXKquFskuE4WPyKHGjh/GR24=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=SBIoRO8d20IodXaunRyz4gn2Dxrm6UG06lAmRWV+tUrcIu9hmoPj4tnv3QVrkEC2s
 IV8l/vucqrbh4lMDkPa/bUCT+ylCbm09ZBVTtVNiYSjBhZaqbs9wqPorwi6GyLPKYl
 HMltuwO6HjQiUMpX/MO0pqVO7+hUaElnCLsf0UqQHiOF1XDmzfmcPhf35SoMXaZM41
 DarDJDcu8U1ypMErKQktsclHm6ewPZct1w8K8uHORgU0ZYn8EbTqskxIPG4cZf2cAg
 Y+utnJ9BMBNv3VTGeyzz1C9oSXqe5BHJMqTxnla4MUUPS/dZzohSgWAt77D5eNh7Lg
 jlpuC1KmNZLLw==
Received: by mail-oi1-f181.google.com with SMTP id q205so11111oig.13;
 Tue, 12 Jan 2021 14:36:32 -0800 (PST)
X-Gm-Message-State: AOAM53183f7yeeGkRSZuURI9DgFxYMVKxqzf+oGFi+owOBc1Z9EWE9Hg
 M/Uq8CRN6LnVyIYwD1a7X1PhXYm+HMH6K1K938E=
X-Google-Smtp-Source: ABdhPJyeEnuE9UYAY27XsYeaPsmwUePzkTqE4uAODRytnOoCWCRDeZPL5gxUWRj+3mYi22jOIXZCO7NimdvtkCBQ3WA=
X-Received: by 2002:aca:e103:: with SMTP id y3mr814199oig.11.1610490992060;
 Tue, 12 Jan 2021 14:36:32 -0800 (PST)
MIME-Version: 1.0
References: <20210112203250.2576775-1-arnd@kernel.org>
 <20210112203250.2576775-2-arnd@kernel.org>
 <cde511d6-fa14-0cab-f00c-f75ad2d8281c@linux.intel.com>
In-Reply-To: <cde511d6-fa14-0cab-f00c-f75ad2d8281c@linux.intel.com>
From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 12 Jan 2021 23:36:15 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3rOG8eCNQbk01-_t7RtyJknWbo-9tKo3959KhU5tcXsg@mail.gmail.com>
Message-ID: <CAK8P3a3rOG8eCNQbk01-_t7RtyJknWbo-9tKo3959KhU5tcXsg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: intel: fix soundwire dependencies
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>,
 sound-open-firmware@alsa-project.org
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

On Tue, Jan 12, 2021 at 10:03 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> On 1/12/21 2:32 PM, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The Kconfig logic around SND_SOC_SOF_INTEL_SOUNDWIRE tries to
> > ensure that all sound modules can be built with the minimal
> > dependencies, but this fails in some configurations:
> >
> > x86_64-linux-ld: sound/hda/intel-dsp-config.o: in function `snd_intel_dsp_driver_probe':
> > intel-dsp-config.c:(.text+0x134): undefined reference to `sdw_intel_acpi_scan'
> >
> > Specifically, this happens if the dsp-config driver is built-in but does
> > not need to use soundwire, while CONFIG_SOUNDWIRE_INTEL is enabled as
> > a loadable module.
> >
> > An easier and more correct way to do this is to remove
> > CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE_LINK and instead have
> > the two drivers that can link against SOUNDWIRE_INTEL,
> > i.e. DSP_CONFIG and SND_SOC_SOF_HDA, select that driver whenever
> > SND_SOC_SOF_INTEL_SOUNDWIRE_LINK is set.
> >
> > This however means that SND_SOC_SOF_INTEL_SOUNDWIRE cannot be selected
> > by users when SOUNDWIRE is only usable by loadable modules and one or
> > more drivers using SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE is built-in.
>
> The problem is real, but the proposal isn't completely right, there is
> absolutely no logical link or functional dependency between
> INTEL_DSP_CONFIG and SOUNDWIRE.

If that is true, would it be possible to move the call to
sdw_intel_acpi_scan() out of these drivers and one layer
higher where the dependency actually is?

I was indeed wondering whether the intel-dsp-config.c is just
another layering violation: this is another generic piece
of code that seems to contain too much knowledge about
specific hardware implementations.

> We have a similar case with HDaudio, the two buses can be selected as
> tristates, but the SOF configuration needs to match.
>
> In both cases, either we add a 'depends' and users need to make sure the
> configurations match on the two sides. Or we use select but one of the
> selections will be overridden and becomes meaningless.

Maybe something like this:

config SND_SOC_SOF_INTEL_SOUNDWIRE
-        bool "SOF support for SoundWire"
+       tristate "SOF support for SoundWire"
-       depends on SOUNDWIRE && ACPI
+       depends on SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE
+       depends on SOUNDWIRE
+       depends on ACPI
+       depends on !(SOUNDWIRE=m && SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE=y)
+       select SOUNDWIRE_INTEL

I have not tried it, but that should keep it all in one place.

> Arnd, do you mind if I give it a try on my side?

I have no specific attachment to my patch, this was just what I came up
with to fix the build regression locally.

       Arnd
