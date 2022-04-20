Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBC0C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Apr 2022 13:47:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB60D1AA9;
	Wed, 20 Apr 2022 15:46:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB60D1AA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650462467;
	bh=ri883e8tqoQWuAArTF01cuFTcJVF+JreZo7pHfXoLls=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rRIgeairtvIpPKbF62JVlcF+gwNVSJo2C5tjQXqGMkShIOVvbICvnG6AcWJ/O1VPZ
	 bQpy68NZFhQMx8D+QCHoSc637ZU2y05fxn5+ZaBbPGu8JcuuBgFkDgCRKqj2nCODhu
	 NI3SKW12su7S1mh1CYUq73CDih17MvhjVBMMlJ24=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 98AA6F80116;
	Wed, 20 Apr 2022 15:46:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C3747F800C1; Wed, 20 Apr 2022 15:46:54 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 01F0EF800C1
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2022 15:46:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01F0EF800C1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="DPZDNn9s"
Received: by mail-pf1-x429.google.com with SMTP id i24so1972704pfa.7
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2022 06:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=q6jrkZFlCbwn0WTvEVs0btNJ3ts6C00LvQRtxh2AOjE=;
 b=DPZDNn9sPB8FUXiCbQR8I5Tb2hCJdcWYPSTUnivCRb+iBRy5aKJvOxdYXzwyAbyuw+
 q2xTmlz38+4CW7dNvBdxku+UmYgu/sJtNfsoVCgjPjHm/pOs80TmckFLvB/DRQv++AIQ
 tKLB1JkYGNVSE1vEVAqroOsTo/aCdpuaCtDzDKp+e4mUHQqm71wNu8+HoC4c3/BvonoK
 uQIDV0XYEmM3jalKUW7A2S8fZDA9uUQBMt8Jk1WLAaLO7zrpfm7PNDiifZ+pq1oTSuaa
 XJN2utWzmD/F5BdJGqFxaB+cONpwsWUIjBjla1dakkFxCNWpiH1MWjWK0fyYUxMLt5Ma
 T4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=q6jrkZFlCbwn0WTvEVs0btNJ3ts6C00LvQRtxh2AOjE=;
 b=JWYrxFaybdPd0V4ykBA6JCSLquozsUNLjB92MU93YCZkhgOZ24ub2vBP2Rr88bIt22
 leyFdbbktdvdQ2fWsAFXkxSjQkbllcy7X2+UOW1MB6ylrNOryQ/IY7EUwUHnLH2pT+GA
 7WCuuFDYenR5uKmmVP1utuqqmeJJv3UHHRsju2GhGhjv0/QYIeLfblX1eWRKIniTzjTR
 Qy+5YzAnnP/qf9M8NcV5xHuR7/BDYmbPjFfDjrH9kPn4NcVpN5KPrbhc2L9Fbigwd4xl
 RNwzumCG76QJIngHjrvsj+P1CeoRz7NztqTfz8RWnUlu91oQa0zkW2741J3m41R0gSKs
 /yCw==
X-Gm-Message-State: AOAM532iFgTziJPUIAZcJqN/pV7QdAVRRphLbOd6H4V8p4bOov2U7+hX
 sQYzsjEacybJ7kh6VrI0LoxrmMKKk2xKasgaCRo=
X-Google-Smtp-Source: ABdhPJyvRpVgkmJHIJdX4ski3xEdOk/1vExt5dfNhj+zxHR/wDP4IVTdMND8YtovToQ0YOxhDZTipw==
X-Received: by 2002:a63:2d4:0:b0:3aa:7a8b:25ba with SMTP id
 203-20020a6302d4000000b003aa7a8b25bamr969322pgc.251.1650462407068; 
 Wed, 20 Apr 2022 06:46:47 -0700 (PDT)
Received: from [172.16.10.243] ([106.39.150.10])
 by smtp.gmail.com with ESMTPSA id
 a9-20020aa78649000000b004fe3d6c1731sm20222786pfo.175.2022.04.20.06.45.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Apr 2022 06:46:46 -0700 (PDT)
Message-ID: <7d99fb81-d799-8785-8fe4-44772e26408a@gmail.com>
Date: Wed, 20 Apr 2022 21:45:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] ASoC: fsl: Fix error handling in pcm030_fabric_probe
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
References: <Yh90u+E3RTuGEDWU@sirena.org.uk>
 <20220420021855.8224-1-linmq006@gmail.com> <YmAD6MIuKdjgm7Yu@sirena.org.uk>
 <4e3309d9-879f-3385-3e8e-0fa1a31ddd9a@gmail.com>
 <YmANgcO9BMxp8PLC@sirena.org.uk>
From: Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <YmANgcO9BMxp8PLC@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
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


On 2022/4/20 21:41, Mark Brown wrote:
> On Wed, Apr 20, 2022 at 09:35:55PM +0800, Miaoqian Lin wrote:
>> On 2022/4/20 21:00, Mark Brown wrote:
>>>> - rebase on top of commit 559089e0a93d ("vmalloc: replace VM_NO_HUGE_VMAP with VM_ALLOW_HUGE_VMAP")
>>> Why rebase on top of that seemingly random commit?  Is there some sort
>>> of dependency here?
>> Hi, it the head of master in when I made this patch. It's because you pointed out
>> that patch v1 doesn't apply against current code. But I am not sure what's the problem.
>> So I ensure the codebase is up-to-date. If this patch have no conflict, you can ignore it.
> Current code here is my git tree (-next is often a fair approximation) -
> if people have been making changes since the merge window then often
> code written against mainline won't apply and things need to be based on
> people's current work.  You're looking for
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

I get it, thanks for your kindly reminder.

