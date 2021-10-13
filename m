Return-Path: <SRS0=EWQz=PB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EB2C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Oct 2021 12:06:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B574610E7
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Oct 2021 12:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8B574610E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9634A1612;
	Wed, 13 Oct 2021 14:05:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9634A1612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634126800;
	bh=OIQVX3Xp4OuMp2R9kkF35IthSzPYAAiZHIUd4W6MJoo=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZFzWi+YUCCSmz+HurdTjyEs/X3tGKJqLn5a4DBvz7JlQC/0/dH8VOWGNLyD7WlkWK
	 tevE3WBU2sD7oxV9jezC3Xt3QEWbPsX9Ps38z79PGvfrbY4M3VVLd1X8DHCwocPKBa
	 s8SxUa/0yxbjr7yYynE83l0MLl4CO+YbOzkTfwA0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 25609F8025B;
	Wed, 13 Oct 2021 14:05:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 15ED0F80269; Wed, 13 Oct 2021 14:05:48 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BA992F80088
 for <alsa-devel@alsa-project.org>; Wed, 13 Oct 2021 14:05:38 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 135BBA003F;
 Wed, 13 Oct 2021 14:05:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 135BBA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1634126738; bh=cDrrNyoFGsH2Gb4wjo8KaNC7LENACCXEVvggl0yyQYA=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=RrT6coEO0eg5UpyXTaGAijBdZFo1Hk9UJfAQrxJCvBgE6lnfFUFaIX2bGThxxQ7Bv
 NEx6CxJK7219lSIUhhKPicZ1C9iS4Rs2GNve+y9fo/j5ndvs9D5It0L0mE1ziK76vs
 Fjh+/ceH73LQ3Ul6jdL1S/lhYaQ9NvxZICaOUB50=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed, 13 Oct 2021 14:05:35 +0200 (CEST)
Message-ID: <56526958-994b-bffd-b19e-6d9e2fa49de4@perex.cz>
Date: Wed, 13 Oct 2021 14:05:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] alsaloop: fixed parsing value 'auto' of option 'sync'
Content-Language: en-US
To: Pavel Hofman <pavel.hofman@ivitera.com>, alsa-devel@alsa-project.org
References: <20211013120049.51047-1-pavel.hofman@ivitera.com>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20211013120049.51047-1-pavel.hofman@ivitera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 13. 10. 21 14:00, Pavel Hofman wrote:
> The value 'auto' was not checked which resulted in using
> SYNC_TYPE_NONE instead of SYNC_TYPE_AUTO.

Applied. Thank you.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
