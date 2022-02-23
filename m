Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1313C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Feb 2022 16:53:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4216C172E;
	Wed, 23 Feb 2022 17:52:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4216C172E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645635228;
	bh=Mhe9IBh914gX5S/t9ep6ZZaRTzga0GAkGaiQBjWQT5Y=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=robfPXejOi3a205dxp6HHB+rfi0GkYoTcFvXZOt77WO/n0OzZX3qBetKI3PWmGg3V
	 WkT7y34ssj2Tvft7TtluAxi7lfp++ag37oYyx8mv5nz3nKnQTGaL1TQsgsha1zN6w3
	 t1dxwapxO5zsswuc9lW5fAbliNMMZ9AGog4XGiQw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BBF5FF8019D;
	Wed, 23 Feb 2022 17:52:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5FD2FF80237; Wed, 23 Feb 2022 17:52:56 +0100 (CET)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 240B9F800B6
 for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2022 17:52:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 240B9F800B6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de
 header.b="ubHtlYPL"
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5D39B83CA0;
 Wed, 23 Feb 2022 17:52:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1645635172;
 bh=cRIgNh9h8o+UmyeNDtBUfbZCSnTjMdwKAWQ0BzoO9Fc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ubHtlYPL9rWe7Fls33JL6w4o0vwn5dJ3tgbEkM/FF3qrDjFRBVvidv+LZnzg2tECo
 SqK2E08urWFHXXhBYYtEtwEIxMO3vS7ZnVZ4kEOVN95HIH+r9U6AJnYYiA/iElQh6y
 anaa8S5kZOFI+dXGxz3817QyGtX91pqwIZ9AVlSWp5KW+myyyFgCwwqsA8nBcixm2r
 QKs0wp08HhTjbOeYuFxqkpIn2HTVUpPfjtq9cKk3qy5PejntWbKKNe9eVXIs+Y8Th+
 0vz07RNv1RgiL+XxC3oGU8wS53GPGTpH4I4MvCv+eaxmQnPyXv7+mq2cH9Y5WgkGxs
 KLDwp0WeWkehg==
Message-ID: <ee74ed25-cd10-1047-9700-7546c7ee7052@denx.de>
Date: Wed, 23 Feb 2022 17:52:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] ASoC: ops: Shift tested values in snd_soc_put_volsw() by
 +min
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
References: <20220215130645.164025-1-marex@denx.de>
 <s5hy221y6md.wl-tiwai@suse.de> <YhZhkz6gQYsK3Fwd@sirena.org.uk>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <YhZhkz6gQYsK3Fwd@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
Cc: alsa-devel@alsa-project.org, Alexandre TORGUE <alexandre.torgue@st.com>,
 stable@vger.kernel.org
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

On 2/23/22 17:32, Mark Brown wrote:
> On Wed, Feb 23, 2022 at 03:55:54PM +0100, Takashi Iwai wrote:
>>
>> But, more reading the code, I suspect whether the function does work
>> correctly at all...  How is the mask calculation done in that way?
>>    unsigned int mask = (1U << (fls(min + max) - 1)) - 1;
>> What's the difference of this function with snd_soc_put_volsw()?
> 
> Yeah, I'm not clear either - Marek mentioned _SX when he was doing the
> patch but I didn't get the bandwidth to figure out what it's doing
> properly yet.  At this point I'm not clear what _SX is supposed to do,
> I'm hoping it works well for the devices that use it but I don't have
> any of them.

Right, I wasn't sure about the remaining two -- volsw_sx and xr_sx -- 
that's why I only did this one I could at least test.

But CS42L51 is on STM32MP1 DKx devkit, CCing Alex , ST might be able to 
look at that one and test.

>> Furthermore, the mask calculation and usage in snd_soc_put_volsw()
>> isn't right, either, I'm afraid; if the range is [-10, 0], max=0, then
>> mask will 0, which will omit all values...
> 
> Indeed, if anyone did that.  Fortunately I don't *think* that's an
> issue.  The whole way that code handles signed bitfields by remapping
> them into unsigned user visible controls is a landmine, it's not even
> obvious that they handle signed bitfields in the first place.

[...]
