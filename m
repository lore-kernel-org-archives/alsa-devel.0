Return-Path: <SRS0=7vEg=22=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE849C33C8C
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jan 2020 16:06:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6620E21582
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jan 2020 16:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SjRg5qf/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y/Boz9n+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6620E21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3BF13170E;
	Sun,  5 Jan 2020 17:05:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3BF13170E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578240402;
	bh=ObMU/sNZ4fWLhicAd6XO9Rn6ZQ/D6+AstxFfTrm4s0c=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SjRg5qf/EyekVjeCd34CCNhPVv/E8iGadsKcFGfRC30pbkuEyLznmqz+wf+E/HoYE
	 TitVueEoxTI95o6DVRuXVE7yD0r+CA3rq+fpCUz3Xq809buPdqUl8nGt5DvFCArJmt
	 CiSLHD/SaI9d3wNzdXZFIkZl8mwrmAEenUHJbKTo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B6265F80116;
	Sun,  5 Jan 2020 17:05:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 740D5F8014A; Sun,  5 Jan 2020 17:05:50 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 03C7CF80116
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2020 17:05:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 03C7CF80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="y/Boz9n+"
Received: from localhost (unknown [73.61.17.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 118A020801;
 Sun,  5 Jan 2020 15:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578238239;
 bh=ZkiRfHZglT0lasFVG7b5RxLqwyxF3NGLHxSOFnCrxxQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=y/Boz9n+QZFqJvZXiDOTGT1J4y5Cku/sHK2PGokgmCnWvaWBOAGfqF4sun7a5m2XR
 CUQC3OcssriFtWn5V2KNeeN7watuCxX7IAfLPd/hveaaJkkG0KguuQ51A5bgZ0PAxT
 7IKDfIBo4LE0LQrM6bjCDbqrtLTGpKzsfQ5O7ZHo=
Date: Sun, 5 Jan 2020 10:30:38 -0500
From: Sasha Levin <sashal@kernel.org>
To: Mark Brown <broonie@kernel.org>
Message-ID: <20200105153038.GO16372@sasha-vm>
References: <20191227174055.4923-1-sashal@kernel.org>
 <20191227174055.4923-6-sashal@kernel.org>
 <20191227224430.GO27497@sirena.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191227224430.GO27497@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Tzung-Bi Shih <tzungbi@google.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH AUTOSEL 5.4 006/187] ASoC: max98090: exit
 workaround earlier if PLL is locked
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

On Fri, Dec 27, 2019 at 10:44:30PM +0000, Mark Brown wrote:
>On Fri, Dec 27, 2019 at 12:37:54PM -0500, Sasha Levin wrote:
>> From: Tzung-Bi Shih <tzungbi@google.com>
>>
>> [ Upstream commit 6f49919d11690a9b5614445ba30fde18083fdd63 ]
>>
>> According to the datasheet, PLL lock time typically takes 2 msec and
>> at most takes 7 msec.
>
>Same here and for the other max98090 patch - once things are
>fixed it'll be OK.

I've dropped both. Could you ping me when this is settled and I'll grab
these and any follow up fixes?

-- 
Thanks,
Sasha
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
