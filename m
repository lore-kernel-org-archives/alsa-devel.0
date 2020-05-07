Return-Path: <SRS0=eFJe=6V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE7DC38A24
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2020 16:29:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 645BE20575
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2020 16:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tMPzZ2xt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=axis.com header.i=@axis.com header.b="jOXcQ6G8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645BE20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B5141829;
	Thu,  7 May 2020 18:28:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B5141829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588868975;
	bh=d+neGSF7iuPaRVBZX5HAbZpjFxJTG5ubAzuWdRZ098M=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tMPzZ2xtLJbrpmrIUckgUnK3GBkQAqUaXpZS0bmarj88g3P1ENImqiy0QNIdO7TrI
	 njW5xpoX795llgotLh7QTNgigKeEccMJehvpCANspeVKfkhJw8Q/+fjAMq0jD+fHmm
	 uRbbQOpA6fG3DJkJ/f4CwAFGftGvPB4vhXadKlLA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 286FCF8015B;
	Thu,  7 May 2020 18:28:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0EA07F8015F; Thu,  7 May 2020 18:28:41 +0200 (CEST)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 75CECF800AD
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2020 18:28:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 75CECF800AD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com
 header.b="jOXcQ6G8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; l=1599; q=dns/txt; s=axis-central1;
 t=1588868915; x=1620404915;
 h=date:from:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=Xp1Dz5OYgZNtXJ52AIDCs0SGAE+jgJCewpSqwHFn+7k=;
 b=jOXcQ6G8Hj8lWEGxqNiDqCesFQqgT4+XDHxkzmCzZSTC3UomcC0FinbI
 xzcZt/Ko8MNlXj5phYtjqt128ofWHG+eiM6WIAphfAcUDjY+g4NJPxupq
 Fz6Zy9ETb+KcVJyXLeWffYJ9nFl9FVC1jvRO5Tv91a3O1vAzvqh0PaEa0
 x3UUsjXkGruXv27UiiAwaMH7fX8mIrUufci4hatdmbjX7GCdKNgDv2w+q
 zuY19hDk0TWgeSRaTu9rZ/az7qjfY0n1HcDanHjzVV/KiaXCDcYZNsxem
 aHO3S4HV557QPKS4YGrzspBNai2wWbRMFso8LrWbd4wO4xqrlQltEeyWT w==;
IronPort-SDR: eGA374VCDgDw5GgznfSlIvmhr98B+LjnWxn+VxzhjNlK/S7jCfWvA06rGN5W0YX8fxlvL9816f
 o47gPPGWoSjmDC8huiL0dOki2/NGhXaWcPps7xd3oVevhjj/0fVq3zq8P+txbwq1A52roJBi8/
 saWOxrSQP2fEYPkoFIfn/wo2XQ39R46jk6uhAY+9bIGaafFgVIgPIHJtDF+PHg60aJ+6VdbPpy
 swVG7Oo9OQKMppFSeA/W75ejDACjwGn2gaWoq5Ja6KnwJGpueLnyScWhvKVIqWPPRUK9f7GhO5
 /7g=
X-IronPort-AV: E=Sophos;i="5.73,364,1583190000"; 
   d="scan'208";a="8266749"
Date: Thu, 7 May 2020 18:28:22 +0200
From: Ricard Wanderlof <ricardw@axis.com>
X-X-Sender: ricardw@lnxricardw1.se.axis.com
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Keeping the codec running at all times
In-Reply-To: <73594637-b978-aca8-e81e-be72a5075ae8@linux.intel.com>
Message-ID: <alpine.DEB.2.20.2005071002590.25559@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.20.2005061709110.12526@lnxricardw1.se.axis.com>
 <7a54134e-ce30-d7d5-bcf3-31269f1103f1@perex.cz>
 <73594637-b978-aca8-e81e-be72a5075ae8@linux.intel.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: XBOX03.axis.com (10.0.5.17) To XBOX03.axis.com (10.0.5.17)
Cc: alsa-devel <alsa-devel@alsa-project.org>
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


On Wed, 6 May 2020, Pierre-Louis Bossart wrote:

> >> In certain system-on-chip systems, with separate ADCs and DACs for
> >> instance, the ADC could generate clocks for the DAC, where it not for the
> >> fact that ALSA shuts down whatever device is not being used in order to
> >> conserve power. Is it possible to instruct ALSA not to do this, i.e. once
> >> a codec has been configured to operate at a given sample rate, it will
> >> continue to do so, even after all streams have stopped.
> >> ...

> It's a valid request, some platforms want to avoid any glitches due to
> clocks and require that they remain active, even if it means writing-off
> power optimizations.

Yes, if one looks at how standalone audio devices normally work, the codec 
is set up at power on time, and just keeps running until the device is 
switched off. Of course in that case, there is usually also some form of 
application that is also running all the time.

> If your codec exposes a clock object then you could have e.g. a board or
> machine driver configure the clock
> (clk_get/clk_set_rate/clk_prepare_enable) and leave it on regardless of
> the streaming usages. You would still need to make sure that the clock
> rates are compatible with the hw_params when streaming does happen.
> that's what e.g. was done for Intel to make sure the MCLK, BCLK and
> FSYNC could be enabled even when the DSP was idle.

Which driver is that?

/Ricard
-- 
Ricard Wolf Wanderlof                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
