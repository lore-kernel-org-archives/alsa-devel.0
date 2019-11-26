Return-Path: <SRS0=RV9o=ZS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD4DC432C0
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:28:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC033207DD
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tqJKnOQA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="1SV1DqF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC033207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D87F21720;
	Tue, 26 Nov 2019 11:27:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D87F21720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574764121;
	bh=9FPMa5MRWYzETWId8CQ95t3Rj5OgaIHUIksVwpFZVjQ=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tqJKnOQAYSYqGTO72PD2R2Bg6kpq438O0HWf5h+iKYT79Ucgs6bOvZVXECTSAokH5
	 jkEsMJDlERzAR02ECPP8iGvbp5tbQaIWYByAUQmQUtwqOv26bEfJz1bWp5TP7H2I9V
	 tx65kWjJlJ29DftQLyHphQxZUi3DQQkYKalQCs98=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 45C2EF80149;
	Tue, 26 Nov 2019 11:27:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 48244F80159; Tue, 26 Nov 2019 11:27:48 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D317FF80109
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2019 11:27:45 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id D32B8A0040;
 Tue, 26 Nov 2019 11:27:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz D32B8A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1574764064; bh=3fktHHpejbV1oxBgZ+80svD7XSpLZ5cPd4C/EZFmuik=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
 b=1SV1DqF+y/Y3fJnESx5pCUBbV3k2oo17lmgD2+esLo0w5O2LD/zswIbKlTzrMjChN
 brMssEkmIMTamrKj7jk99l/5OA7mmyxTtfI5wUwigjDSE0xCDzFUBxh5nC1nwjGAQQ
 HCXVPMa3+NPpbi7tIT7PxGkSFpjmmxMk0F2Xmkj4=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Tue, 26 Nov 2019 11:27:42 +0100 (CET)
To: Vinod Koul <vkoul@kernel.org>
References: <20191119112625.GD82508@vkoul-mobl>
 <20191119124302.GE82508@vkoul-mobl>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <85e86218-6766-82a9-059c-c4a169178c26@perex.cz>
Date: Tue, 26 Nov 2019 11:27:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119124302.GE82508@vkoul-mobl>
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

Dne 19. 11. 19 v 13:43 Vinod Koul napsal(a):
> On 19-11-19, 16:56, Vinod Koul wrote:
>> Hello,
>>
>> I have forked the cplay test app into fcplay which is a different repo
>> [1] licensed as LGPLv2.1. The reason for fork was me getting sick of
>> seeing the tool miss sync word for mp3 and no support for other formats
>> which I wanted to test. But I was lazy to start exploring all media
>> formats and write a parser for them so I have used libavcodec to the job
>> for me which is GPL.
>>
>> The fcplay links to libavcodec to get compressed audio parameters and
>> then uses tinycompress to send data to sound card.
>>
>> It supports mp3 (no more complaints about sync words) and Flac. I will
>> add more formats, wma etc are in the list along with gapless audio
>> playback and support for new changes coming to gapless audio playback
>> as discussed in audio meeting at Lyon.
>>
>> As usual patches are welcome.
>>
>> Jaroslav, can we add to alsa-project github as well?
> 
> Here is the missing link!
> 
> [1]: git@github.com:vinodkoul/fcplay.git
> https://github.com/vinodkoul/fcplay/

I would probably add this to the tinycompress package, too. The mixed licence 
is not an issue, I think.

					Thanks,
						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
