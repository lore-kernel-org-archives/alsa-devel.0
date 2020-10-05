Return-Path: <SRS0=eLx3=DM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE885C4363A
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 13:00:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 268272078D
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 13:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hhWN5HBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268272078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C77F1785;
	Mon,  5 Oct 2020 15:00:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C77F1785
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601902856;
	bh=uUGURdRKURyKgDW3DQIEFdCl4fFqMzZ7aCCajSfzXTQ=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hhWN5HByAW1ALr3Z4ALtNKUR2rsDP4lpKBUfgs+c5TEe3O4NQ1I590vi5zMd/Ikj8
	 63LmE5wBPi3BSW51piOn75WJ3jEMLploKSeqd/HsuAMIExlf8tkipsxlRqDtdbJrVc
	 AHnSK3lq5xpJSJvM2PpDkfy1pF8AQIKV2DDCiBeI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B66AAF80121;
	Mon,  5 Oct 2020 15:00:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D08F7F8025A; Mon,  5 Oct 2020 15:00:03 +0200 (CEST)
Received: from out-2.mail.amis.net (out-2.mail.amis.net [212.18.32.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4DDA6F80121
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2020 14:59:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4DDA6F80121
Received: from in-4.mail.amis.net (in-4.mail.amis.net [212.18.32.23])
 by out-2.mail.amis.net (Postfix) with ESMTP id B0AE9811FF;
 Mon,  5 Oct 2020 14:59:54 +0200 (CEST)
Received: from in-4.mail.amis.net (localhost [127.0.0.1])
 by in-4.mail.amis.net (Postfix) with ESMTP id A6C0717048;
 Mon,  5 Oct 2020 14:59:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amis.net
Received: from in-4.mail.amis.net ([127.0.0.1])
 by in-4.mail.amis.net (in-4.mail.amis.net [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id CycFUBqLC64b; Mon,  5 Oct 2020 14:59:54 +0200 (CEST)
Received: from smtp2.amis.net (smtp2.amis.net [212.18.32.44])
 by in-4.mail.amis.net (Postfix) with ESMTP id 24D7417055;
 Mon,  5 Oct 2020 14:59:54 +0200 (CEST)
Received: from [192.168.69.116] (89-212-21-243.static.t-2.net [89.212.21.243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by smtp2.amis.net (Postfix) with ESMTPSA id 9133C7FE59;
 Mon,  5 Oct 2020 14:59:53 +0200 (CEST)
Subject: Re: [PATCH 1/2] ASoC: fsl: fsl_ssi: add ac97 fixed mode support
To: Mark Brown <broonie@kernel.org>
References: <20201005111644.3131604-1-primoz.fiser@norik.com>
 <20201005114925.GC5139@sirena.org.uk>
From: Primoz Fiser <primoz.fiser@norik.com>
Message-ID: <bc31e0f2-969c-4eb1-1dc0-cf4284427a4b@norik.com>
Date: Mon, 5 Oct 2020 14:59:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201005114925.GC5139@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Shengjiu Wang <shengjiu.wang@gmail.com>
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

Hi Mark,

On 5. 10. 20 13:49, Mark Brown wrote:
> On Mon, Oct 05, 2020 at 01:16:43PM +0200, Primoz Fiser wrote:
> 
>> bits. But in summary, when SSI operates in AC'97 variable mode of
>> operation, CODECs can sometimes send SLOTREQ bits for non-existent audio
>> slots which then "stick" in SSI and completely break audio output.
> 
> If this is something that happens based on the CODEC shouldn't we be
> doing this by quirking based on the CODEC the system has rather than
> requiring people set a separate DT property?
> 

To be totally honest, we are not 100% sure if this is only CODEC's fault 
or something else might be causing these issues.

For example, it could be some EMI/noise that causes SLOTREQ bits to flip 
spuriously. Or it could even be the buggy SSI itself (taking into 
account all the issues with channel slipping, slot filtering, AC'97 reg 
reading/writing, etc)?

We are just referencing commit 01ca485171e3 ("ASoC: fsl_ssi: only enable 
proper channel slots in AC'97 mode"), as we saw that UDOO board had the 
same problems. I added commit author to CC.

We were able to overcome those by programming SSI in AC'97 fixed mode 
which driver up to now completely ignored (it was using only AC'97 
variable mode).

Additionally, we are using WM9712 codec and UDOO board is using VT1613, 
right? So these issues might not be CODEC related at all.

BR,
Primoz




