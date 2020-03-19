Return-Path: <SRS0=4Ztp=5E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4252AC4332D
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Mar 2020 15:33:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C33CD2075E
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Mar 2020 15:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YROHsXBG"
Authentication-Results: mail.kernel.org; dmarc=permerror header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 04A861764;
	Thu, 19 Mar 2020 16:33:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 04A861764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584632035;
	bh=JaT2Im0/hCAk0IM6JHQU9/Q4//RWIs38e1/pK2lSQEk=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YROHsXBGW5RGpnHQHDO6LFYl8jh9khm+7rzQ3oCDyVJfD0b5+KwodVU0BoLETO7oK
	 bGpttUIlAqge/unhpPrD2x+FV+u78BA+UMceP7xrJP9Xm2eUz+N5oE4APuRhtBItPz
	 Rj8l/PddtAaCX76OrwP9GPAIZa2XymTkYCJkyPjE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1C621F80217;
	Thu, 19 Mar 2020 16:33:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B3C4FF8022B; Thu, 19 Mar 2020 16:33:01 +0100 (CET)
Received: from imap2.colo.codethink.co.uk (imap2.colo.codethink.co.uk
 [78.40.148.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AB4A8F8012F
 for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2020 16:32:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB4A8F8012F
Received: from [78.40.148.177] (helo=localhost)
 by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
 id 1jExAA-0000Vn-Tx; Thu, 19 Mar 2020 15:32:51 +0000
MIME-Version: 1.0
Date: Thu, 19 Mar 2020 15:32:50 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [Linux-kernel] [PATCH v5 2/7] ASoC: tegra: Allow
 24bit and 32bit samples
In-Reply-To: <20200130131039.GC6682@sirena.org.uk>
References: <0e0cd260e39ad293edb881da1c565510@codethink.co.uk>
 <507dcd5a-672b-61ac-aa7f-af5ff01accff@codethink.co.uk>
 <a2744ea0-cf6d-d083-75e6-853746195001@gmail.com>
 <28cafc56-095b-68c6-638d-270608a2983f@codethink.co.uk>
 <3d8544be-af20-f382-85fd-32183365267b@nvidia.com>
 <1b3c2af4-510e-306c-749a-efffc994b20a@gmail.com>
 <20200128121315.GD4689@sirena.org.uk>
 <4b90efd2-5d0c-84df-961d-80cee288e0d4@nvidia.com>
 <586ea2b9-c204-2bd1-f8e2-875e0974e42d@nvidia.com>
 <fe002ec7-ae6e-f770-b82a-49237e0b29c6@codethink.co.uk>
 <20200130131039.GC6682@sirena.org.uk>
User-Agent: Roundcube Webmail/1.4.3
Message-ID: <1df9cc13ea636502ac09191523ff0669@codethink.co.uk>
X-Sender: ben.dooks@codethink.co.uk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@lists.codethink.co.uk, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Edward Cragg <edward.cragg@codethink.co.uk>, linux-tegra@vger.kernel.org,
 Dmitry Osipenko <digetx@gmail.com>, Jon Hunter <jonathanh@nvidia.com>
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



On 2020-01-30 13:10, Mark Brown wrote:
> On Thu, Jan 30, 2020 at 08:17:37AM +0000, Ben Dooks wrote:
>> On 29/01/2020 14:33, Jon Hunter wrote:
> 
>> > controller. Applying these patches it is not distorted but now I am
>> > observing the clocking issue Ben reported and so the tone is not quite
>> > right.
> 
>> I thought they had been applied? I probably dragged them back in when
>> putting in the support for the test channel on the colibri.
> 
> There were review comments from Jon on patch 6 that you never responded
> to.

Hmm, I may have accidentally deleted those.

I will look to see if I can re-form the series and re-send in the next
couple of weeks. I've got no access currently to the machine and having
to deal with working from home for the next month or so.

-- 
Ben
