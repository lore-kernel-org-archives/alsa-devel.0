Return-Path: <SRS0=lFLu=3S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AC6C33CB2
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jan 2020 11:56:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11D0620720
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jan 2020 11:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HaWGvziu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="F8v3etRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D0620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 64B971663;
	Wed, 29 Jan 2020 12:38:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 64B971663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580297982;
	bh=MjL6NRHBTcjcRSemZiPhKaFNybd4U3D3B3JPAysYIT0=;
	h=To:References:From:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HaWGvziuOTjEE/++cHDkA+wOabYFKlgER0qQBBVTiRoTIm5Y+9E8AbvKgpDaTWeEf
	 3RsHCGIZgwx+SpPw1ep7lxvoanZU1CKk5yeEOjf5b91m1HNGVOREJtl3dTwlEVzaJL
	 Rvot/6+xJzBXX/F9YBii9PPcZ8PxWBXzYSRtTFsY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E5E0AF80218;
	Wed, 29 Jan 2020 12:38:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 50B2AF8021E; Wed, 29 Jan 2020 12:38:50 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C978CF80123
 for <alsa-devel@alsa-project.org>; Wed, 29 Jan 2020 12:38:47 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id D70BDA003F;
 Wed, 29 Jan 2020 12:38:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz D70BDA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1580297926; bh=mZZ+8Dg0Tv8AKuGR4JAK9xBSsa9BhD8yUAbb+1ugQmI=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=F8v3etRijNuJyO7CupKX1Cd4RsO+FpzpZvhoIWgEZWs5VcHnXnqn45rXhW6lmoNF2
 idmiN3AOOoiKORSgLnxeY+oTUQwhk2JZd3rVdAhIvP5shnBHhXJ6ouNBMV54TRYs1f
 Tu375aK2+7wDurP96VRkUf65RPhiLdZn5+ITKhyM=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed, 29 Jan 2020 12:38:44 +0100 (CET)
To: Pedro Costa <p.simoes.costa@gmail.com>, alsa-devel@alsa-project.org
References: <719056d4-aa45-8186-697c-76c1e89492ce@gmail.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <c749eb6a-4be7-5a90-c8d1-ec51307c1996@perex.cz>
Date: Wed, 29 Jan 2020 12:38:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <719056d4-aa45-8186-697c-76c1e89492ce@gmail.com>
Content-Language: en-US
Subject: Re: [alsa-devel] issue with alsa lib (ucm vs ucm2 folders?)
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

Dne 28. 01. 20 v 12:49 Pedro Costa napsal(a):
> Dear all,
> 
> My apologies in advance for a very non-technical feedback from a non-expert.
> 
> I was unable to get sound output after updating alsa-lib on my Manjaro
> Linux system. I managed to get it working after downgrading it to
> version 1.1.9.2. It seems that I faced the same problem as reported here:
> 
> https://bbs.archlinux.org/viewtopic.php?id=251113
> 
> You may already be aware of the issue, but just in case I would like be
> sure that you are!

Thanks. I am working on this. Use the older ucm configuration in the meantime. 
It should work.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
