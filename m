Return-Path: <SRS0=FTRQ=5N=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6069DC43331
	for <alsa-devel@archiver.kernel.org>; Sat, 28 Mar 2020 22:21:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB8AA2073E
	for <alsa-devel@archiver.kernel.org>; Sat, 28 Mar 2020 22:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tLt2Ovjo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBceJdFZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8AA2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2CB9B165D;
	Sat, 28 Mar 2020 23:20:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2CB9B165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585434105;
	bh=2SKKviPkzmGeaeTQfovFxRMhZPQ4ls8E5cp8CX61wQs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tLt2OvjoUXP7RhkRleGiMP8qV1U6RENncH8y8RLozX+YyXy7235iBkjinzokDkYw6
	 eZ+GGT8uNbmUdKp17dX21aE4B8o9H1pB04+g27WOlvzYJK4nTYmywTPKUI2538T9jL
	 oFauhsads5ta1dLhLdKvz62ErVuNYo20tgoOLHPA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5FE4BF80227;
	Sat, 28 Mar 2020 23:20:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 15A0FF80234; Sat, 28 Mar 2020 23:20:53 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 93323F800EA
 for <alsa-devel@alsa-project.org>; Sat, 28 Mar 2020 23:20:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 93323F800EA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="aBceJdFZ"
Received: by mail-wm1-x341.google.com with SMTP id f74so5941018wmf.0
 for <alsa-devel@alsa-project.org>; Sat, 28 Mar 2020 15:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=EQGtdnwhU+91nF8OwkH68R+cZ5fm1giGELFQL8zJoyw=;
 b=aBceJdFZVc8abLh77cS1yMYx6TcclXImXHyv58DiCGMJYf0U7inIwNRdwGdjdZYtzX
 wMzkPitBDGUnCXIx/2cM2yFJA8MnZVg4W6B5rtC5msYiudkg+gRtG/T7FvmjHDDnIW1/
 pDhgJ/ho+t+ceUu6D2n5yY8fNpRH27MtcViobx40M/cmpfzyllj6gBC54ysK0u4WAtKn
 igDbnI8AvrmOFkC7OhIGwKzBc6WXpA/DzTAVlqISQaXrjOv9+0YJ7xlj7cStPejoWpVS
 qtFTAL0rGeF120duujcQIwa8dL3vtq7ud5kRQpJQKn/YWZePv+CR0pY3niqoUFo4yj61
 wdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=EQGtdnwhU+91nF8OwkH68R+cZ5fm1giGELFQL8zJoyw=;
 b=YqMot/zl78gLVYGIaUzdBERXPVq4p1fIHfsOciOfwCLsq3xCvSC3L5h4HfvVw/ZWyc
 g5GLrNfVuzb+l5xNraGsRR0M7zjMDXipDzZkdaP+y8sr7zJhBGVLVSndvLi/fYebye8o
 OqMzuH7Kiu8hr2Vfce5QJ2dxLUd33qqM0rHlwF91EA92FYUVrtN+T4zMVyXYF+bQgiUX
 oaYiKq3y5CbaPxXSw4qfgv8A2FYJrhCfZhNLwZgQDmdTTUt0r5Ekt8Lzhx5UZzkvM5Qj
 bWIK20eZ5eTCnwBothhYNJxxOirH9LZdHNXXaiJ6cTrTCD1q9IdSYPxsPgvGbMBVkbTm
 Cg4g==
X-Gm-Message-State: ANhLgQ0QYq5qVe54f1QbAJ2si7lq7bwHlnStidUaWxfNNz4gh0REsLPm
 /xPH7/DENKDbQYMlodfuOy4=
X-Google-Smtp-Source: ADFU+vsu7ha2h7kHbg1JtnXQpYxNufk0n66sCJEpGYMNYtPbjsuYgjYrjy0f3n9V1MW/w+NdUpgK2w==
X-Received: by 2002:a7b:ce0b:: with SMTP id m11mr1178611wmc.52.1585434047332; 
 Sat, 28 Mar 2020 15:20:47 -0700 (PDT)
Received: from localhost (108.78.124.78.rev.sfr.net. [78.124.78.108])
 by smtp.gmail.com with ESMTPSA id u5sm14745306wrq.85.2020.03.28.15.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2020 15:20:46 -0700 (PDT)
Date: Sat, 28 Mar 2020 22:20:21 +0000
From: sylvain.bertrand@gmail.com
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: sw_params for a direct-ed(dmix) hw pcm
Message-ID: <20200328222021.GA4610@freedom>
References: <20200325174419.GA1224@freedom>
 <alpine.DEB.2.21.2003261350380.2957@eliteleevi.tm.intel.com>
 <9d986c48-184a-1d6e-4c5b-172a7ecd98a8@perex.cz>
 <20200326200415.GA1321@freedom> <s5hlfnmfcdt.wl-tiwai@suse.de>
 <0b0f5117-3b4b-0c25-cd4b-0ecc72479635@perex.cz>
 <20200328182624.GA775@freedom>
 <1baab0fd-d802-3707-645f-d5dc4bf6c32c@linux.intel.com>
 <20200328203744.GA2398@freedom>
 <59266c58-96d8-93e9-bc8f-86e9fccf8d60@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <59266c58-96d8-93e9-bc8f-86e9fccf8d60@linux.intel.com>
User-Agent: Mutt/ (2018-04-13)
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

On Sat, Mar 28, 2020 at 04:34:01PM -0500, Pierre-Louis Bossart wrote:
> Using MONOTONIC_RAW is very nice on paper, until you realize you can't
> program a timer using the information. You can only read the timestamp and
> not really do much if you want to sleep/wait.
> 
> In practice, if you really really need super-precise information you'll get
> use rdtsc(), and apply you own formulas. And otherwise stick with MONOTONIC,
> it's rather unlikely you will ever notice the NTP changes. PulseAudio, CRAS
> and a number of Android HALs use MONOTONIC and nobody ever complained.

The pb is not about using monotonic_raw, the thing is: it is documented valid
to use it which I did as expected from a naive reading of the api documentation
and found those issues. I can reasonably believe it will be the case for any
new alsa programmer.

For my code, in the end, I think I'll use the best "audio timestamp" I can get
from the status ioctl for linear interpolation with ffmpeg timestamps.

But this is off topic here.

The topic is discussing how to fix this bug, since I had to dig a bit in alsa.
It appears to me the recursive fix might be a good way, since it is done for
other api functions, but I am not Jaroslav Kysela neither Takashi Iwai then far
from grasping all the details of alsa.

-- 
Sylvain
