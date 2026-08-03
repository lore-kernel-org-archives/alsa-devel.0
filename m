Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61409C5518E
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2026 09:38:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF5ED601B4;
	Mon,  3 Aug 2026 11:38:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF5ED601B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785749923;
	bh=33s6yhLucYMAE2N9t0wyfYGQKp5Yx+BMQFGHVkoLSOc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=WUniXjiczAJoIIC4r5w7PN1AzuLzuuQUwrHQ2wp/tUmAdHkz9tGqrIRxnVkiFYrS/
	 ImKgP5tNmEwaWwzTXDkcBW4MUgnrPv2mexxm7vRbdrnUeBZxoJ01wqfRsGkLTpJM7m
	 XlceNl4GOo130gebdfV7FI8h8HfTFQ3a/u8wFZH0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5E222F806A2; Mon,  3 Aug 2026 11:37:34 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EF93AF806A3;
	Mon,  3 Aug 2026 11:37:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 51ACFF805BF; Mon,  3 Aug 2026 09:34:35 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785742471;
	b=pRfqr5gWJgS2q8gHMxU3i8/wUrAaus1W28g0eqCZbLNIKecY4wy1/pH9eGnXCSy52PPy
	 hYaSvm7lKxTwKcHCrckj+kk6TSYnFrXx8IQWFo8tsKOq5CRU0uanzzP+EJShEa9JBh3Vj
	 MuSTmlO40kue/vOT8jOXFnki82WtMcy6hshcJnHXkmMiH+9AvnP8T3NCRq2c0k+b7N7vR
	 +wmiVCmDccyU0JyvBlDJFp6YKpnZOjpXsXV/0EEtDgVOZ54/bvj0/kwIjymhFtFcowClk
	 aCDHIDrjlSAAQmIcRt2iXgULMKPS4ECaBzDncarvCkUXKaFelYgl627l86xk7dQ1e1g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785742471;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=33s6yhLucYMAE2N9t0wyfYGQKp5Yx+BMQFGHVkoLSOc=;
	b=ZEFVq7AJoHn/zMNk1VrGWl+iq4fjw8R+Wu9SjVeuIyt1iAIFEt3Wz4R1223bvdrDS//X
	 39m4gsuUf0T06SXMKqQAc9yKEEoD6n27Z0c7O9gkLLTHqctAjUMG1q5TElzbgIYIb+C6Z
	 L8T2FhUSTbL2hU2Io+Qr1PzGAbf4fxeuhkiqTLOKC/wzXgg388rf573whkY1e5Iz8VNwQ
	 AAJjU6sAnBK5WricB17BkjC7B1qGfpn2xG2fCN0ZaKSMCVAjEMBa79igZqANEem3gpIsb
	 pKejhcxh4atgn+nyNBABPzV2boPnL/UrUA0eGyLBS2azrz7C7M0U9Hu5Pkh7kkvFCPA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=FgWriSpn;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F2419F800B6
	for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2026 09:34:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F2419F800B6
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=FgWriSpn
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-8484f229529so2384837b3a.2
        for <alsa-devel@alsa-project.org>;
 Mon, 03 Aug 2026 00:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785742468; x=1786347268;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wS4teYo3wuHiEoDKbPYxioZSZwZYOwoqE7Pv/fw4Cwo=;
        b=FgWriSpnOyOhxXgxyceJgt6DZNa7kJkuPX+Rmmbe26IwbCE7/GjlKcM+SyvPrN+I8W
         T/2qSZvyRuBDFwqMTnR9QhMwt7y3iVe3Cl6xXlSYZJEzmGOT+a2vjNU73QfDbw+UNZSO
         wh59TdaFGO7m4RRIlmeKu8N0B8nqraFYmR26D46F+dehqstSMKBQxv639vijWUJGE1MH
         m5qzq+hnhbpVmRDVE7wZh5/3bQ+bPYjScWw+A1XE15Z7YIAdbd2POFUIP2D1IHYuz5jw
         02ywFKvsr6AXazLmQY5GdOUtalZWedyiwowmtorvI5zNYjhDlK/7kiOIVA4vwO1qI7zc
         K+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785742468; x=1786347268;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wS4teYo3wuHiEoDKbPYxioZSZwZYOwoqE7Pv/fw4Cwo=;
        b=gBx6Ugu/cH5aXu9bDgE+XNRYFTP9t/JICVwQDCdjMqR79iaMPXPoCPdum05Lv8AV/a
         OPEG58bMCHTqjSk/3Dt0TSS6VSM1DAmU4pkhjQGhskdbEmivRKa7CBYyvMMk6vOfAalK
         S1GQ8pJYkABDSKPyqMCh3slTay0addvPMfTovofVi3sFapbMmFPyw6THHzxP9q45iKif
         QgUXST576XKLAcUcf8lXAhqn0PJRnPGwzf3sb3iAANgC0NkmhwDUnaNPc/sQT4yfFnEB
         rfWigCIm9JHVS8YmdevIdJ+oV1s6DAn/QRucEaBuFKgWxyx90QnEhHPexI4Xn9K/ro4C
         xb7w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrF/zlGmNK1//vNWtWJUaugXCTTrvLt/ywm11+UWuE558icsfDK0mRPxzkLxv/KAg1Q/etjqlcv8Or5@alsa-project.org
X-Gm-Message-State: AOJu0YwLrYF3z2TV55LXLUCWdrwmNz75Qn4eBR6hn2dhS+8D42aYAqIm
	EYfaUy9wqYtWPBxEEefc+bbOxRfqxV/Qx7RIzZHkmGZiWoADEkkWxfsX
X-Gm-Gg: AR+sD11VyS1to+MczLA/oL33pn1/rFSh0V2DYHgGBJ6ydokVbx9/VQE15ULbhRMySh5
	eq2GKhOgVexW3TfxAhsYT30d2in8HI/xpSN5ozx/UE1jKu15tm/arO0mNMZbHeG06bCXdh7+9kF
	zx3aVawO6aZ/lXovWG/G/hvqe4qe7b8k1lhCSWKAoG0xj2H9lqpoJjj/FJw7Fynqjr5GPoUvEcQ
	TFHFyPeunapYieHfwxwTSVd0FYZTKKZgAxTY1OeemJI/NMxc/BN1rpbanU0KbvOgHEgpkyadb7L
	aD8/KWS2boWACK2W2uyt8ioi8wlO7zHhlFhQgO6w7BW9wC8nJRzNESlxQLRMZ4A8v723efjPV4g
	Y1Sq7ppaKrtVjrW9ODdpV/aeIoh8UXEOaqnMw7x7AC0ZbWc72o+QINKTTJ2CNo7eZwwdergRT2H
	OnYLK5SOPMZ13ypbkdetZJwycWXt/76NbCqeqf9OtqE99sC2Q8TzQiySdfG2iidDCKD6k1cI1Kb
	5k4VUsk74n0wqJCskqUDhmq33vU
X-Received: by 2002:a05:6a00:328c:b0:845:e8b5:8c49 with SMTP id
 d2e1a72fcca58-84ee479afbamr7756583b3a.10.1785742467630;
        Mon, 03 Aug 2026 00:34:27 -0700 (PDT)
Received: from [172.20.10.2] (114-137-58-248.emome-ip.hinet.net.
 [114.137.58.248])
        by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84edbd31639sm3320470b3a.9.2026.08.03.00.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 00:34:27 -0700 (PDT)
Message-ID: <8af09a82-3d0f-bdf7-5a78-32e2de53c108@gmail.com>
Date: Mon, 3 Aug 2026 15:34:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v6 2/2] ASoC: codecs: nau8360: Add support for NAU83G60
 amplifier
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Neo Chang <YLCHANG2@nuvoton.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org, krzk+dt@kernel.org,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, kchsu0@nuvoton.com, sjlin0@nuvoton.com
References: <20260708093506.895481-1-YLCHANG2@nuvoton.com>
 <20260708093506.895481-3-YLCHANG2@nuvoton.com>
 <a5139285-2017-4c94-92f2-f87fbef6fa6a@sirena.org.uk>
From: YLCHANG2 <neo.chang70@gmail.com>
In-Reply-To: <a5139285-2017-4c94-92f2-f87fbef6fa6a@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: neo.chang70@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: PEZVLWVFVFAUGHQ36GCISCEJZ6EWS4MK
X-Message-ID-Hash: PEZVLWVFVFAUGHQ36GCISCEJZ6EWS4MK
X-Mailman-Approved-At: Mon, 03 Aug 2026 09:37:28 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PEZVLWVFVFAUGHQ36GCISCEJZ6EWS4MK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On 7/9/26 03:11, Mark Brown wrote:
> On Wed, Jul 08, 2026 at 05:35:06PM +0800, Neo Chang wrote:
>> Add support for the Nuvoton NAU83G60 audio codec. The NAU83G60 is a
>> stereo 30W+30W smart amplifier with an integrated low-latency
>> Advanced Audio DSP.
>> +static int nau8360_dsp_chan_kcs_setup(struct snd_soc_component *cp,
>> +       const char *fw_name, int dsp_addr)
>> +       ret = request_firmware_nowait(THIS_MODULE, true,
>> +               fw_name, dev, GFP_KERNEL, ctx, nau8360_dsp_fw_cb);
> This gets run every resume but there's no cleanup so if for some reason
> we get suspend/resumes running back to back and the firmware load
> doesn't complete, or the driver gets removed while the firmware loads
> are pending during normal probe, nothing cancels the firmware loads and
> they might end up completing.  Both suspend and remove should clean up
> anything that's pending.
Got it. We will add a completion mechanism in v7 to ensure the firmware 
load finishes.
>
> There's a bunch of issues reported by Sashiko:
>
>     https://sashiko.dev/#/patchset/20260708093506.895481-1-YLCHANG2%40nuvoton.com
>
> some of which looked valid.
We will review the report from Sashiko and fix the issues in v7 as well.
