Return-Path: <SRS0=Pn0z=6U=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE1EC47259
	for <alsa-devel@archiver.kernel.org>; Wed,  6 May 2020 15:41:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 121F920A8B
	for <alsa-devel@archiver.kernel.org>; Wed,  6 May 2020 15:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sPosT4tt";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="ZvdKLhjv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121F920A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 688C9176F;
	Wed,  6 May 2020 17:41:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 688C9176F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588779715;
	bh=wvuQguOC3FBPt9QvZRnmN9Vg6nbfGcNUakfmMVhwRDc=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sPosT4ttn7VG2Y/903LqDBemd7qqrghMv3RUGhSjM9ho2l3jBHVhC7eGjKQ2+29qi
	 c1/72eZ1qf4tsBX4/jeMn6Vkpd+TAIjO+NBHKWvKDnIp+Pc5IqE5T/duEEaPNF8F26
	 qZgC/4vVckn2Z6sWz2bdmI/cPlHtSViewvEyjznM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EA5DCF80234;
	Wed,  6 May 2020 17:41:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DA00BF80249; Wed,  6 May 2020 17:41:01 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1F263F800DF
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2020 17:40:49 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 6FE8DA0055;
 Wed,  6 May 2020 17:40:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 6FE8DA0055
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1588779648; bh=0HiaUFAi5yY5KAs/xElEcbcsV0MGnSI6agkYBxnMsxY=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=ZvdKLhjvXvcdRBxrVxXaOs2Bv0AR/oad57pqNKsMDCKOZI/AIMyFO3YU8xGCD6p7Y
 wTcgSp45lLV3cmNlNgV3YkvslxGREKUHVJSYK9ASsCNcpnRayvAsuGCgejVRfhLr6N
 okoQi99VVZaugy6e2wofU7a/RcVHmrC/hUGM8JhM=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed,  6 May 2020 17:40:46 +0200 (CEST)
Subject: Re: Keeping the codec running at all times
To: Ricard Wanderlof <ricardw@axis.com>,
 alsa-devel <alsa-devel@alsa-project.org>
References: <alpine.DEB.2.20.2005061709110.12526@lnxricardw1.se.axis.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <7a54134e-ce30-d7d5-bcf3-31269f1103f1@perex.cz>
Date: Wed, 6 May 2020 17:40:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.2005061709110.12526@lnxricardw1.se.axis.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Dne 06. 05. 20 v 17:15 Ricard Wanderlof napsal(a):
> 
> In certain system-on-chip systems, with separate ADCs and DACs for
> instance, the ADC could generate clocks for the DAC, where it not for the
> fact that ALSA shuts down whatever device is not being used in order to
> conserve power. Is it possible to instruct ALSA not to do this, i.e. once
> a codec has been configured to operate at a given sample rate, it will
> continue to do so, even after all streams have stopped.
> 
> I suppose one way to do this would be to change the codec set_bias_level()
> callback so that the BIAS_OFF and BIAS_STANDBY cases don't do anything but
> leave the codec running. But it doesn't sound like a clean way of doing
> this.
> 
> Of course, one complication is that at system startup, before any capture
> or playback operations have been attempted, ALSA doesn't know which sample
> rate should be configured, as there is no concept of a 'default sample
> rate'; the sample rate is always set when a stream is opened.

The driver may limit the available rates (thus it may be possible to set the 
one accepted rate via the module parameter or so which may be used for the 
codec initialization before an application uses the PCM device).

						Jaroslav

> 
> /Ricard
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
