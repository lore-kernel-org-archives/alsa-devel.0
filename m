Return-Path: <SRS0=zeHb=W7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782BCC3A5A8
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Sep 2019 15:56:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED32822CF7
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Sep 2019 15:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QwSp0vFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED32822CF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D56CF1678;
	Wed,  4 Sep 2019 17:55:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D56CF1678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567612587;
	bh=JFuPrPCq/D68BM49GUdDDnj8mCHtyuMdS71pim3UQ3s=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QwSp0vFvATB3+hDyE6Cq7BtVmJO1WTxKwdtoqL/I+xJdfDzcTToETlMblSEPikdKp
	 HgSybUVVDVTV3bmqahhtJW/SrGVb2mq+wR1NAQ5e0vHNLp29I+svC3dxK8ar1j4eZg
	 fSJUbBvxx0rqJjscg2Kwab3zuUBS13yj+MTz26Uk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 588ECF80394;
	Wed,  4 Sep 2019 17:55:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CF44CF803A6; Wed,  4 Sep 2019 17:55:34 +0200 (CEST)
Received: from www1102.sakura.ne.jp (www1102.sakura.ne.jp [219.94.129.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 55220F80171
 for <alsa-devel@alsa-project.org>; Wed,  4 Sep 2019 17:55:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 55220F80171
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x84FtLBW074387;
 Thu, 5 Sep 2019 00:55:22 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp);
 Thu, 05 Sep 2019 00:55:21 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp)
Received: from [192.168.1.2] (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
 (authenticated bits=0)
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x84FtLpL074384
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
 Thu, 5 Sep 2019 00:55:21 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
To: Mark Brown <broonie@kernel.org>
References: <20190903165322.20791-1-katsuhiro@katsuster.net>
 <20190903174801.GD7916@sirena.co.uk>
 <85c717bf-d875-016c-a303-867bdca9a645@katsuster.net>
 <20190904153016.GD4348@sirena.co.uk>
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <d6f821d9-e7ed-95fd-fc47-82208f77c5df@katsuster.net>
Date: Thu, 5 Sep 2019 00:55:21 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904153016.GD4348@sirena.co.uk>
Content-Language: en-US
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, David Yang <yangxiaohua@everest-semi.com>,
 Daniel Drake <drake@endlessm.com>
Subject: Re: [alsa-devel] [PATCH v3 1/4] ASoC: es8316: judge PCM rate at
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

On 2019/09/05 0:30, Mark Brown wrote:
> On Thu, Sep 05, 2019 at 12:06:23AM +0900, Katsuhiro Suzuki wrote:
> 
>> Would you tell me one more thing. I don't understand who sets MCLK to 0.
>> Is it needed original machine driver instead of audio-graph-card?
> 
>> On my test environment (audio-graph-card + Rockchip I2S + ES8316), it
>> seems audio-graph-card has never called set_sysclk() with freq = 0 after
>> stop play/capture sound. So my env will go to bad scenario as I described in
>> this patch.
> 
> You shouldn't need a custom machine driver - you'll just be the first
> person who ran into this with audio-graph-card.  I'd just add this
> support to the audio-graph-card, either with custom startup and shutdown
> callbacks or using a set_bias_level() callback (both get used, I'd guess
> the set_bias_level() is easier since you don't need to reference count
> anything).
> 

Oh, I understand current situation. I'll try it.
Thanks for your support!

Best Regards,
Katsuhiro Suzuki
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
