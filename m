Return-Path: <SRS0=6+tk=JN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F287C433ED
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Apr 2021 18:31:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53362610FC
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Apr 2021 18:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53362610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B11AB16D9;
	Fri, 16 Apr 2021 20:31:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B11AB16D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618597916;
	bh=2/Yo2Q6LNCvueXME0kVoAWDZ4cgMK43uGRA4u7ewj3g=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G2bMe7M8Bt+ndfct8y1cGvLdxN94FoVC96tNnm4Az4TqGr++QEMqL/1eo1T4OL7am
	 /tU5RBH2Yns0rTsWcO8an456BGIG0UOJnwI7JTNuhjTnZ2PIKWuB7IwWYrtriKwjXd
	 8/Esb2J63zy9gkAD+ysih215mXAOSYLpz+sO5elQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E0F92F80254;
	Fri, 16 Apr 2021 20:31:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E6D09F8025B; Fri, 16 Apr 2021 20:31:02 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 33FEAF80128
 for <alsa-devel@alsa-project.org>; Fri, 16 Apr 2021 20:30:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33FEAF80128
IronPort-SDR: JGpgmx1KXJoKkBI8L+k35f6zc0ZiiCaLZ377tkWk1Sb3hk8LW8NR0u0Z+MTN641QrjzEzrciTB
 ISgJjXLob3iA==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="280404300"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; d="scan'208";a="280404300"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2021 11:30:55 -0700
IronPort-SDR: XMKpGc6kLnFxEI4nuJAWV8vFw2+KwwKwwS0m7g78MgL17RB7ZDM2klcuGLzJDTPEM13Fdwbc3Z
 mhiQtSNvU6/A==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; d="scan'208";a="616028797"
Received: from jaolanlo-mobl.amr.corp.intel.com (HELO [10.212.2.231])
 ([10.212.2.231])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2021 11:30:54 -0700
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for Lenovo Ideapad S740
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
References: <20210416081211.20059-1-tiwai@suse.de>
 <be178038-8e42-34db-3804-f27240b2d488@perex.cz>
 <a5fee517-c12e-1cb0-755f-453d6bb47795@linux.intel.com>
 <s5h5z0mgpsu.wl-tiwai@suse.de>
 <b04b5f9b-1b19-e216-793a-dde9c3d66371@perex.cz>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <2198c50a-848a-546e-7dd8-42e155e4c0a0@linux.intel.com>
Date: Fri, 16 Apr 2021 13:30:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <b04b5f9b-1b19-e216-793a-dde9c3d66371@perex.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Kailang Yang <kailang@realtek.com>,
 Ryan Prescott <ryan@cousinscomputers.net>
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


>>>> I believe that this sequence contains I2C writes to amplifier chips. It would
>>>> be really helpful, if Realtek can provide more information for the I2C master
>>>> interface for their codecs (describe basic I2C I/O).
>>>
>>> The biggest problem is to figure what address/value pairs to write
>>> with I2C into the amplifiers, and here the catch is that those I2C/I2S
>>> amplifiers may or may not be sourced from Realtek, and it'd be
>>> difficult for Realtek to provide documentation on their competition,
>>> wouldn't it?
>>
>> Sure, that's another problem.  But currently it's not clear even how
>> to communicate via I2C/whatever to the underlying chip, as it's done
>> via the vendor-specific COEF verb.  At least this could be opened, I
>> hope.
> 
> The nice thing if we know the I2C master communication is that we can create
> I2C bus in the HDA driver and do run i2cdetect to detect the connected chips.
> Yes, it's partial information, but it's far more better than this unreadable
> coef implementation.

Ah yes, now I see the idea. Very interesting indeed. It would help quite 
a bit if we can detect the devices and then go back to the OEMs to ask 
"can you give us the commands for device #42". In the absence of 
information, it would help filter the sequences extracted with scripts.
