Return-Path: <SRS0=OCx8=ZZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F99C432C0
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Dec 2019 12:52:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADCC72070A
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Dec 2019 12:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qEt69NCH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="dfQm0IzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADCC72070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 57B38846;
	Tue,  3 Dec 2019 13:51:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 57B38846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575377569;
	bh=cXoBW+QWd5joALsUiJJC4t1ejFFt2yvwJ/CdezNSOqE=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qEt69NCHPKCnRnKjWb6V3wIRx3RZDpu3C4gAmcdAZ3Q92X97/veoUUEbiHHKhVzSU
	 0njg7SZlBObq/1T1QGWWD4lN7wN8pOT/mabcta9yjyL/7qK0Oakksw8HPPkRriWRlq
	 Lwek9wCAhUHSubOv4kIlFvf7fcidb25Q0dhuu2sc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9EC88F8015A;
	Tue,  3 Dec 2019 13:51:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 802ECF80227; Tue,  3 Dec 2019 13:51:56 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E0F6CF800B4
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2019 13:51:53 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id D183DA003F;
 Tue,  3 Dec 2019 11:23:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz D183DA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1575368590; bh=5yqSg5EBHxrtkRyGUm7dmt4fb/W4TQdkXFCUEubu3Zs=;
 h=Subject:To:References:From:Cc:Date:In-Reply-To:From;
 b=dfQm0IzOanmGxePf0UeuDaesw45wpAnUvtpOHriVZTa/mWtlSdbZpf5Iyh2J/v6dY
 xt1gf8RvlW80R5xPrZzDKxAvzovjvC/kZtrrtUUx52pwCmM4T1FTV2Mt2R/aE7OeTQ
 eg1BRvkUxOnrXrZzisdDO1SAZI/kxzIwXxs2VnZM=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Tue,  3 Dec 2019 11:23:08 +0100 (CET)
To: Vinod Koul <vkoul@kernel.org>
References: <20191119112625.GD82508@vkoul-mobl>
 <20191119124302.GE82508@vkoul-mobl>
 <85e86218-6766-82a9-059c-c4a169178c26@perex.cz>
 <20191203101203.GZ82508@vkoul-mobl>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <89f264dd-e020-4d75-b6ac-e98893923e0a@perex.cz>
Date: Tue, 3 Dec 2019 11:23:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191203101203.GZ82508@vkoul-mobl>
Content-Language: en-US
Cc: ALSA development <alsa-devel@alsa-project.org>
Subject: Re: [alsa-devel] [ANNOUNCE] fcplay: compressed audio test utility
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

Dne 03. 12. 19 v 11:12 Vinod Koul napsal(a):
> On 26-11-19, 11:27, Jaroslav Kysela wrote:
>> Dne 19. 11. 19 v 13:43 Vinod Koul napsal(a):
>>> On 19-11-19, 16:56, Vinod Koul wrote:
>>>> Hello,
>>>>
>>>> I have forked the cplay test app into fcplay which is a different repo
>>>> [1] licensed as LGPLv2.1. The reason for fork was me getting sick of
>>>> seeing the tool miss sync word for mp3 and no support for other formats
>>>> which I wanted to test. But I was lazy to start exploring all media
>>>> formats and write a parser for them so I have used libavcodec to the job
>>>> for me which is GPL.
>>>>
>>>> The fcplay links to libavcodec to get compressed audio parameters and
>>>> then uses tinycompress to send data to sound card.
>>>>
>>>> It supports mp3 (no more complaints about sync words) and Flac. I will
>>>> add more formats, wma etc are in the list along with gapless audio
>>>> playback and support for new changes coming to gapless audio playback
>>>> as discussed in audio meeting at Lyon.
>>>>
>>>> As usual patches are welcome.
>>>>
>>>> Jaroslav, can we add to alsa-project github as well?
>>>
>>> Here is the missing link!
>>>
>>> [1]: git@github.com:vinodkoul/fcplay.git
>>> https://github.com/vinodkoul/fcplay/
>>
>> I would probably add this to the tinycompress package, too. The mixed
>> licence is not an issue, I think.
> 
> That depends on who you talk to :-) Some folks seem to be averse to
> anything *GPL*! so adding this to tinycompress can have issues for them.

I mean that you can add a new tool to tinycompress with the LGPL-only licence. 
It depends on the packager/user if he/she accepts it. So, dual BSD/LGPL 
licence by default and LGPL-only to fcplay. You may place this tool to 
src/utils-lgpl directory or so.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
