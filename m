Return-Path: <SRS0=hSRK=XO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A517EC3A5A6
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:50:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A6C021928
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Yv332z6A";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="hSjuFyol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6C021928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E622C1674;
	Thu, 19 Sep 2019 16:49:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E622C1674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568904646;
	bh=1L9F75lx/UFSY5L87v9k6Hst/F2W5zsHt6zuKod0qkY=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yv332z6AwJpjr9j6JwNcRVYpwS/wOs1+g8ZsCbZZbBsl7TQmoOx26J7rVuUGBQohd
	 WgbRSqB4+qx5gDbKSU/3WlP46kDcwUsD8MDgUFVCDSEvD5vb5jxWCzHQamkqm9A3pK
	 jAqbOkpBMp3H2X9uGc6YE41DPxzREzwFbdBY9LF0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4ACACF80096;
	Thu, 19 Sep 2019 16:49:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 35977F80361; Thu, 19 Sep 2019 16:49:54 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7C56AF80096
 for <alsa-devel@alsa-project.org>; Thu, 19 Sep 2019 16:49:48 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 922B0A003F;
 Thu, 19 Sep 2019 16:49:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 922B0A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1568904587; bh=Gyj6CbgHC0Z+yjHWbm891N0qGaDzWQoplTvPFSbyAP0=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
 b=hSjuFyol7WDtEl7BFtA9mxzlCD5nV2Mj3Il0CUy7o9XN2IaeadFmPw1qYMv4FhkkX
 MnBLLnoOE60/cXuJpJGCdZViDqdezQv+siJDDZ/jlyim4nwNfp62P+w4+72+0+Sodv
 h4yeogbgOg1ddBk4YwVhQaMnDlP7juz0XK4frGfc=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Thu, 19 Sep 2019 16:49:44 +0200 (CEST)
To: alsa-devel@alsa-project.org
References: <20190919142329.35bsdnh5skuj7jl3@toy.home.lxtec.de>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <6449d5f6-959e-4384-4e80-b68171cd8091@perex.cz>
Date: Thu, 19 Sep 2019 16:49:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190919142329.35bsdnh5skuj7jl3@toy.home.lxtec.de>
Content-Language: en-US
Cc: Elimar Riesebieter <riesebie@lxtec.de>, Mark Pearson <mpearson@lenovo.com>
Subject: Re: [alsa-devel] alsa-lib: Add ucm support for whiskeylake
 sof-skl_hda_card audio
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

Dne 19. 09. 19 v 16:23 Elimar Riesebieter napsal(a):
> Hi ALSA devs,
> 
> please notice the attached suggestion from Lenovo to support sound
> for whiskeylake sof-skl_hda_card audio.

Too many commmented lines inside without any explanation. The author should
send the patch with the signed-off-by line. Also, we are working on the LGPL
to BSD 3-Clause licence change, so it would be nice to indicate the agreement
with this.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
