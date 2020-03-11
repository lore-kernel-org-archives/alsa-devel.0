Return-Path: <SRS0=OXo6=44=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0860DC2BB1D
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 22:55:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 892412074B
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 22:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RbuwkT+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892412074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=flatmax.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B9BF516A5;
	Wed, 11 Mar 2020 23:54:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B9BF516A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583967347;
	bh=3zke/Jsye4sMTy1iV0pUqUHaLmGaYWgK1xXMqjc+Hh8=;
	h=To:From:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RbuwkT+JI2HqVto9kl9URB42FIUWeR7nHFN6/t07fDgvr9YLaPVJ/1wrD7f21jbRq
	 VvQhq0eXluq9h9qtLP7O7TnEgiz225+iPJMBcGTmTdpepRZcERaNb7So4yldrnGhq5
	 FFeeWziOiesx25dxKbrLYsiP48FOhCL6GKfOZ55A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 10B1EF800B5;
	Wed, 11 Mar 2020 23:54:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CDB11F801EB; Wed, 11 Mar 2020 23:54:54 +0100 (CET)
Received: from mx.flatmax.org (mx.flatmax.org [13.55.16.222])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5CD74F800B5
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2020 23:54:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5CD74F800B5
Received: from 41.68.233.220.static.exetel.com.au ([220.233.68.41]
 helo=[192.168.1.51])
 by mx.flatmax.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <flatmax@flatmax.org>) id 1jCAFO-0004XS-Cz
 for alsa-devel@alsa-project.org; Thu, 12 Mar 2020 09:54:43 +1100
To: alsa-devel@alsa-project.org
From: Matt Flax <flatmax@flatmax.org>
Subject: ASoc: soc_core.c stream direction from snd_soc_dai
Message-ID: <5598a2fc-9b49-ad5e-2265-fbc0593ead1b@flatmax.org>
Date: Thu, 12 Mar 2020 09:54:42 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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

Hi there,

A large number of audio codecs allow different formats for playback and 
capture. This becomes very useful when there are different latencies 
between playback and capture hardware data lines. For example digital 
isolation chips typically have a 1 bit delay in propagation as the bit 
clock rate gets faster for higher sample rates. By setting the capture 
and playback formats to differ by one or two bit clock cycles, the delay 
problem is solved.

There doesn't seem to be a simple way to detect stream direction in the 
codec driver's set_fmt function.

The snd_soc_runtime_set_dai_fmt function :

https://github.com/torvalds/linux/blob/master/sound/soc/soc-core.c#L1480

calls the snd_soc_dai_set_fmt function :

https://github.com/torvalds/linux/blob/master/sound/soc/soc-dai.c#L101

which calls the set_fmt function :

https://github.com/torvalds/linux/blob/master/include/sound/soc-dai.h#L189


The snd_soc_dai_ops set_fmt function is defined as :

     int (*set_fmt)(struct snd_soc_dai *dai, unsigned int fmt);


Is there a simple way to find the stream direction from a snd_soc_dai ?

If the stream direction can be detected then the playback and capture 
formats can be set independently for the codec.

It there a different way to set the playback and capture formats for the 
codec independently at runtime, depending on the sample rate ?

Matt

