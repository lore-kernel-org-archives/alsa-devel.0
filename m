Return-Path: <SRS0=/iiV=G2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8162AC433DB
	for <alsa-devel@archiver.kernel.org>; Sat, 23 Jan 2021 10:26:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4404C22D5A
	for <alsa-devel@archiver.kernel.org>; Sat, 23 Jan 2021 10:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4404C22D5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE4931AF4;
	Sat, 23 Jan 2021 11:25:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE4931AF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611397584;
	bh=8STbseA5K7PDYF+59FkGCCt5NYrqktQnmyTAaIwvSKE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lTZYNUqajSLadekEyEXJLEcmy3sqVYGKjkPRbbzEkxR+U+kaLxRhInbx6pO62Y2c9
	 hjefTUM2NfxZGKj5SWTJKpYEGioZuzMJGiDIPJkFB3faTU4Ug7S9GAX9cqGor5ttj8
	 s144O7j0Obl0aTUkIhlmKRl12qkrwfauCAnx4j1A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6DB0BF80255;
	Sat, 23 Jan 2021 11:25:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E4614F80257; Sat, 23 Jan 2021 11:25:29 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B350DF800FD
 for <alsa-devel@alsa-project.org>; Sat, 23 Jan 2021 11:25:23 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id C8CD4A003F;
 Sat, 23 Jan 2021 11:25:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz C8CD4A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1611397517; bh=bY/1DBa6ZgP1SvwIu0nE06FI6yQuEJhlJXjXPiY9uLY=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=x67tZesjO1R+3VbHU3x+ObffmlwufhUXcgI4b8FMMWGBoHh/tZ4AIdBf5ypzhPzRZ
 yFc9ZGlC85GGf8Fd43iDobzZ5L8dCLRQa01q1jw28nmtCO0qFjiU0wpKu0lV6G34W+
 bvGTX2pZvpxXZMLar2O28/vghwalwq8v7/EwqNJc=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Sat, 23 Jan 2021 11:25:14 +0100 (CET)
Subject: Re: [PATCH] ALSA: control: expand limitation on the number of
 user-defined control element set per card
To: Takashi Iwai <tiwai@suse.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
References: <20210122082032.103066-1-o-takashi@sakamocchi.jp>
 <s5h35yt83uf.wl-tiwai@suse.de> <20210123031025.GA118864@workstation>
 <s5h8s8k6mtf.wl-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <a97f7a62-905d-b479-d564-71fbe6bcdc89@perex.cz>
Date: Sat, 23 Jan 2021 11:25:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <s5h8s8k6mtf.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org
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

Dne 23. 01. 21 v 10:10 Takashi Iwai napsal(a):

> OTOH, imagine that we cap the memory consumption to 16MB instead of
> limiting only the MAX_USER_CONTROLS.  This lets user still allow to
> allocate more elements with smaller number of items (that is the
> common use case).  In this way, we don't take a risk of higher memory
> consumption while user can deploy the user elements more flexibly.

This sounds really reasonable!

				Thanks,
					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
