Return-Path: <SRS0=KIty=DT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A63FC433E7
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Oct 2020 13:31:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4581A204EA
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Oct 2020 13:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aASvJmwn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="H+lt1eg0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4581A204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D7991168E;
	Mon, 12 Oct 2020 15:30:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D7991168E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602509455;
	bh=OgjCiZ6LdSsowTZq/Ge15qbhR0t/LUKp9bcjvCFDwSg=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aASvJmwn6uFMnn/FjRFLR9rAJZqSXV7RoZULVZ8t/ppsPMKeIXm4VxtwyQTafKf7/
	 oG4COnN8RWSECnWEQFT2KnlVHGB+eTYcMucWPfdf6uCfVQHnAPIZCvj83m6yITp+i0
	 uikW5AgVmfDCUvIz8RI+17dHEev+1Z0p2rj2uXjM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 89034F8021D;
	Mon, 12 Oct 2020 15:29:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 883ACF800D8; Mon, 12 Oct 2020 15:29:18 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2BE4CF8021D
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2020 15:29:14 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id EF329A0040;
 Mon, 12 Oct 2020 15:29:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz EF329A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1602509354; bh=qadbwD3Df2blYyoMy3POZbX7IC6sOPtCk08x/wHsuKI=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=H+lt1eg0VHxOZ6jwoXKFVUWb1djg+S8gUYE6IQV9pIyqgoQn7GGhonzrv3asr7TkS
 iJ7Pi+r8qXKY45BnCyGi7HBl/XUhpSthFFXHPffc2f2FTzfRVi2NTOox7A7kDOg+Kk
 HnslK7BTYdwM7P/3p4Gk31J6EHzvPG1yVNuJpTZY=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 12 Oct 2020 15:29:00 +0200 (CEST)
Subject: Re: [PATCH] ALSA: compress: allow pause and resume during draining
To: Vinod Koul <vkoul@kernel.org>, Takashi Iwai <tiwai@suse.de>
References: <20201001102938.GU2968@vkoul-mobl>
 <2bf52360-bd11-b4cd-b255-8a5610b4aa5f@linux.intel.com>
 <20201006062105.GQ2968@vkoul-mobl>
 <4bbc385b-d35a-8766-7981-034455287225@linux.intel.com>
 <000d01d69d58$4e2db6f0$ea8924d0$@samsung.com> <s5hr1q7sa9f.wl-tiwai@suse.de>
 <831bbfcf-9720-9100-8633-65932b415cab@perex.cz>
 <s5ha6wusb2l.wl-tiwai@suse.de> <20201012052525.GH2968@vkoul-mobl>
 <s5hk0vwq65o.wl-tiwai@suse.de> <20201012122423.GJ2968@vkoul-mobl>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <5b26cdd5-8a15-fa26-86af-13bfbfad5341@perex.cz>
Date: Mon, 12 Oct 2020 15:29:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201012122423.GJ2968@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: 'Pierre-Louis Bossart' <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, khw0178.kim@samsung.com, kimty@samsung.com,
 s47.kang@samsung.com, lgirdwood@gmail.com, tiwai@suse.com, hmseo@samsung.com,
 Gyeongtaek Lee <gt82.lee@samsung.com>, pilsun.jang@samsung.com,
 tkjung@samsung.com
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

Dne 12. 10. 20 v 14:24 Vinod Koul napsal(a):
> On 12-10-20, 09:01, Takashi Iwai wrote:
>> On Mon, 12 Oct 2020 07:25:25 +0200,
> 
>>> So what if we add another state but keep it in kernel (hidden from
>>> userspace)...?
>>
>> That's fine, then it's just a kernel's business, and it should be
>> determined which one makes the code better.
>>
>> But, there are things to be considered, though:
>>
>> - SNDRV_PCM_STATE_* is defined as snd_pcm_state_t with __bitwise.
>>   This indicates that the type has to be defined in that way
>>   explicitly.
>>
>> - Having a value over SNDRV_PCM_STATE_LAST internally is hackish.
>>
>>> Right now tinycompress does not make use of PCM streams, kernel handles
>>> these. I am not aware of any other implementation.
>>>
>>> So if the scope if within compress then it might work...
>>
>> Yes.  But currently the API uses SND_PCM_* even for the compress
>> stuff.  Changing this value means to have influence on PCM, even if
>> PCM stuff doesn't use it yet.  (At least you'd need to increase
>> SND_PCM_STATE_LAST, for example.)
>>
>> That said, if we want to change only for compress API by assuming that
>> the impact must be negligible, the first step would be to move from
>> SND_PCM_STATE_* to the own state, SND_COMPRESS_STATE_*.  The values
>> should be compatible, but this has to be changed at first.  Then you
>> can introduce a new value there.
> 
> I think that sounds reasonable to me, we should not have used
> SNDRV_PCM_STATE_* in the first place and long term fix for this should
> be SNDRV_COMPRESS_STATE_
> 
> I will cook a patch for this

Although the impact is not high, I do think that we should enable the new
behaviour conditionally (when the user space asks for it) even if the state
values are split. I think that the whole thread is about 'how to extend the
current APIs'. The hidden way is really not so nice.

Unfortunately, there are no reserved fields in the snd_compr_params structure
for this, but I see the similarity with the 'no_wake_mode' field which
controls the driver behaviour.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
