Return-Path: <SRS0=OYz8=2I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04F3C43603
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 09:54:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5099A227BF
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 09:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GILoDEsc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5099A227BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4C679886;
	Wed, 18 Dec 2019 10:53:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4C679886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576662842;
	bh=oskzzNJyQd1yVhF0ck3M4vdCRMHTTH+YoTrlWJDdxUs=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GILoDEscs8deiOUou4mhlreLM9WK7vsWU1gXr1qVFrWMfvXZ/nhibOYSSCN7JInTc
	 BAmTjsUEFqYVV6fuwnRY0+7TcnXy0xOvg1F4J5GdGohmv3nW1TNvGXVvE3e9Dysvtt
	 WGKgB0GcJRHJJH7IIH0FdQR1JW1Ii75WIaKCNkTU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B3F53F8015A;
	Wed, 18 Dec 2019 10:53:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CF56AF8022C; Wed, 18 Dec 2019 10:53:09 +0100 (CET)
Received: from mail.bugwerft.de (mail.bugwerft.de [IPv6:2a03:6000:1011::59])
 by alsa1.perex.cz (Postfix) with ESMTP id 572D9F80059
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2019 10:53:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 572D9F80059
Received: from [10.10.222.226] (unknown [194.162.236.226])
 by mail.bugwerft.de (Postfix) with ESMTPSA id 3A811281DF4;
 Wed, 18 Dec 2019 09:46:38 +0000 (UTC)
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org
References: <20191209183511.3576038-1-daniel@zonque.org>
 <cb86a793-014a-1acf-c144-f9014ac0a0ac@linux.intel.com>
From: Daniel Mack <daniel@zonque.org>
Message-ID: <22803ea0-0c4a-b096-ec11-5e8f5c27d8d3@zonque.org>
Date: Wed, 18 Dec 2019 10:53:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <cb86a793-014a-1acf-c144-f9014ac0a0ac@linux.intel.com>
Content-Language: en-US
Cc: lars@metafoo.de, sboyd@kernel.org, mturquette@baylibre.com,
 robh+dt@kernel.org, broonie@kernel.org, pascal.huerst@gmail.com,
 lee.jones@linaro.org
Subject: Re: [alsa-devel] [PATCH 00/10] mfd: Add support for Analog Devices
 A2B transceiver
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi,

On 12/17/19 8:29 PM, Pierre-Louis Bossart wrote:
>> Transceivers can both receive and provide audio, and streams can be
>> routed from one node to any other, including many others. The tricky
>> bit is how to expose the audio routing in DT in a sane way.
>> The way it is implemented here, the slave nodes specify the number of
>> slots they each consume and generate, and which thereof they forward
>> from one side to the other. This mimics the internal register
>> structure and should allow for even exotic setups.
> 
> It was my understanding that the A2B bus is bidirectional but with
> separate time windows allocated for host->device and device->host
> transmission. The wording seems to hint at device-to-device
> communication but I wonder if this is really what you meant.

Yes, audio frames can be exchanged between two slave nodes without
interaction by the master node. I'm not sure what the best way is to
describe that in DT really, but as the hardware is capable of doing it,
there must be a way to enable such setups.


Thanks,
Daniel

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
