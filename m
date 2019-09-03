Return-Path: <SRS0=Sdsu=W6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B5BC3A5A2
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Sep 2019 07:48:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6190C2053B
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Sep 2019 07:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sRMu+VMa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6190C2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2E1DA1669;
	Tue,  3 Sep 2019 09:47:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2E1DA1669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567496906;
	bh=QPa80ocvFuP+GbESUDKhkBJcv1ERujiyNr9b+peV0gg=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sRMu+VMat6QsKXXA8+Q3DVnoGag+UY7yMrvp9YnB5UkznRwjTBGAZBnRzJIZIcEHC
	 Qn1FrHmJZlVozSM/Y5p6JzggK2bIpKtiANpWHtoXghaaGLe6B7X/qeP2Ayik2BRQDR
	 NdyXeqt4eFPEYC6One8jGajWsVG4k3LWLwIE7wmI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 85BF5F803D7;
	Tue,  3 Sep 2019 09:47:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E2C75F8045F; Tue,  3 Sep 2019 09:47:33 +0200 (CEST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 78276F80392
 for <alsa-devel@alsa-project.org>; Tue,  3 Sep 2019 09:47:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78276F80392
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1DCD03DE04
 for <alsa-devel@alsa-project.org>; Tue,  3 Sep 2019 07:47:27 +0000 (UTC)
Received: by mail-ed1-f69.google.com with SMTP id x40so10042314edm.4
 for <alsa-devel@alsa-project.org>; Tue, 03 Sep 2019 00:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nToouos/ozr0DRHz/vRlgqcFjK+SaZJGZA6PyxDTHMU=;
 b=IG9q+7/aZggdFVeAXi9duQvgn0ZChVixmyoRhFXTrGxTRYmGLlVKtCNpiKflfBtUVQ
 b/ltcZAp3ySu3aKGK3kZGd/6yy97Tzzz+0USNvxMQmu9OX2VyOHdSo/FwzcyuYx1Q9li
 BsoCz69mLa4hpD2j7Tayx7G0mus24hkIUXqE1KP1fV3TOeesiw2JxwH1k61fzzsqxQ/k
 VlhGx6cKtYmwKtOQ824eqYJk6dYTpKxce2OO/4lOAU8//hFcvE9arFdtomlu9CD70VN/
 K5joYpDkxv8ODUElrJSTDRvxwZaZQbEZTnjUz1AuDUg2/zMBnxkG6ii6K+KIUAMqfKdG
 Batg==
X-Gm-Message-State: APjAAAWXivACt+U2K3FCIstHIV4Bg+Y7RUNzw4jAjLopoZDas920F1kb
 dW5z4Q4OvwB3rsAb6euPcAMvYOQvPiKIrYphSPI4BAuOua6iLo8yt1F6oCaZnJdh53cjZdbzfLn
 nUoUlVDyDB71a8yFNANURQtM=
X-Received: by 2002:a05:6402:644:: with SMTP id
 u4mr34576096edx.176.1567496845893; 
 Tue, 03 Sep 2019 00:47:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyEsD3TOBCDHd28jJNnKpZ4Rpm8J0qxTFZIA6wSXLtiaYMUCsARF3yaPKIbzIEeFNxZiUGcog==
X-Received: by 2002:a05:6402:644:: with SMTP id
 u4mr34576090edx.176.1567496845737; 
 Tue, 03 Sep 2019 00:47:25 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl.
 [84.106.84.65])
 by smtp.gmail.com with ESMTPSA id dd17sm1395640ejb.61.2019.09.03.00.47.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2019 00:47:25 -0700 (PDT)
To: Takashi Iwai <tiwai@suse.de>
References: <20190831145842.32990-1-hdegoede@redhat.com>
 <s5hef0zjhw5.wl-tiwai@suse.de>
 <99a375b4-f6e9-ef5e-6f24-9e76db44b2e8@redhat.com>
 <s5hpnkiww75.wl-tiwai@suse.de>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <57014241-1364-222b-ac48-b44023425b84@redhat.com>
Date: Tue, 3 Sep 2019 09:47:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <s5hpnkiww75.wl-tiwai@suse.de>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 1/2] conf/ucm: Add UCM profile for
 cht-bsw-rt5672 boards
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

Hi,

On 02-09-19 17:32, Takashi Iwai wrote:
> On Mon, 02 Sep 2019 10:31:30 +0200,
> Hans de Goede wrote:
>>
>> Hi Takashi,
>>
>> On 02-09-19 09:07, Takashi Iwai wrote:
>>> On Sat, 31 Aug 2019 16:58:41 +0200,
>>> Hans de Goede wrote:
>>>>
>>>> Add an UCM profile for Intel boards with a RT5672 codec.
>>>>
>>>> Re-use the existing platform enable and disable sequences for BYT/CHT SST
>>>> support and add a codecs/rt5672 dir with codec specific enable / disable
>>>> sequences for the various inputs and outputs.
>>>>
>>>> This is partly based on earlier work done here:
>>>> https://github.com/plbossart/UCM/tree/master/cht-bsw-rt5672
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>
>>> We've recently set up a new alsa-ucm-conf repo for keeping UCM
>>> profiles outside alsa-lib repo.  The new repo has a different license
>>> (BSD3-Clause) for easily adapting to OSes with license restriction.
>>>
>>> I guess we should put the stuff there from now on, as much as
>>> possible?  The handling of UCM profile is currently pending, and we
>>> need to decide the general policy, as well as how to transfer the
>>> existing profiles to the new repo...
>>
>> I think it is good that we now have a separate repo and I'm fine
>> with re-licensing all my UCM profile work under a BSD3-Clause license.
>>
>> But I believe that until we have actually figured out how this is
>> all going to work and we are actually doing releases from the
>> new alsa-ucm-conf repo, we should keep adding new profiles to
>> alsa-lib for now, because these profiles are necessary for things
>> to work OOTB for our end users.
> 
> Well, putting to both repos isn't a good idea from the packaging POV,
> either.  If we're going to release the alsa-ucm-conf sooner or later
> together with the next alsa-lib release, we can put into the new repo
> from the beginning.

Well, we want to move some of the other UCM profiles over too, right?
(I guess eventually we want to move all of them over)

So we are going to have this duplicate profile problem anyways.

I was thinking of adding a --without-duplicate-ucm-profiles option
to alsa-lib's ./configure which when used disables installation of UCM
profiles which have a copy in the new alsa-ucm-conf.

This will give use a transition period, where distros can choose to either
use alsa-lib with --without-duplicate-ucm-profiles + the new alsa-ucm-conf,
or just use alsa-lib as they have before. Note the idea is for this to
be temporary, eventually the profiles which are "disabled" by
--without-duplicate-ucm-profiles can be dropped and the option removed.

OTOH if you plan to make sure that the next alsa-lib release is done
in sync with the first alsa-ucm-conf release and you plan to move the
UCM profiles which can be moved (licensing) before that, giving us a clean
break, then that is fine too.

Regards,

Hans

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
