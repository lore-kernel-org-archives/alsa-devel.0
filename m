Return-Path: <SRS0=kaWB=7O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD58C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jun 2020 07:55:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC6732074B
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jun 2020 07:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HHsEDh0q";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="baiYMpCU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6732074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 63E9616E0;
	Mon,  1 Jun 2020 09:54:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 63E9616E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590998098;
	bh=PhFxhX3lf/OMjws9ta/kT5iSLLfDxPGjb/ImxvewNCk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HHsEDh0q6KZIwCYLdd3y9W+4byduNcoWhGMZ1G+B0YU5CtJgB2/30vBKY23VKlLK5
	 IKUBk6Vt0T6nS+I9sbSNCv0V+t02OG9lfPd9g2oPA26Hg7Mn6juA7ZCH3nbd9aUSPs
	 SSIfodPXx3B1OzWM+D1MmLlxv0nbc2dwbI6VgF0s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C760CF801EC;
	Mon,  1 Jun 2020 09:54:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2FED5F801ED; Mon,  1 Jun 2020 09:54:06 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C7004F800B8
 for <alsa-devel@alsa-project.org>; Mon,  1 Jun 2020 09:53:59 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id B86A7A003F;
 Mon,  1 Jun 2020 09:53:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz B86A7A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1590998036; bh=bplBIkE5RpWhQs3R/Saw2iXEni30iQX35TtQhmbH91s=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
 b=baiYMpCUA1AGHbLwzB8/iKfwFMTBfA7THf1iO/532lPYWFX3bB+dDECEHAHi/j2pS
 b2e4Aq0uvOumqngj3j6SLn83XIGrv/68YY2o3d3dLArcvcX6DALpxU7WT3+pdXwKjW
 hy7P2MgDX5K/llF7B7xUAFBRYoWMWXfmm9V8JcuI=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon,  1 Jun 2020 09:53:53 +0200 (CEST)
Subject: Re: SOF 1.5 release on FTP server
To: Paul Dann <pdgiddie@gmail.com>, alsa-devel@alsa-project.org
References: <CALZj-VpLECyDaBeHcowTnCcufLVaPyr7Xxii+PbkrwGn9kYU+w@mail.gmail.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <bc8420df-3fbe-2d7c-3c3a-dcf7455eeca8@perex.cz>
Date: Mon, 1 Jun 2020 09:53:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CALZj-VpLECyDaBeHcowTnCcufLVaPyr7Xxii+PbkrwGn9kYU+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Pierre-louis Bossart <pierre-louis.bossart@linux.intel.com>
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

Dne 01. 06. 20 v 9:24 Paul Dann napsal(a):
> Hi there,
> 
> I'm eagerly awaiting the sof-firmware 1.5 builds to land on your server:
> 
> https://www.alsa-project.org/files/pub/misc/sof/
> 
> Archlinux builds its sof-firmware package from there. SOF 1.5 was
> tagged on the 27th April on Github. I'm wondering if there are plans
> to release a build for this version to the same place?

I don't plan any new release on ALSA FTP. Intel releases signed firmware files 
on github now:

https://github.com/thesofproject/sof-bin

Unfortunately, 1.5 version has serious bug in the topology files, so I don't 
recommend to use it unless you compile the updated topology files yourself:

https://github.com/thesofproject/sof/issues/2937

					Jaroslav

> 
> Many thanks,
> Paul
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
