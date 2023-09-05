Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065C1C83F3E
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Sep 2023 07:27:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D6756832;
	Tue,  5 Sep 2023 09:26:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D6756832
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693898859;
	bh=20m3yAvFIumbxfMl1qW909QMH99j5aKU7W8Jx+P6ebE=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=bu2s/t6A1XMxucByohrnslzn9BzqkyNF6RZi5eAQclxtXujnH1DkC8HZbc5LgPi/M
	 ioLEd18ADUxe2R3+CK2jltJAuAKQ9C1xzazVBOCUTiSmceff9hFREYlfm2ytq9mINd
	 OMTgIA8gEz+gnQEj3ikx7Rw3z8Im6KBzF4IzWRyY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 70771F80552; Tue,  5 Sep 2023 09:26:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 93BDBF80141;
	Tue,  5 Sep 2023 09:26:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 22997F8047D; Tue,  5 Sep 2023 09:26:19 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E13B7F800F5
	for <alsa-devel@alsa-project.org>; Tue,  5 Sep 2023 09:26:14 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 2D90E11D4;
	Tue,  5 Sep 2023 09:26:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 2D90E11D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1693898773; bh=65W05CP1GwBVSJp22ZlGq3C6nujBXGvPAjpBvfEdCxM=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
	b=b1qqXLWRyYvm+bzV/+gVY+WVAAnjrwjmp/WUugxAeigzY2HNzebXe1iTHvKs5NM1G
	 S2vISTmqCTi+upVUJCSFlWgDAdlpuNFVc7C/+GTMiv3EEulfA04on3BhwzaSeRrspo
	 MiDXMUi/C5kPCXEDQ0OQiyXeQEJT7yDA/t3he7rM=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Tue,  5 Sep 2023 09:26:10 +0200 (CEST)
Message-ID: <20945414-c6c0-acf7-8340-9e7697b0e833@perex.cz>
Date: Tue, 5 Sep 2023 09:26:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Terry Hummel <Terry.Hummel@catalina.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Dulani McLaurin <Dulani.McLaurin@catalina.com>
References: 
 <BN0PR02MB80455425D6077DEC556A4F83FAE9A@BN0PR02MB8045.namprd02.prod.outlook.com>
From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Bug Report: Audio issues with CentOS7
In-Reply-To: 
 <BN0PR02MB80455425D6077DEC556A4F83FAE9A@BN0PR02MB8045.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 7RYOGAR2JMRAKDPFBTR44YP4O6BQ53TX
X-Message-ID-Hash: 7RYOGAR2JMRAKDPFBTR44YP4O6BQ53TX
X-MailFrom: perex@perex.cz
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7RYOGAR2JMRAKDPFBTR44YP4O6BQ53TX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 04. 09. 23 16:56, Terry Hummel wrote:

> How to reproduce:
> Try to get sound to come from the HP RP 5810 speaker using:
> printf '\a'
> printf '\007'
> echo -e '\a'
> echo -e '\007'
> beep -f330 -l137 -n -f330 -l275 -n -f330 -l137 -n…etc (I have a beep tune in a shell script)
> // when beep is run, it appears to run with no errors.
> 
> Actual results:
> The above commands run without any complaints of missing audio device. But no sound coming from the 5810 PC internal Speakers

Beeps/terminal bells are a bit different. They are handled through the sound 
servers these days, thus the PWM modulator output is disabled by default in 
the HDA driver. I assume that you're running your system without the sound server.

$ modinfo snd-hda-intel | grep beep
parm:           beep_mode:Select HDA Beep registration mode (0=off, 1=on) 
(default=1). (array of bool)

Note that CentOS 7 have the default 0 (off) for this parameter. The 
description is incorrect. Try to set this module parameter in modprobe 
configuration files:

   echo "options snd-hda-intel beep_mode=1" > /etc/modprobe.d/alsa-beep.conf
   ... and reboot

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

