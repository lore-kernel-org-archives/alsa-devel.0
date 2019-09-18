Return-Path: <SRS0=PUtL=XN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D1DC4CEC9
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Sep 2019 13:32:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2C4920856
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Sep 2019 13:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JNR9XxKx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VzJBJs4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C4920856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 91656166C;
	Wed, 18 Sep 2019 15:31:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 91656166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568813545;
	bh=3wZkeiOlkkJEucJnwhi1kHs2GjuZDInug4qLDznoRk4=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JNR9XxKxkZY3kKbkgiwBfaDLMcpWFODU/aRwZ6DK2ZV/KGbP5RH0bP1eZYJIVkLG1
	 /IH0jKidO1jTTB7RCnNDsPs6GPf6SRUmCeGfFWfd+NTJEfTyCs144SHX4pHeDUyPoK
	 5753E7fgzNLncwr5TQF7bhj+VfZ+fQ+aaDgGopjQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EF503F804FF;
	Wed, 18 Sep 2019 15:31:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F04FDF80506; Wed, 18 Sep 2019 15:31:31 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7728BF800C1
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2019 15:31:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7728BF800C1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="VzJBJs4+"
Received: by mail-wm1-x335.google.com with SMTP id t3so79677wmj.1
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2019 06:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nZAZtTLeeKrq4SDF0mZnBrljWVqiBbBzFuVuAA3C3+g=;
 b=VzJBJs4+SdyDHL+ZtBdGsmEbxfgczBbomBJDY7Fuaoa7grZut4IA5YP4KGlG++utO0
 dHkyWyULjYC0jjAlZMsqO24hMEOJwKuxiy2Dunn6VN6ERG3d/efj4VRuSYDQpL21+qoe
 HKHJKhAqWVn9gKvozDW+iI/KJ4zyGlnGJlYyGVaHTcLrYSyZD9xSQTa3xYu9dNJsj0py
 /yhqyPILIAegfD3eH11fCo76VN9m+MXlsWsgnOGomvl2rP+vlJNwoVaSYketL1ziLTpo
 vhMN6Aq3zhmtNkIKzhd+8dI7EEhNoD3YY7KEBbdyDDTXgXcnfQRuevHHRCZlgfG/Eejs
 vv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nZAZtTLeeKrq4SDF0mZnBrljWVqiBbBzFuVuAA3C3+g=;
 b=f4VVzY3ESAgdriHBwGN7KoTWgmltCeAkAHxgmalnLZNuvCYxNxIgLbXKteqCMKlaSa
 YglEmRDtsI2GYzblDSwDuzrUpCU3f61gLT8r1WSiW+PglK8vhkf6AcR/kFAoPijNdp88
 u9KTmi8k4lNXIkmdMFRCoDq02qI6v2icEytBHMSjK88vtgzl0SqhdDr429m23oWzUEKN
 bnK1bOsfC8pGr7Ag/O/l453B9FKY+ZXAvdkqUsuf224/13VJ6cZH+cvCWy0AdnoSP9oD
 /oWBWZGPokTmjxLqDmmwDwkMlGIeCwnhAZkcHwM5KQ61HIBeSVzY2ttncS1o2pPnbZ+T
 PasA==
X-Gm-Message-State: APjAAAVNxIO7oqy52BaiisjfURwSMlGYaxoSJBV7cP3FTeHHQ5aGToj2
 pMWjM/U6NCxTWScJHm5xNTxmQFrci6c=
X-Google-Smtp-Source: APXvYqxm/Gd2zDK4DuPra1wSPR3TUmPkX1HISucI/ZIGhrHrq5R4BMKPh03L3upsp7VZoXI2Q4tuZA==
X-Received: by 2002:a05:600c:28d:: with SMTP id
 13mr2997079wmk.84.1568813487029; 
 Wed, 18 Sep 2019 06:31:27 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id z142sm4707474wmc.24.2019.09.18.06.31.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Sep 2019 06:31:26 -0700 (PDT)
To: Jaroslav Kysela <jkysela@redhat.com>
References: <15679391594432724-alsa-devel@perex.cz>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <1bef66ab-cde2-cc2e-eb47-010f65fb7779@linaro.org>
Date: Wed, 18 Sep 2019 14:31:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <15679391594432724-alsa-devel@perex.cz>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Licence change for your alsa-lib UCM commits
 (Srinivas Kandagatla: 3 total)
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



On 08/09/2019 11:39, Jaroslav Kysela wrote:
> As discussed, we would like to move the UCM configuration files from the
> alsa-lib repository to new alsa-ucm-conf repository with the licence change
> from LGPL-2.1 to BSD-3-Clause.
> 
> I would like to check, if you agree with this licence change. Please, answer
> to this e-mail and write your agreement / disagreement (keep CC to
> the alsa-devel mailing list for the archiving purposes).
> 
> Thank you for your time and co-operation.
> 
> Reference:  https://mailman.alsa-project.org/pipermail/alsa-devel/2019-July/153257.html
> 
> List of your commit(s):
> 
>    daafa451587b9e1d018f147885f38290a344a65a
>      ucm: Add ucm files for DB410c board.
>    c01dc3fa4899a9b9948629c103c0bc435d4f1574
>      conf/ucm: DB410c-HiFi: add CIC selection
>    7442c8b9be91ef576871eed5efce9499fcdeab4a
>      ucm: Add ucm files for DB820c board
> 
Thanks for doing this.

I agree with changing this license from LGPL-2.1 to BSD-3-Clause.

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini

> ---
> Jaroslav Kysela <perex@perex.cz>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
