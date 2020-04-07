Return-Path: <SRS0=QmEo=5X=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD8AC2BA2B
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:32:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA3DB2072A
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sU15Iqe8";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="NX1SMakU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3DB2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 340C8166D;
	Tue,  7 Apr 2020 16:31:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 340C8166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586269927;
	bh=ZzdCILTN9bsf7l4OVJUuDn7daBMP6lkVmAnJwGE8Mc0=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sU15Iqe8FGMap/AEET9alaGdgaJYRKwAoZYnxfhn9KP9lA1tUBlgTZdgUtfE623F3
	 /AzmWQnxFuijdelJI1RdYXGNravY0DaZIXUaHZlORypAGGqy+Lxmz/URJyFaM4J+LY
	 IsxE1y9YZ8Yc5M3XlPILpg8hbrRFA0eFV6z1NiDk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D8D96F80213;
	Tue,  7 Apr 2020 16:30:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74A0EF80216; Tue,  7 Apr 2020 16:30:56 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BFA2EF8011B
 for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2020 16:30:53 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 7E364A0040;
 Tue,  7 Apr 2020 16:30:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 7E364A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1586269850; bh=A1CFJ2CNDVVBt3yn+QHJ+uG6jCdSanTakN77Cz01Bz0=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=NX1SMakUMG8W+7B1/txH0tO6KTrYmf+nU+dYSAwS++XoT5QdfjL1wq5yI8T+ttt9b
 PGJUtIS42EJACcnE4CwujHqk/mRV530JOrtOPqCou/AGTXPFnUxVfiNatWpq+ZXnrk
 9nhWxLGaNmw9rdAZGW5mGGJaDzb48mY46UzqiZ+k=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Tue,  7 Apr 2020 16:30:48 +0200 (CEST)
Subject: Re: [PATCH 0/2] ALSA: Fix for bad ctl access patterns
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
References: <20200407084402.25589-1-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <584b4afd-ea44-a89b-9cdb-e53876cc8a69@perex.cz>
Date: Tue, 7 Apr 2020 16:30:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200407084402.25589-1-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
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

Dne 07. 04. 20 v 10:44 Takashi Iwai napsal(a):
> Hi,
> 
> the recently introduced ctl access validator succeessfully caught some
> real issues.  Here are some fixes.

Thanks Takashi for the fixes. For both

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

> 
> 
> Takashi
> 
> ===
> 
> Takashi Iwai (2):
>    ALSA: hda: Fix potential access overflow in beep helper
>    ALSA: ice1724: Fix invalid access for enumerated ctl items
> 
>   sound/pci/hda/hda_beep.c         | 6 +++++-
>   sound/pci/ice1712/prodigy_hifi.c | 4 ++--
>   2 files changed, 7 insertions(+), 3 deletions(-)
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
