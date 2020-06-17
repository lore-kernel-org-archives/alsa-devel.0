Return-Path: <SRS0=fhRg=76=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE6BC433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2020 11:16:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0418B20734
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2020 11:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XVjtMPyr";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="S3z6IxDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0418B20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 970481681;
	Wed, 17 Jun 2020 13:15:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 970481681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592392604;
	bh=wublgg1M8Ufv0oAdmPKOHTv9Rd7Z8XvKtlsvZwVrYSg=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XVjtMPyrH46GVFDyXmhVB+PkXVkaD3kljftpqUQnciU5yFs516RsVB8eesOck5ztr
	 VkaEuFvzZlNz9R4NVfaiB9A6imZj4cDnt9U/eSF2OTkeyiML8BwQYr1c11qdljkQfC
	 y0307jd/GdEiTUkYrTEuZOXhrb0+TSqwS78wMFrw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 48553F802A2;
	Wed, 17 Jun 2020 13:15:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DAFAEF802A7; Wed, 17 Jun 2020 13:15:41 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 69D66F8025F
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2020 13:15:34 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id C63E5A0040;
 Wed, 17 Jun 2020 13:15:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz C63E5A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1592392532; bh=uDyN6Lk1SHIFqJopH8SGJNha6o7zYjfjv2bowzNUUcA=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
 b=S3z6IxDVxb3s+exNlnmBBOgxvUUugjAThq59U+u5K6pKeJ6ge8eyalfZN+94vtHZZ
 iVN7jRtlAnKGzEo3uhR8YlGiEOfVqi8LnCoEqwSVyzYF5Kw4RCLGXgX3QXQoAfPq+O
 rwHnSfrXzpSs2Ci2fCqZngB4Pk30rFStdjZr/yX8=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed, 17 Jun 2020 13:15:30 +0200 (CEST)
Subject: Re: Move ownership for repositories in Github related to
 gobject-introspection
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
References: <20200617080114.GA265611@workstation>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <26bcc126-6688-5996-b6ad-3288bd2facd8@perex.cz>
Date: Wed, 17 Jun 2020 13:15:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200617080114.GA265611@workstation>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: ALSA development <alsa-devel@alsa-project.org>
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

Dne 17. 06. 20 v 10:01 Takashi Sakamoto napsal(a):
> Hi Jaroslav,
> 
> Now I'm going to prepare for official release of alsa-gobject v0.1.0.
> 
> At the same time, Rust binding is also OK to be released. Currently It's in
> my private repository[1] but I think it better to put under alsa-project
> project account in Github.
> 
> Github supports transferring ownership, and this time I'd like to utilize the
> feature if you don't mind it. After transferring. some arrangement for the
> repository are perhaps required; e.g. to put it to 'gobject-introspection'
> team[3]. Would I ask it to you?
> 
> Additionally, I'd like to move repositories for libhinawa[4][5][6] as well,
> which is required to make up control service in user space for devices
> supported by ALSA firewire stack[7].

Hi,

   I have no objections against that proposal. I will try to configure the 
repositories when transferred to the alsa-project organization.

				Thanks,
					Jaroslav

> 
> [1] https://github.com/takaswie/alsa-gobject-rs/
> [2] https://help.github.com/en/github/administering-a-repository/transferring-a-repository
> [3] https://github.com/orgs/alsa-project/teams/gobject-introspection
> [4] https://github.com/takaswie/libhinawa
> [5] https://github.com/takaswie/libhinawa-docs
> [6] https://github.com/takaswie/hinawa-rs
> [7] https://mailman.alsa-project.org/pipermail/alsa-devel/2020-June/168550.html
> 
> Regards
> 
> Takashi Sakamoto
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
