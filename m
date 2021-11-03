Return-Path: <SRS0=wMeK=PW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F883C433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Nov 2021 08:51:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94C4861101
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Nov 2021 08:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 94C4861101
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 425B7167D;
	Wed,  3 Nov 2021 09:51:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 425B7167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635929510;
	bh=14BxQJppbB95/FcOcWvBM/XfaYYwcFG5afhbyyT+phc=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UemfXVgRCf7fM02jv9NmqS3Z5ZUUPoxBCmGNVVQAb3i75ThuLvbc+KVNULw5h4ZGx
	 zz0oo4Mq3k/Ze4VU5l6y8c1TROYrU5QV2p7JJhH8PZGNpEgPf6L5CirwxWBLqrUhzd
	 Ct1gaiNGuVqCFVCuys/WqmJDoienYcTMk8EnX49Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9B66DF80269;
	Wed,  3 Nov 2021 09:50:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F1CA3F8026A; Wed,  3 Nov 2021 09:50:57 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 68978F80224
 for <alsa-devel@alsa-project.org>; Wed,  3 Nov 2021 09:50:50 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id D48ABA003F;
 Wed,  3 Nov 2021 09:50:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz D48ABA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1635929449; bh=vFDLdnkcHsfk2/QTntSCR/dfoDKCHLwuRZx4pBby7YA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=N8CokAGHnvJ7JSUcHrunu04N62GiSOSzsmmM6fgknTNI8sN6oAEGb/4xYRLI8gbmB
 FhVYmFlM5+CBGg3wNe94fD7RKU95mcLkhRDvt40V2ITK/x5pZwg1VkhB05JlaG3C8A
 4waT4ejxQEPM72d0+rQX9aKAbMWlZ+CmrcSKaKdg=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed,  3 Nov 2021 09:50:40 +0100 (CET)
Message-ID: <8a00ea68-4859-fbcc-6292-909a66b0a188@perex.cz>
Date: Wed, 3 Nov 2021 09:50:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 0/4] Fix kcontrol put callback in Tegra drivers
Content-Language: en-US
To: Sameer Pujar <spujar@nvidia.com>, broonie@kernel.org,
 lgirdwood@gmail.com, tiwai@suse.com
References: <1635915897-32313-1-git-send-email-spujar@nvidia.com>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <1635915897-32313-1-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
 thierry.reding@gmail.com, linux-kernel@vger.kernel.org, jonathanh@nvidia.com
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

On 03. 11. 21 6:04, Sameer Pujar wrote:
> This series fixes kcontrol put callback in some of the Tegra drivers
> which are used on platforms based on Tegra210 and later. The callback
> is expected to return 1 whenever the HW update is done.

The logic is a little bit another. The 1 means change, so you should compare 
the register / cached value and return 1 only when a different value is set. 
Your implementation invokes the change events for duplicate updates.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
