Return-Path: <SRS0=6Zlx=AD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D587AC433E4
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 12:34:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60C3D20716
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 12:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IR/alt9y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cg7/4rIq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C3D20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C9A3616B5;
	Mon, 22 Jun 2020 14:33:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C9A3616B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592829253;
	bh=HKucR3qMyjkGIuv/CEcWoDelkdm9iYNzcU+Zrzv+ESM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IR/alt9yl1zEaGY4CCqWnYzxPQOSYHk7xhYGoNSTFYHHUsNaClthf0UiEZ+czYQI5
	 CU/biMficw06uNCvfNqpnzRl913F44vaGbbsB+2EoD9VBsmoXv+P5ROSVtAkaa3js6
	 J/YE/UHCl8IgkoUfvpwb4QriP0DRDEPoQR5E5c4Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 90DB3F801DB;
	Mon, 22 Jun 2020 14:32:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EF3FBF8015B; Mon, 22 Jun 2020 14:31:42 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8CFC6F8010D
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2020 14:31:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8CFC6F8010D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="cg7/4rIq"
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C8167206BE;
 Mon, 22 Jun 2020 12:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592829099;
 bh=HKucR3qMyjkGIuv/CEcWoDelkdm9iYNzcU+Zrzv+ESM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cg7/4rIqO7T+pOhTZK0nEHsZnkTKN8Pzg7CR/klS/Xb9Jmz6dnbVhVYsV2E2iDE75
 R5JWrgv+QRmXHbRgBkgqrSYpgkQmYVKLnGZpCEFOYVRG9OKNEyhtXdYSe4oRGeojS9
 roaskBVIIb3HR4bCpAukPCXu83+M9Jc6+AmSMiWE=
Date: Mon, 22 Jun 2020 08:31:37 -0400
From: Sasha Levin <sashal@kernel.org>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.7 130/388] ASoC: Fix wrong dependency of da7210
 and wm8983
Message-ID: <20200622123137.GG1931@sasha-vm>
References: <20200618010805.600873-1-sashal@kernel.org>
 <20200618010805.600873-130-sashal@kernel.org>
 <20200618110258.GD5789@sirena.org.uk>
 <20200621233453.GB1931@sasha-vm>
 <20200622101830.GA4560@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200622101830.GA4560@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Wei Li <liwei391@huawei.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
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

On Mon, Jun 22, 2020 at 11:18:30AM +0100, Mark Brown wrote:
>On Sun, Jun 21, 2020 at 07:34:53PM -0400, Sasha Levin wrote:
>> On Thu, Jun 18, 2020 at 12:02:58PM +0100, Mark Brown wrote:
>
>> > This is purely about build testing, are you sure this is stable
>> > material?
>
>> Is this not something that can happen in practice?
>
>Not outside of build testing.

Okay, I'll drop it.

-- 
Thanks,
Sasha
