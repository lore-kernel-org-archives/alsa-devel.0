Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B5BC00140
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Aug 2022 19:07:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 43AEB161F;
	Wed, 10 Aug 2022 21:06:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 43AEB161F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660158448;
	bh=3hktzyefNFYmrDFOKxdlsBI+G4sCDacx7mqd4TMm5Q4=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=anp70g+hcxrCxn5knhiRG7XB3Lp1pIOLlF6Z8nr3z4LAZ/Hf3pl1J76Dhy9XIgyCl
	 zz1wzEikMyrQo+NiCcPySGd8W/Y4Cztu0VgdJUFg1fPPh76zZ71lVzlRSxDoSA9V7q
	 oS9Nam8ZJj1f/rCEBy9G1uyvbn7rCRkh8PFqt6RA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BB44FF80154;
	Wed, 10 Aug 2022 21:06:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 40A55F801F5; Wed, 10 Aug 2022 21:06:36 +0200 (CEST)
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr
 [80.12.242.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 938C6F800FB
 for <alsa-devel@alsa-project.org>; Wed, 10 Aug 2022 21:06:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 938C6F800FB
Received: from [192.168.1.18] ([90.11.190.129]) by smtp.orange.fr with ESMTPA
 id Lr2AooOzc0DonLr2Aorj5l; Wed, 10 Aug 2022 21:06:28 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 10 Aug 2022 21:06:28 +0200
X-ME-IP: 90.11.190.129
Message-ID: <59ae9a23-4314-dc52-92da-78cefa0eb919@wanadoo.fr>
Date: Wed, 10 Aug 2022 21:06:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ASoC: Intel: kbl_rt5663_max98927: Simplify clk_get() usage
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
References: <55e59c4792d64ff6336fcaa85ec15590553e9d63.1659903516.git.christophe.jaillet@wanadoo.fr>
 <YvO3ip3LPw2QhADB@sirena.org.uk>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <YvO3ip3LPw2QhADB@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Cezary Rojewski <cezary.rojewski@intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Harsha Priya <harshapriya.n@intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 kernel-janitors@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vkoul@kernel.org>,
 "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Sriram Periyasamy <sriramx.periyasamy@intel.com>, linux-kernel@vger.kernel.org
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

Le 10/08/2022 à 15:50, Mark Brown a écrit :
> On Sun, Aug 07, 2022 at 10:18:54PM +0200, Christophe JAILLET wrote:
>> If clk_get() returns -ENOENT, there is no need to defer the driver, -ENOENT
>> will be returned the same for each retries.
>> So, return the error code directly instead of -EPROBE_DEFER.
> 
> Are you *sure* that this is the case on Intel platforms where we don't
> have a full firmware description for clocks and therefore can't identify
> cases where we expect a clock to at some point to become available.

No, I'm *not* sure.

This looked odd enough to deserve a patch proposal, that's all.
(based on my grep and coccinelle scripts, this is the only place in the 
kernel where the result of a clk_get() is handled that way)

There are many intel.com in cc:.
Would be nice if s.o. could confirm if the patch is valid or not.

CJ
