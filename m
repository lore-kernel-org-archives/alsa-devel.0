Return-Path: <SRS0=7vEg=22=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7892AC32767
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jan 2020 00:05:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F98720801
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jan 2020 00:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Rn86H3Cb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F98720801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4ED68175E;
	Sun,  5 Jan 2020 01:04:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4ED68175E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578182718;
	bh=c+46kNlYiz/uJFiZz0vybCUQyqfyGivYJdfNN0BsR1E=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rn86H3CbqC+zOXuX8Cid1/6X7VEqXZ19ODz4qEbZEfNNGXwSW4CB52ta0zLynYHJc
	 6mnka8/AY9il+pBqCoWrQ1dMeWpsTSvY4G64PZUNzlaj7zHQsGV8BzFb0Fk2crPOfW
	 V5A90SceO/irRNbIwK2rVFtd3cEMcfnIorbaSGO0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A8016F8014F;
	Sun,  5 Jan 2020 01:04:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EFE76F80157; Sun,  5 Jan 2020 01:04:23 +0100 (CET)
Received: from imap2.colo.codethink.co.uk (imap2.colo.codethink.co.uk
 [78.40.148.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 51068F80100
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2020 01:04:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 51068F80100
Received: from [167.98.27.226] (helo=[10.35.5.173])
 by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
 id 1intOn-0006kh-GO; Sun, 05 Jan 2020 00:04:05 +0000
To: Dmitry Osipenko <digetx@gmail.com>, Jon Hunter <jonathanh@nvidia.com>,
 linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>
References: <20191018154833.7560-1-ben.dooks@codethink.co.uk>
 <20191018154833.7560-3-ben.dooks@codethink.co.uk>
 <d2110a1f-c1de-e2c5-a1ff-5eb4c5d3e1da@gmail.com>
 <b4e2ec44-bc89-b5ca-cfa7-a6d5c45a9c94@codethink.co.uk>
 <a11ba33e-5ffb-c5c6-04f5-0e031877c55f@gmail.com>
 <621fa27d-9259-2949-9cf5-d2eda5cb0677@gmail.com>
 <a0f027d9-e9e0-d76c-1e40-002fdc37eb5f@nvidia.com>
 <d43d518d-9336-a011-2a69-3f9331f6d0b4@codethink.co.uk>
 <aba4edd6-0ea5-5e95-c5a0-9e749587c763@nvidia.com>
 <449bdc3c-bf82-7cc4-6704-440dd100ca3a@gmail.com>
 <5d3ae629-5d30-0930-5dd1-15161e64926e@codethink.co.uk>
 <9daeeb94-2b90-18b8-2e1e-daae5acf079d@gmail.com>
 <fd73f68c-80f5-ac80-f6e4-42256d3df76d@codethink.co.uk>
 <37beb96a-a525-c72f-a7e1-e9ef5d61f3b2@gmail.com>
 <29db3df4-6f51-7c0f-1eef-90171f1d233a@codethink.co.uk>
 <9a5447e2-155c-7e6e-b8f1-95523c6f42c6@gmail.com>
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <b4a416fb-f2b1-660d-27e3-aebf602178f9@codethink.co.uk>
Date: Sun, 5 Jan 2020 00:04:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9a5447e2-155c-7e6e-b8f1-95523c6f42c6@gmail.com>
Content-Language: en-GB
Cc: linux-kernel@lists.codethink.co.uk,
 Edward Cragg <edward.cragg@codethink.co.uk>
Subject: Re: [alsa-devel] [PATCH v5 2/7] ASoC: tegra: Allow 24bit and 32bit
	samples
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

[snip]

I've just gone through testing.

Some simple data tests show 16 and 32-bits work.

The 24 bit case seems to be weird, it looks like the 24-bit expects
24 bit samples in 32 bit words. I can't see any packing options to
do 24 bit in 24 bit, so we may have to remove 24 bit sample support
(which is a shame)

My preference is to remove the 24-bit support and keep the 32 bit in.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
