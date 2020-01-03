Return-Path: <SRS0=XflM=2Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0B6C2D0C2
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 18:16:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44A5F22522
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 18:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZfvZO1me";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="UjAZxMtd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A5F22522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 210661782;
	Fri,  3 Jan 2020 19:15:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 210661782
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578075369;
	bh=VfYW9OmtFoJb3wEdGQd/0YFQ7nQEKNeB16MQ44nCN0I=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZfvZO1meWDfshsfDMC+aDAh9pF71GAhQhMUt1RiwCqL7qBm4CMKIhLSvG6HfbCKbr
	 KnKLwq6ADvmxt1h2UoJ6rXxIAgIydoefFx4WADkLd1b9d3ambgtWS8L0TKTmnBodPu
	 ZFbB5XgGyBlpJXX11x9sGM5HE4BQYlgIPWcbZWg8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 99518F8015C;
	Fri,  3 Jan 2020 19:15:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E29C0F8015D; Fri,  3 Jan 2020 19:15:17 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B0A4BF800FE
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 19:15:14 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 9E25BA003F;
 Fri,  3 Jan 2020 19:15:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 9E25BA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1578075313; bh=hQiiSETa/BhafPxdPk2EJRi3YZI9ITOtZh17M1EpmKA=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=UjAZxMtd0k9yo/5gPYdp/QAIl3zjBMu5Su7dX9yT8VeaIHehhBKRKqkHMOLn6tXk/
 knM7n53Z1LXOfqHJG3csGw6AsGqRPViu8U/r3Ce1zFgc/Ysk+SMv7+5+rBz4Pl7Hr5
 0lqX/ZwjjyRkkyuLhlkxJzukDPcKKtbseeymMKEo=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Fri,  3 Jan 2020 19:15:09 +0100 (CET)
To: David Ward <david.ward@ll.mit.edu>, Takashi Iwai <tiwai@suse.de>,
 alsa-devel@alsa-project.org
References: <1578074751-31462-1-git-send-email-david.ward@ll.mit.edu>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <18135209-abc9-ca1c-84e0-8ac3e75caaf1@perex.cz>
Date: Fri, 3 Jan 2020 19:15:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1578074751-31462-1-git-send-email-david.ward@ll.mit.edu>
Content-Language: en-US
Cc: =?UTF-8?Q?Diego_Petten=c3=b2?= <flameeyes@gmail.com>
Subject: Re: [alsa-devel] [PATCH alsa-lib,
 alsa-plugins] Update the attributes.m4 macro file from xine
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

Dne 03. 01. 20 v 19:05 David Ward napsal(a):
> This file was imported from the xine project. Update it to the current
> revision, which resolves the "no AC_LANG_SOURCE call detected in body"
> warnings with Autoconf 2.68 or later.

Applied. Thanks.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
