Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205D3C433F5
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Mar 2022 14:22:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 485241749;
	Tue,  8 Mar 2022 15:22:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 485241749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646749370;
	bh=23Jzxwy8vJqcitbm8IQGuZku13AFRPyOz2jATy/ph2Y=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WjECeF673o4nbeMTAsZI2gF/iRFLJAyXyXfWSkI7329XcF/Vs8ls9WlnTp2QVlumt
	 1mXaeBgYZbnfckQE/8ClMVp2dVqmDAtAdbsR0j9TNXKw/4Qo1aeapi+R7QthZ/rSD9
	 nhmOY+KQPP76uKvKUBlvVM2YDYYmZy5B3H+yft6M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E312EF8025E;
	Tue,  8 Mar 2022 15:21:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1ED7FF800D1; Tue,  8 Mar 2022 15:21:58 +0100 (CET)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 85F0BF8025E
 for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2022 15:21:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 85F0BF8025E
X-QQ-mid: bizesmtp74t1646749303twwaac19
Received: from [192.168.31.174] ( [114.222.120.105])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 08 Mar 2022 22:21:41 +0800 (CST)
X-QQ-SSF: 00400000002000C0I000B00A0000000
X-QQ-FEAT: XiHsc86esFPTbleLfqBT4L71EjXlDprl0aGFTA9rVzI873neBA14ro0jx9TPb
 KVEoBE5qOWxh3QGX0URzGJ8V7PneyIEB7zwtLtvZ5j+RBOPle6LB2skqDD6qIaBr6ujCR3D
 oeXRb0V8YIwVyzSIZVLkuqXG1Lo/A33aaolNlFUrGp3D1UGmCE1ckgy4OSZUSkzYLWwntXr
 PjK1KYBY5aFlKqbBjhc8ORuf5pHju4xChAomDOvbl51NiLagnQuQUgEYKiFQTV1v1RYZaL/
 gF5hDvaNljos4T+cBcS6Pr18Lr3LeI0CH0APm3VTKWpQq/r+C3emA9jJ4+ncKOuH8O7LJki
 bfM1MCrxgGPRrNeA517OqDCplA1VW9/9jtyJLLgsqQ7IJMhHcE=
X-QQ-GoodBg: 2
Message-ID: <0776c355-6215-6aad-5af7-f683d128038e@uniontech.com>+7242DE7B718268FF
Date: Tue, 8 Mar 2022 22:21:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] ASoC: Intel: catpt: use asoc_substream_to_rtd()
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Jaroslav Kysela <perex@perex.cz>
References: <20220307151939.32870-1-zhanglianjie@uniontech.com>
 <f621882b-f962-15f4-ac74-4e93edc5fde6@intel.com>
From: Lianjie Zhang <zhanglianjie@uniontech.com>
In-Reply-To: <f621882b-f962-15f4-ac74-4e93edc5fde6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
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



在 2022/3/8 00:19, Cezary Rojewski 写道:
> On 2022-03-07 4:19 PM, Lianjie Zhang wrote:
>> Now we can use asoc_substream_to_rtd() macro,
>> let's use it.
>>
>> Signed-off-by: Lianjie Zhang <zhanglianjie@uniontech.com>
>> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
> 
> 
> Hello,
> 
> Please do not add reviewer tags until it's actually provided by them.
> In regard to v2, thanks for addressing the title. Patch LGTM.
> 
Thanks, I re-posted v3 without adding reviewer tags.
> 
> Regards,
> Czarek
> 

-- 
Kind regards,
Lianjie


