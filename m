Return-Path: <SRS0=zeHb=W7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DD1C3A5A7
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Sep 2019 15:47:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E210422CF5
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Sep 2019 15:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Os00eEGQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E210422CF5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A11DB1655;
	Wed,  4 Sep 2019 17:46:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A11DB1655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567612037;
	bh=qtuZslYKA8nxGBf8RQMXxniRAxkzldODui3wrHQBMS8=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Os00eEGQ9bh+YyPiNxVBWq3JgFLBuQJR5CfSFXFFDwSMt1dJmmHuEaEXzkTDUZskA
	 KXDUQBo2w74maPAEmUkdPpNDlE84ukUlHxSrWdzxNiM1F7SDhcRFUQhQp8jKmiFyEX
	 J3b3gtrP5c9JBfmFJGdo7z3jgPB2QwCJdC4tlDes=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 25310F80394;
	Wed,  4 Sep 2019 17:46:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A0CD2F803A6; Wed,  4 Sep 2019 17:46:24 +0200 (CEST)
Received: from www1102.sakura.ne.jp (www1102.sakura.ne.jp [219.94.129.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25895F80228
 for <alsa-devel@alsa-project.org>; Wed,  4 Sep 2019 17:46:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25895F80228
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x84Fk2VD072180;
 Thu, 5 Sep 2019 00:46:02 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp);
 Thu, 05 Sep 2019 00:46:02 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp)
Received: from [192.168.1.2] (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
 (authenticated bits=0)
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x84Fk2oG072177
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
 Thu, 5 Sep 2019 00:46:02 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20190903165322.20791-1-katsuhiro@katsuster.net>
 <20190903165322.20791-2-katsuhiro@katsuster.net>
 <CAHp75Vcm0yus5GpZEttdr_C07gmQXeNJ16gb_TFLUTvGkc164w@mail.gmail.com>
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <23e51463-1d95-59dd-c449-d4245aadcab5@katsuster.net>
Date: Thu, 5 Sep 2019 00:46:02 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vcm0yus5GpZEttdr_C07gmQXeNJ16gb_TFLUTvGkc164w@mail.gmail.com>
Content-Language: en-US
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Daniel Drake <drake@endlessm.com>, Hans de Goede <hdegoede@redhat.com>,
 Mark Brown <broonie@kernel.org>, David Yang <yangxiaohua@everest-semi.com>
Subject: Re: [alsa-devel] [PATCH v3 2/4] ASoC: es8316: add clock control of
	MCLK
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

Hello Andy,

Thank you for reviewing.

On 2019/09/04 23:37, Andy Shevchenko wrote:
> On Tue, Sep 3, 2019 at 7:54 PM Katsuhiro Suzuki <katsuhiro@katsuster.net> wrote:
>>
>> This patch introduce clock property for MCLK master freq control.
>> Driver will set rate of MCLK master if set_sysclk is called and
>> changing sysclk by board driver.
>>
>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> 
> 
>> +       if (es8316->mclk) {
> 
> You don't need this if clock has been requested as optional
> (clk_get_optional() or so).
> 
>> +               ret = clk_set_rate(es8316->mclk, freq);
>> +               if (ret)
>> +                       return ret;
>> +       }
> 
>> +       es8316->mclk = devm_clk_get(component->dev, "mclk");
>> +       if (PTR_ERR(es8316->mclk) == -EPROBE_DEFER)
>> +               return -EPROBE_DEFER;
>> +       if (IS_ERR(es8316->mclk)) {
>> +               dev_err(component->dev, "clock is invalid, ignored\n");
>> +               es8316->mclk = NULL;
>> +       }
> 
> devm_clk_get_optional()
> 
>> +       if (es8316->mclk) {
> 
> Ditto as above.
> 
>> +               ret = clk_prepare_enable(es8316->mclk);
>> +               if (ret) {
>> +                       dev_err(component->dev, "unable to enable clock\n");
>> +                       return ret;
>> +               }
>> +       }
> 
>> +       if (es8316->mclk)
> 
> Ditto.
> 
>> +               clk_disable_unprepare(es8316->mclk);
>> +}
> 
> 

Indeed, NULL check of MCLK is not needed.
I'll make and send fixup patch.

Best Regards,
Katsuhiro Suzuki
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
