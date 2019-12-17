Return-Path: <SRS0=Cvq+=2H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A6EC43603
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:18:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEB5020733
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="L2pbEK+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB5020733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5052A850;
	Tue, 17 Dec 2019 19:17:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5052A850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576606705;
	bh=tSPwUhU6Cf29OkCTZ67YmrS0sZv4D0LiaRwBaO1QDn8=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L2pbEK+TDtvgRQQJbIxCzpM7SHymZFGtxBUD6IQdpTdHiChRUYC/6wqDlhufSePwj
	 1KNGHgUfABBJMjmWEArbH/x4yW53hpuJywBsMMEAuI4aEzK7jc/Th0ue13zOj57tUP
	 xFCatn6hf/Tzkn4dvxV7pBDEgqIP7A0E43zNXEEo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C6969F8020B;
	Tue, 17 Dec 2019 19:17:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C18CAF80234; Tue, 17 Dec 2019 19:17:32 +0100 (CET)
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa1.perex.cz (Postfix) with ESMTP id 7D821F8020B
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2019 19:17:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7D821F8020B
Received: from [192.168.178.106] (pD95EF574.dip0.t-ipconnect.de
 [217.94.245.116])
 by mail.bugwerft.de (Postfix) with ESMTPSA id 6E681281A97;
 Tue, 17 Dec 2019 18:11:03 +0000 (UTC)
To: Luca Ceresoli <luca@lucaceresoli.net>, Wolfram Sang <wsa@the-dreams.de>
References: <20191209183511.3576038-1-daniel@zonque.org>
 <20191209183511.3576038-9-daniel@zonque.org>
 <64adf5d7-754a-f1da-aa9b-11579c5a2780@lucaceresoli.net>
 <20191212163315.GA3932@kunai>
 <482316ef-775a-cb7b-015e-e00463503e6b@zonque.org>
 <4f2e1332-eac3-e54d-5de8-b84a76cb1a34@lucaceresoli.net>
From: Daniel Mack <daniel@zonque.org>
Message-ID: <a55f7642-3ea1-e762-b5fc-8ff10b83ccc7@zonque.org>
Date: Tue, 17 Dec 2019 19:17:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <4f2e1332-eac3-e54d-5de8-b84a76cb1a34@lucaceresoli.net>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de,
 sboyd@kernel.org, mturquette@baylibre.com, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, robh+dt@kernel.org, broonie@kernel.org,
 linux-i2c@vger.kernel.org, pascal.huerst@gmail.com, lee.jones@linaro.org,
 linux-clk@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH 07/10] i2c: Add driver for AD242x bus
	controller
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

Hi Luca,

On 12/17/19 9:35 AM, Luca Ceresoli wrote:
> On 15/12/19 21:27, Daniel Mack wrote:

>> The a2b code has to tell the 'master node' the final destination of the
>> payload by programming registers on its primary i2c address, and then
>> forwards the messages to its secondary i2c address. The layout of the
>> messages don't change, and neither do the flags; i2c messages are being
>> sent as i2c messages, except their addresses are changed, a bit like NAT
>> in networking. That procedure is described on page 3-4 of the TRM,
>> "Remote Peripheral I2C Accesses".
>>
>> The 'real' i2c master that handles the hardware bus is responsible for
>> adding start conditions, and as the messages as such are untouched, I
>> believe it should do the right thing. The code in my xfer functions
>> merely suppresses reprogramming remote addresses by remembering the last
>> one that was used, but that is independent of the start conditions on
>> the wire.
> 
> My concern is not about the start condition, it's about the *repeated*
> start condition.
> 
> The first question is whether the A2B chips can do it. What if the host
> processor sets a slave chip address and then issues two messages
> separated by a repeated start condition? Will the slave transceiver emit
> a repeated start condition too?

Ah, alright. Thanks for taking the time to explain. I'll have to do some 
measurements with a hardware analyzer. Will revisit this then, and 
either provide an implementation that handles such cases correctly, or a 
comment to explain that the hardware can't do it.


Best regards,
Daniel
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
