Return-Path: <SRS0=Sdsu=W6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1150FC3A5A2
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:04:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60DEA22CF8
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="t9U/o3Ym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60DEA22CF8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D50D1678;
	Tue,  3 Sep 2019 18:03:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D50D1678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567526665;
	bh=M2FR+Z3DM6X7+vSCYFVLJFL1mY7wj6ycBvcFZOvwFkg=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t9U/o3Ym5CA6YoV/IiFPpEqOj2j5Cpjjy4VOO2RrWA/HSdb8QNkzhFrBVoAAnhKJs
	 nH+gQrifTJUhhhNnz099ZHhwvFvvgx4T1mPqJs2V5I+wSENOt6bhnXJ7Jl8oMIJBN2
	 DYUSZsr9tT9ohbIyn48PbvhPC3IXnJnPbEUROkxo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2693DF8045F;
	Tue,  3 Sep 2019 18:03:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 81AD6F8049B; Tue,  3 Sep 2019 18:03:33 +0200 (CEST)
Received: from www1102.sakura.ne.jp (www1102.sakura.ne.jp [219.94.129.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 77425F80392
 for <alsa-devel@alsa-project.org>; Tue,  3 Sep 2019 18:03:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77425F80392
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x83G3JSd025010;
 Wed, 4 Sep 2019 01:03:19 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Wed, 04 Sep 2019 01:03:19 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from [192.168.1.2] (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
 (authenticated bits=0)
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x83G3Ihr025006
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
 Wed, 4 Sep 2019 01:03:18 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
To: Mark Brown <broonie@kernel.org>
References: <20190831162650.19822-1-katsuhiro@katsuster.net>
 <20190902120248.GA5819@sirena.co.uk>
 <1a3c5934-4731-d474-e9d5-795e8337b180@katsuster.net>
 <20190903111138.GA6247@sirena.co.uk>
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <c142c351-5559-b162-e68f-98cf86b039aa@katsuster.net>
Date: Wed, 4 Sep 2019 01:03:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903111138.GA6247@sirena.co.uk>
Content-Language: en-US
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, David Yang <yangxiaohua@everest-semi.com>,
 Daniel Drake <drake@endlessm.com>
Subject: Re: [alsa-devel] [PATCH v2 1/3] ASoC: es8316: judge PCM rate at
	later timing
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

Hello Mark,

On 2019/09/03 20:11, Mark Brown wrote:
> On Tue, Sep 03, 2019 at 04:19:10AM +0900, Katsuhiro Suzuki wrote:
>> On 2019/09/02 21:02, Mark Brown wrote:
> 
>>> The best way to handle this is to try to support both fixed and variable
>>> clock rates, some other drivers do this by setting constraints based on
>>> MCLK only if the MCLK has been set to a non-zero value.  They have the
>>> machine drivers reset the clock rate to 0 when it goes idle so that no
>>> constraints are applied then.  This means that if the machine has a
> 
>> In my understanding, fixed and variable clock both use set_sysclk() for
>> telling their MCLK to codec driver. For fixed MCLK cases we need to
>> apply constraint but for variable MCLK cases we should not set
>> constraints at set_sysclk(). How can we identify these two cases...?
> 
> Like I say it's usually done by settingthe MCLK to 0 when not in use and
> then not applying any constraints if there's no MCLK set.
> 

Ah... I understand. Current implementation refuses MCLK == 0.
I'll change to accept MCLK == 0 for fixed clock users and send v3 patch.

Best Regards,
Katsuhiro Suzuki
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
