Return-Path: <SRS0=P70v=YX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315EECA9ECB
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Oct 2019 21:51:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31DC320856
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Oct 2019 21:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JZAO3ODf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31DC320856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F1E0B2122;
	Wed, 30 Oct 2019 22:50:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F1E0B2122
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572472287;
	bh=TN4048LKhJlrnQjzuN3R9FOnBBmbUTcqteYqOQbNpeo=;
	h=From:To:References:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JZAO3ODfKx7NHvwg6iuMBL82CiDYN3gy8diw4Notoj6zOL3vC0wXOs4R+SjzC8TIK
	 mrzL7dQfvnz9xjJftbTiQzGghn6KNO48JGoXt0q1c+JgCFXxgh5HyZlUua9Smm35lH
	 Dkq1hw0ZZGkiBGAtIKeMjdQ9gjnh+dnjjIACaE/E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 79F2BF802BD;
	Wed, 30 Oct 2019 22:50:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9D736F80361; Wed, 30 Oct 2019 22:50:34 +0100 (CET)
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr
 [80.12.242.130])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2979FF8015A
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2019 22:50:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2979FF8015A
Received: from belgarion ([90.55.204.252]) by mwinf5d15 with ME
 id KxqV210015TFNlm03xqVLl; Wed, 30 Oct 2019 22:50:31 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 30 Oct 2019 22:50:31 +0100
X-ME-IP: 90.55.204.252
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
References: <87a79nqnkd.fsf@belgarion.home>
 <20191028224933.GF31391@ediswmail.ad.cirrus.com>
X-URL: http://belgarath.falguerolles.org/
Date: Wed, 30 Oct 2019 22:50:29 +0100
In-Reply-To: <20191028224933.GF31391@ediswmail.ad.cirrus.com> (Charles
 Keepax's message of "Mon, 28 Oct 2019 22:49:33 +0000")
Message-ID: <87sgn9lx7e.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Cc: patches@opensource.cirrus.com,
 Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] wm9713 regression on pxa platforms
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

Charles Keepax <ckeepax@opensource.cirrus.com> writes:

> {"Mic B Pre Amp", NULL, "Mic B Source"},
> {"Mic B Source", "MPB", "MIC2B"},
That fixes it on my side.
>
> I am travelling this week, and would need to do a bit more
> datasheet diving to be sure. But be worth checking if that fixes
> it and I can fire out a real patch start of next week.
Ok, once you're back, you can added my :
Tested-by: Robert Jarzmik <robert.jarzmik.fr>

Cheers.

--
Robert
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
