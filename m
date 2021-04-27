Return-Path: <SRS0=XYKd=JY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E0EC433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Apr 2021 10:07:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8ECD60FDA
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Apr 2021 10:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8ECD60FDA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ivitera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B22616E2;
	Tue, 27 Apr 2021 12:06:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B22616E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619518067;
	bh=zg2oUD4mXiixYmdHJ0YP7Mw7Ux63m7P/a6m20rr8YP8=;
	h=To:From:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PwU1p+fwZ1StlQo/oXoDpLzXE0YFLpK9/RdD5Io+x4pGaDir9BMOXjmSVX6rin9HD
	 nkNq5SCSX0Vycx1/6QZaUAjspEhekJ3CafHC5OrE2laQE880TSoL6qnLNIwSAfKWW3
	 ruc4RFKxF/dxam3OZrBPfviM8yetAQn9JoHb0mrM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C55EF801D8;
	Tue, 27 Apr 2021 12:06:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 08A32F801EC; Tue, 27 Apr 2021 12:06:55 +0200 (CEST)
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1E128F800C0
 for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2021 12:06:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1E128F800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com
 header.b="oHgn3wf8"; 
 dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com
 header.b="pk7SU/06"
Received: from localhost (localhost [127.0.0.1])
 by cable.insite.cz (Postfix) with ESMTP id D9ADEA1A3D402
 for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2021 12:06:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
 t=1619518000; bh=zg2oUD4mXiixYmdHJ0YP7Mw7Ux63m7P/a6m20rr8YP8=;
 h=To:From:Subject:Date:From;
 b=oHgn3wf84fb4lYfKoBqxwoUwHwnL+4a5i7ofRUIysY+XVJn/IEdh/7j3Iexm5oaBx
 l7gxnurd1CMOaD1nEL4CaxvpMOeTLtsYuaeKAQVXNQ7U+d9To3j5TVT7K3Eytbpc5Y
 owj2gvwGl7i4B5vAQPeGVRLxZUSejMBccMmsGXtk=
Received: from cable.insite.cz ([84.242.75.189])
 by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eUVZY6dg77W0 for <alsa-devel@alsa-project.org>;
 Tue, 27 Apr 2021 12:06:35 +0200 (CEST)
Received: from [192.168.105.22] (ip28.insite.cz [81.0.237.28])
 (Authenticated sender: pavel)
 by cable.insite.cz (Postfix) with ESMTPSA id 1637EA1A3D401
 for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2021 12:06:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
 t=1619517995; bh=zg2oUD4mXiixYmdHJ0YP7Mw7Ux63m7P/a6m20rr8YP8=;
 h=To:From:Subject:Date:From;
 b=pk7SU/06H9VZJhU/i37TnTpM0w0oaY3G5tAk5udnQ5QOLH49kvjzBjsS4KR75vhT0
 4BRuIjPHp/fZmOsVw+Dm2k3NnFcY/KGCToofG2U/cqvZM/0v8k1yfWqAesyvLzrNxq
 J2T011PoyTQ/arcoTWVKr8y37CqeU+Zlxmtacths=
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: ASoC: Serving gpio_desc in codec driver with I2C GPIO expander?
Message-ID: <5c2c2007-ea23-bcbd-d6be-72910af7928c@ivitera.com>
Date: Tue, 27 Apr 2021 12:06:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Hi,

Please is there any reasonable way to use an existing codec driver
controlled by gpio_desc (e.g.
https://elixir.bootlin.com/linux/v5.12/source/sound/soc/codecs/ak4458.c#L47
) where the actual pins are provided by outputs of an I2C GPIO expander?

I am trying to decide whether to base my setup (ADC + DAC + clock
generator + I2S DAI, all controlled via I2C + pins via I2C GPIO
expander) purely on ASoC, or whether to keep the ASoC driver minimal
(like asoc-simple-card) and do all the I2C settings in userspace as part
of the software which writes/reads audio data. It seems the ASoC path is
way more complicated as it involves multiple layers of abstractions
prone to errors from my side.

Thank you very much for your opinion and suggestions.

Best regards,

Pavel.
