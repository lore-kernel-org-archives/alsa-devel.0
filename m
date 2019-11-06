Return-Path: <SRS0=zQEr=Y6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F29C5DF62
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:29:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C17D217F5
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="H/35AUDC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="MVxj5ID/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C17D217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9F31284F;
	Wed,  6 Nov 2019 13:28:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9F31284F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573043355;
	bh=l8H4M8ndxGJoMWgQ2XXN2hq2J2k5FKB9NOQXOKPxAig=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H/35AUDCH3ltmXjoaQj69nQ5Q9AEBM39rbCnFuEMIUT94SsNVMrQyF74Lt7g8J5yc
	 A3mzp8IcSi45Sr6qPO0tBLinBq4HYgz0hFeIcKYnxOdYbzXyL6Newpwlb5IMM+zyOc
	 frcMT2dqzLE5gfXS1eiR/3Yfl/7YKv7TCRpYt5q4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 354D9F80321;
	Wed,  6 Nov 2019 13:28:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6D431F803D0; Wed,  6 Nov 2019 13:28:22 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A1C2F8015B
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2019 13:28:17 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 766C3A0040;
 Wed,  6 Nov 2019 13:28:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 766C3A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1573043297; bh=IAvgmvLN1bVjPFloPzLdTf6lQ5suKrYzr43+z/o8Y0g=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=MVxj5ID/8cPSRYERyGJuZt6n4Qzb+QqCgGFbGm0j3+6C0dj7i8CmjeMSieU1HG0jX
 JbRJ2ea4kRAcNOdGjh7zcwJk1DYZFLCqM8bamuenijNoOuSY9m+Ft6hmzHzAn7QI9Y
 OOr+TC33DrHDivUoSaAiLQvsjQDUDfgemEG1ChJE=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed,  6 Nov 2019 13:28:14 +0100 (CET)
To: Takashi Iwai <tiwai@suse.de>
References: <20191101115718.3092-1-perex@perex.cz>
 <s5hh83neq2x.wl-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <b0196eb1-9433-56fd-f5a5-07350caa3b23@perex.cz>
Date: Wed, 6 Nov 2019 13:28:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <s5hh83neq2x.wl-tiwai@suse.de>
Content-Language: en-US
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Kailang Yang <kailang@realtek.com>
Subject: Re: [alsa-devel] [PATCH] ALSA: hda - fix the Headset Mic Jack name
	for Realtek
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

Dne 01. 11. 19 v 13:30 Takashi Iwai napsal(a):
> On Fri, 01 Nov 2019 12:57:18 +0100,
> Jaroslav Kysela wrote:
>>
>> The HDA auto parser creates kcontrol 'Headset Mic Jack'. Use this
>> name also for the alc_fixup_headset_jack() function. It is necessary
>> to have common name for the user space like the UCM configs:
>>
>> https://github.com/alsa-project/alsa-ucm-conf/pull/5
> 
> Please make sure that this really doesn't break the existing device
> especially with PulseAudio.  I'll merge this once when it's confirmed
> that it still works as is after the change.

Just for the reference: Please, drop this patch. I mangled the names somehow 
(Headset / Headphone). The Headphone Jack names are not consistent, too. We 
are going to handle this in UCM (user space) rather than the driver side.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
