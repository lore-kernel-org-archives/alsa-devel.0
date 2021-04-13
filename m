Return-Path: <SRS0=Dyxj=JK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1BEC433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Apr 2021 14:03:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AF4E613B1
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Apr 2021 14:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF4E613B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2021D1657;
	Tue, 13 Apr 2021 16:02:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2021D1657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618322606;
	bh=QadQcuELLHTgyae5i+YZQMbgP24u/rktszRTkhaAPbw=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hnFuTAOwpanUvYFGvy+gfOQTNekzX32XwU5sAVHBVngaAmuoe8hSVZAZ/0ppsW0MW
	 WdufETsJNXrETpudfZya6hcO7bXNzoYHfYnhCL8r3Ts8HHGWaVmEo8Qt0oEZ7dfLik
	 ltxZ1/8wGTPpEWYDSSBE8Aji+IM1Ar6Zks+KbxPI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 74748F8021D;
	Tue, 13 Apr 2021 16:02:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5D827F8022B; Tue, 13 Apr 2021 16:02:33 +0200 (CEST)
Received: from smtp.smtpout.orange.fr (smtp13.smtpout.orange.fr
 [80.12.242.135])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2E917F80161
 for <alsa-devel@alsa-project.org>; Tue, 13 Apr 2021 16:02:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2E917F80161
Received: from [192.168.1.18] ([86.243.172.93]) by mwinf5d76 with ME
 id sE2N2400F21Fzsu03E2NeZ; Tue, 13 Apr 2021 16:02:24 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 13 Apr 2021 16:02:24 +0200
X-ME-IP: 86.243.172.93
Subject: Re: [PATCH] ASoC: cs35l35: Fix an error handling path in
 'cs35l35_i2c_probe()'
To: Mark Brown <broonie@kernel.org>
References: <15720439769ba94ffb65c90217392b0758b08f61.1618145369.git.christophe.jaillet@wanadoo.fr>
 <20210413124323.GD5586@sirena.org.uk>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <3f276ab6-1704-84ed-3681-d639ba1e0010@wanadoo.fr>
Date: Tue, 13 Apr 2021 16:02:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210413124323.GD5586@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, tiwai@suse.com,
 kernel-janitors@vger.kernel.org, lgirdwood@gmail.com,
 james.schulman@cirrus.com, david.rhodes@cirrus.com,
 linux-kernel@vger.kernel.org
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

Le 13/04/2021 à 14:43, Mark Brown a écrit :
> On Sun, Apr 11, 2021 at 02:51:06PM +0200, Christophe JAILLET wrote:
>> If 'devm_regmap_init_i2c()' fails, there is no need to goto err. We should
>> return directly as already done by the surrounding error handling paths.
> 
> These are stylistic improvements rather than bug fixes so it's probably
> better not to call them fixes.
> 

Ok, agreed.
The error handling path is a no-op in such a case.

What do you prefer:
   - you fix the subject?
   - I send a v2 with a new subject?
   - we leave it as-is as this patch is a no-op in the real world? So it 
doesn't really mater.

CJ
