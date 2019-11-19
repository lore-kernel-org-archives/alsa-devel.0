Return-Path: <SRS0=I/J9=ZL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18FBC432C0
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Nov 2019 20:48:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 677AC206B6
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Nov 2019 20:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vnXzdYWj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="HaDkv1Tg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677AC206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 83D40168A;
	Tue, 19 Nov 2019 21:47:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 83D40168A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574196522;
	bh=W99ENWYn86mlu/mqjNnQYcSIy8gYLwzOgEfhqVzM6go=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vnXzdYWjRUk1rTcpFRpXALyGmPdeYbeoXfkLZ8LFNwX7ssYAQuKlsVl3nSvVY+6wv
	 7uNyz1sfeurfq+6hNd70Hp+bNeE+TL2tyGrmkSPEXuvtMymUzkrA7LAGhgVg/p58Dy
	 a9a6tkANHvS0fouQdyrJqfa2LCSIxJ5n/i7w9vuA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F31B3F80135;
	Tue, 19 Nov 2019 21:47:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 78AAFF80138; Tue, 19 Nov 2019 21:47:50 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 175F6F80135
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2019 21:47:47 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 24FEBA003F;
 Tue, 19 Nov 2019 21:47:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 24FEBA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1574196467; bh=0Wf7LqNRZ0YfzZ+0d9fCYu/VmmjLGqlf3HsEfbYaNo4=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=HaDkv1Tg6xGsjdo7NzhmnRSWqhmfJxMIT4E68s638qav09SdMWs8AIIoZEDfpDOjB
 MY54NvSIVPM1CZAOxC6Qqih4sdAa07Wa8kka5Z70kLyWC0PMCf6/W5oueCCVeEQHPU
 9+J78Qn+aDNqWh+PW39bXrZZ/UhNShZxEeBBsRUg=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Tue, 19 Nov 2019 21:47:43 +0100 (CET)
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
References: <20191119174933.25526-1-perex@perex.cz>
 <20191119174933.25526-2-perex@perex.cz>
 <72dfc285-70e8-706d-3018-535bda1e8630@linux.intel.com>
 <f2de9597-c9c2-7696-622b-a2bbc2c32bb7@perex.cz>
 <s5h36ejy550.wl-tiwai@suse.de> <20191119204138.GI3634@sirena.org.uk>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <95b3dda0-527c-214e-f108-3bdff8010828@perex.cz>
Date: Tue, 19 Nov 2019 21:47:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119204138.GI3634@sirena.org.uk>
Content-Language: en-US
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: Intel - use control components
 to describe card config
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

Dne 19. 11. 19 v 21:41 Mark Brown napsal(a):
> On Tue, Nov 19, 2019 at 09:37:15PM +0100, Takashi Iwai wrote:
>> Jaroslav Kysela wrote:
> 
>>> It's not about the protocol. It's about to move this type of
>>> information to another place. I can remove the ALSA version sentence
>>> from the help, because it's just a hint. I would like to create ucm2
>>> configurations based on this rather than the misused long card names.
> 
>> But why these are exclusive?  The current longname workaround makes
>> the device appearing a bit messy, but does it conflict with the
>> additional component string?
> 
> Yeah, it's not clear to me why it's a config option to enable this.  I
> can see a config option to turn off the old display name if it's
> particularly irritating to people but I can't see any reason not to
> just provide the new stuff.

Yes, it is really better way to do this. I'll rewrite my patch. Thanks for the 
idea.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
