Return-Path: <SRS0=RrJr=FN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADF1C433FE
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Dec 2020 14:26:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A012F207B1
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Dec 2020 14:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A012F207B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5435716B8;
	Wed,  9 Dec 2020 15:25:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5435716B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607524007;
	bh=tWZfwuHpYnAzdWIvVyQMm6pm27Sb6JmeEuYNRE4b0r4=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JEeR3FwweWJANP3V53nAhP1QrGuam7iMbcv0YLWwRa1roibmwwj3lIGnAfxZ4U5RP
	 FOHbNW8289ZGaw91fvt7mhb5eiXaSJaAc9/xp0sDGUvkVZxVpoT2FIxOw+XBZsIRPn
	 FthvpTXAsh1lduAibYbG3uM49jFRWW3nHcUjGEk4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BBED8F801D8;
	Wed,  9 Dec 2020 15:25:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3AD81F8020D; Wed,  9 Dec 2020 15:25:55 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F1440F801D8
 for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2020 15:25:46 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 55416A003F;
 Wed,  9 Dec 2020 15:25:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 55416A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1607523945; bh=kZltQRPibv+9K1DdZsEKYdbPhvdjwqUtT/9m5dO92AU=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=jAE0axALkzjVT14hoOPIghTn7kJ/ejKrqPTB9Gr2T3f5FP/PG3kMN3s8/vyl0A9Ur
 cssGM6dPAw/Mbt3+IYNQ7marXW5o4dqY8Y65G1UiJPzTzTkoweNXVelOMyhdRT86aY
 nBaxR4bAGmBQqjjASkURXUhjYAOz64caKOnJG5uY=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed,  9 Dec 2020 15:25:42 +0100 (CET)
Subject: Re: [RFC][PATCH 0/2] design a way to change audio Jack state by
 software
To: Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
 tiwai@suse.de
References: <20201209124344.219158-1-hui.wang@canonical.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <575811fc-cb64-c7d4-bf6b-5044949a326c@perex.cz>
Date: Wed, 9 Dec 2020 15:25:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201209124344.219158-1-hui.wang@canonical.com>
Content-Type: text/plain; charset=utf-8
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

Dne 09. 12. 20 v 13:43 Hui Wang napsal(a):
> After we change sth in the userspace audio stack like alsa-ucm or
> pulseaudio, we want to perform remote audio auto test to verify if the
> change introduce the regression or not, some of the tests are about
> the defaut_sink/default_source or active_port switching, this needs
> the audio jack state to be changed to trigger the userspace's audio
> device switching.
> 
> So far, there is no software ways to change the audio jack state, this
> block the auto test.

I'm not convinced to pollute the kernel space with this code. You can use
LD_PRELOAD and simulate this via a shared library or the alsa-lib may be extended.

Also, the first patch can be omitted if you just create another
snd_jack_report() function for the user API and put the common code to the
static function in jack.c.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
