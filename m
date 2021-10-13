Return-Path: <SRS0=EWQz=PB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C76CC433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Oct 2021 11:54:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 502946109E
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Oct 2021 11:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 502946109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4D13E1657;
	Wed, 13 Oct 2021 13:53:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4D13E1657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634126086;
	bh=+XpSSz7kfx9cOskxY+plUzpobe3gcXW9kKCHWBnerVM=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XT30miotoSlodhHZjb0su58jHc5nZ+hNMcVWGVISoYm5gHEv5mx0Hcsbxx+emOzG2
	 XiMJ9H3rPdhGgpwDXKNcwDFYBg6Vew5esJkpZpDAdQID2qP3ou2ubajZDQXLzjwHFL
	 L1Hr+Km3/klIOW4RJ5rNkdtIKSsy5UMVfliRF0yc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E7906F8025B;
	Wed, 13 Oct 2021 13:53:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1E5DEF80269; Wed, 13 Oct 2021 13:53:54 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D41CDF80088
 for <alsa-devel@alsa-project.org>; Wed, 13 Oct 2021 13:53:46 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 6BD27A0040;
 Wed, 13 Oct 2021 13:53:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 6BD27A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1634126026; bh=3CILYcV1hXTNSlAKDNYVDtKFjT1QSQT7SeDZBjw/4lM=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=wMuinWb3bniXFtGyQNXoliJ/7Mgd438PRhdS66onSdKYtDPTXXYjxCiTzzIeNNgn9
 fi3shVqUoVGP15x9AafXOinvYbxoDY/+cB2Aa3tZREw2+NPLUoj+m0LkCIiNAzw9za
 c2zkQSsHxgZBfMrNxvYi/f+WbGxWy9aQbMmgdmPA=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed, 13 Oct 2021 13:53:44 +0200 (CEST)
Message-ID: <9be0ffa0-ac67-5c22-b1b2-3853097317ca@perex.cz>
Date: Wed, 13 Oct 2021 13:53:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v3] alsaloop: added option prateshift for PLAYSHIFT ctl
 elem used in PLAYSHIFT
Content-Language: en-US
To: Pavel Hofman <pavel.hofman@ivitera.com>, alsa-devel@alsa-project.org
References: <20211013103343.40522-1-pavel.hofman@ivitera.com>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20211013103343.40522-1-pavel.hofman@ivitera.com>
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

On 13. 10. 21 12:33, Pavel Hofman wrote:
> If snd-aloop device is on playback side, the required sync mode is
> PLAYSHIFT. That means Loopback ctl elem "PCM Rate Shift 100000" of the
> corresponding capture side of the Loopback pipe must be controlled (by
> a reciprocal).

Applied. Thank you.

					Jaroslav

--
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
