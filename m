Return-Path: <SRS0=dtPj=J7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04C1C433B4
	for <alsa-devel@archiver.kernel.org>; Tue,  4 May 2021 08:39:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1404611AE
	for <alsa-devel@archiver.kernel.org>; Tue,  4 May 2021 08:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1404611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C17121693;
	Tue,  4 May 2021 10:38:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C17121693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620117547;
	bh=Uh0mEHwEJv2IVl1bnf0xy51JZzOMez9HWPZSJlbQ5FA=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aeslkadOduDtAqz9vFoLnQqdNAj6kv3rMr/YwIB4/nT6fcarwUI3LC+gEHzGOezle
	 9rC0sP3HOBW8lWV5KfNYdPIDrJ5Id2RVpI0aSVSvbqec33WxjDX8l7QFHDEORJT0sA
	 nOqIRWeQiWXoAacsNEluQGyk50UJWnHu7FNMSISM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 22781F80114;
	Tue,  4 May 2021 10:38:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DFA1DF8021C; Tue,  4 May 2021 10:38:15 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF525F80114
 for <alsa-devel@alsa-project.org>; Tue,  4 May 2021 10:38:04 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 5DC81A003F;
 Tue,  4 May 2021 10:38:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 5DC81A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1620117484; bh=Oqx6vpYCYvy7QS/Ac+/WoGlm98eIVvqqh2CJgsaDSeU=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=KsNkr4+Vd3KwGvh+o/W3pdACVIN0wdAOJfcbewfJjzIDEZZF4G1ErWp9jsCYmhPrb
 bWmsrLBwO75FsNxCnUG90E1Q4L21E7QEFZ9F+B4zRw9J3G+1g/syUIEHvcjiCnMf7m
 vCrxhcy4RFtaGT4aY3HUXv7vr35xyT6ilODT+QU0=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Tue,  4 May 2021 10:38:02 +0200 (CEST)
Subject: Re: [PATCH alsa-lib] ucm: Fix sysw sequence command not working when
 requesting to ignore errors
To: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
References: <20210503205244.167473-1-hdegoede@redhat.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <485753fc-0f76-f2ea-fb6d-bcc599a6ca42@perex.cz>
Date: Tue, 4 May 2021 10:38:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210503205244.167473-1-hdegoede@redhat.com>
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

Dne 03. 05. 21 v 22:52 Hans de Goede napsal(a):
> When the user requests to ignore sysfs write errors by prefixing
> the path with a '-' then we need to skip the '-' when building the
> actual path otherwise the write will never work.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thank you. Applied.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
