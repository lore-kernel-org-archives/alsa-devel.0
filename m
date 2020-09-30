Return-Path: <SRS0=iKRb=DH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8246BC4727E
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2020 09:49:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 460F22075F
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2020 09:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Q3olelZ4";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="pufY9ejp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 460F22075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B11A117D7;
	Wed, 30 Sep 2020 11:49:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B11A117D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601459390;
	bh=+ZOMBDKa2Lrmpv+p3yQXSTVqMFvjmKFvtQWA+ApNUBY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q3olelZ4+yLV/tqat3KRRTbdJxnDoRoUy4bHk4rEJbYHNpKcWGkUQGyBWK/52OwWf
	 Zz5olGSthj0fqV+ZKVrfD4KKvlVjCdtk2ux8uqMc/49/8K5IsrN4pf3D49ymd1fC1F
	 /mwq+kU0CkQdXhECE8z4Srb0nKg4ZP+0B2oOoij8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 480C6F801D8;
	Wed, 30 Sep 2020 11:49:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EB7C6F801ED; Wed, 30 Sep 2020 11:48:58 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DF04DF800AB
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2020 11:48:48 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id EB28EA003F;
 Wed, 30 Sep 2020 11:48:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz EB28EA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1601459327; bh=aM+eqa0mwJDAGqbZfItbJFbGdIt0/yOZwWHb7nVbx5M=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=pufY9ejpAXmOd4X5Vegq7AzWxaTS01DwBbJTscsPbKy4DzwGnRCgjnOh0pShHZtEB
 jUkFQLwFsp46lVdr+PmRsp2nJ7mVjjcYzKleY0e2GuIPReVwrLamSsi6ZRqnd5yWM1
 kAzeKoCTqalezdKZcP59a4oCk92v3U8uMJYDTORA=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed, 30 Sep 2020 11:48:43 +0200 (CEST)
Subject: Re: [PATCH] ALSA: hda - Don't register a cb func if it is registered
 already
To: Takashi Iwai <tiwai@suse.de>
References: <20200930055146.5665-1-hui.wang@canonical.com>
 <bd05e1be-96e8-14bf-011c-b43d165abf17@perex.cz>
 <s5h8scriprf.wl-tiwai@suse.de>
 <8da67a4f-d9a4-14a0-a4b0-d93f7cb649ce@perex.cz>
 <s5h5z7vioxz.wl-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <132d15aa-4e72-9967-7d52-81c0096b18e7@perex.cz>
Date: Wed, 30 Sep 2020 11:48:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <s5h5z7vioxz.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org
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

Dne 30. 09. 20 v 11:39 Takashi Iwai napsal(a):
> On Wed, 30 Sep 2020 11:28:59 +0200,
> Jaroslav Kysela wrote:
>>
>> Dne 30. 09. 20 v 11:21 Takashi Iwai napsal(a):
>>> On Wed, 30 Sep 2020 09:19:50 +0200,
>>> Jaroslav Kysela wrote:
>>>>
>>>> Dne 30. 09. 20 v 7:51 Hui Wang napsal(a):
>>>>> If the caller of enable_callback_mst() passes a cb func, the callee
>>>>> function will malloc memory and link this cb func to the list
>>>>> unconditionally. This will introduce problem if caller is in the
>>>>> hda_codec_ops.init() since the init() will be repeatedly called in the
>>>>> codec rt_resume().
>>>>>
>>>>> So far, the patch_hdmi.c and patch_ca0132.c call enable_callback_mst()
>>>>> in the hda_codec_ops.init().
>>>>
>>>> Won't be better to handle this double invocation at the callback call time? I
>>>> believe that some refcounting and pointing to one allocated callback structure
>>>> for all instances is better.
>>>
>>> IMO, Hui's fix is correct in this case; otherwise it'll result in
>>> endless number of allocations at each time the runtime resume is
>>> performed.  So I'm going to take it as is.
>>
>> I meant to allocate the structure only once with refcounting and multiple
>> invocation protection. In the proposed change, you lose the
>> bindings.
> 
> AFAIUC, it won't lose any functionality.
> snd_hda_jack_detect_enable_callback() would chain the callback
> function if a jack object has been already created, and this
> additional check will just prevent the doubly registration of the very
> same callback when called multiple times.

Ok, I see, the lookup is codec / nid / dev_id so in this case the multiple
callback assignments are really not desired. Thanks for the explanation.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
