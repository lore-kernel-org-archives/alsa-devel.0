Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305CAC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jun 2022 16:16:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 890771A26;
	Fri, 10 Jun 2022 18:15:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 890771A26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654877792;
	bh=Xr8epkSUPli03TY3+GMWElhYFtkvjA5wP2k3Y/aG6wk=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HsdN7we+FDGC0h3XTSYnbAMKqH6t1VfhGwGLr1O4lugPvoBF0pDUBNRSxql+q4vXv
	 P0k8ByxMJquInUW0gfkTmV+E0YDJ2xqAO+BQo5Z8j4oABEnMcua59ceUEXTzJ96lbx
	 3l6lIQG2d7Zecs10ffDM3q8TaRGXkjGKcYGwyqGA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B0969F804CF;
	Fri, 10 Jun 2022 18:15:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 60702F804D2; Fri, 10 Jun 2022 18:15:40 +0200 (CEST)
Received: from smtp.smtpout.orange.fr (smtp05.smtpout.orange.fr
 [80.12.242.127])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B456F800DF
 for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2022 18:15:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B456F800DF
Received: from [192.168.1.18] ([90.11.190.129]) by smtp.orange.fr with ESMTPA
 id zhIDnDopVE80KzhIDn3fuF; Fri, 10 Jun 2022 18:15:30 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 10 Jun 2022 18:15:30 +0200
X-ME-IP: 90.11.190.129
Message-ID: <d53ad0e2-e32d-1b46-b626-e82b44230704@wanadoo.fr>
Date: Fri, 10 Jun 2022 18:15:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] ASoC: samsung: i2s: Check before clk_unregister() not
 needed
Content-Language: fr
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Yihao Han <hanyihao@vivo.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20220527065412.3677-1-hanyihao@vivo.com>
 <2bcf706b-10d5-9369-ff8a-2a3263f9fa70@linaro.org>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <2bcf706b-10d5-9369-ff8a-2a3263f9fa70@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Le 29/05/2022 à 10:06, Krzysztof Kozlowski a écrit :
> On 27/05/2022 08:54, Yihao Han wrote:
>> clk_unregister() already checks the clk ptr using
>> !clk || WARN_ON_ONCE(IS_ERR(clk)) so there is no need to check it
>> again before calling it.
>>
> 
> No, this explanation does not make sense. clk_unregister() warns and
> this code is not equivalent.
> 
> 
> 
> Best regards,
> Krzysztof
> 

Hi,

Moreover, as pointed out by greg in [1] on some plateform the assertion 
in the commit description is wrong. His message is about clk_disable() 
but, IIUC, it makes sense for clk_unregister() as well. See [2] on the 
sh plateform.

CJ

[1]: https://lore.kernel.org/all/YqMIUOTU%2Fk5XpW3I@kroah.com/
[2]: 
https://elixir.bootlin.com/linux/v5.18.3/source/drivers/sh/clk/core.c#L452
