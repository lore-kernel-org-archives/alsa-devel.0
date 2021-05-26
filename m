Return-Path: <SRS0=tEYa=KV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98555C4707F
	for <alsa-devel@archiver.kernel.org>; Wed, 26 May 2021 00:59:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4605461417
	for <alsa-devel@archiver.kernel.org>; Wed, 26 May 2021 00:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4605461417
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 061341713;
	Wed, 26 May 2021 02:58:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 061341713
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621990748;
	bh=kD8pmqfXMnZqFiWQiqQiliQE8WnhQTkQKe9ScqcbX4Y=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QqhFmxRD34Y7Ev5IoRn4ZjRx2t14X4Mi6UAN2dYR2U3JuBjmtiZT684gV+b7OiZqI
	 WXOEdOg+EAdxdENxDg0MxN9ps6rYvy+g1qkqDktd+7RLsq3x9W3piD22iL7aGlO2PH
	 hwiX3t7akanPUXC+x76XNh+d3asdCsL4TPv85ed4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 87AEAF800C9;
	Wed, 26 May 2021 02:58:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DF362F800CB; Wed, 26 May 2021 02:58:15 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 70C4FF800B6
 for <alsa-devel@alsa-project.org>; Wed, 26 May 2021 02:58:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 70C4FF800B6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="pMYDPyhx"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9AD38613FA;
 Wed, 26 May 2021 00:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621990684;
 bh=kD8pmqfXMnZqFiWQiqQiliQE8WnhQTkQKe9ScqcbX4Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pMYDPyhxL67F0uRMRNOOEP3Pbb9O9u9H9oWazON6OocViIQ37yms4U5UO+rRE4raP
 Yju2Y0a4jRkEnDiGjybrNTNGXeIKyHUROkjEfe+bolDK54j+p+U/vBIMIT0pujqYwT
 uhKnjZPTwxYRVxcL8vShPRQWXxMS88ulQ5qHo/virjAbQJNQgYEvuhDbknJzuxtLuo
 QjnOe3Tip5cFtI3uxpiwFvkfae247kOGWMHPgvxJpKB4gvvKLWQXCtgwnQMSozN1qc
 +UDXNdkDSMLw3gvovQCkXKbpB4+ifuNFGSgQDQT+3PkVaNbCJ6yRY4qAq3TLuA+L5r
 w71zQpgdu/i9A==
Date: Tue, 25 May 2021 20:58:03 -0400
From: Sasha Levin <sashal@kernel.org>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.10 29/62] Revert "ASoC: rt5645: fix a NULL
 pointer dereference"
Message-ID: <YK2dGw3IJdCNSVN0@sashalap>
References: <20210524144744.2497894-1-sashal@kernel.org>
 <20210524144744.2497894-29-sashal@kernel.org>
 <YK1zgS7FwtySdeCg@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YK1zgS7FwtySdeCg@sirena.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 alsa-devel@alsa-project.org, Kangjie Lu <kjlu@umn.edu>,
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

On Tue, May 25, 2021 at 11:00:33PM +0100, Mark Brown wrote:
>On Mon, May 24, 2021 at 10:47:10AM -0400, Sasha Levin wrote:
>
>> Lots of things seem to be still allocated here and must be properly
>> cleaned up if an error happens here.
>
>That's not true, the core already has cleanup for everything else
>(as the followup patch in your series identified, though it was a
>bit confused as to how).
>
>>  		RT5645_HWEQ_NUM, sizeof(struct rt5645_eq_param_s),
>>  		GFP_KERNEL);
>>
>> -	if (!rt5645->eq_param)
>> -		return -ENOMEM;
>> -
>
>Without the followup patch (which I don't think is suitable for
>stable) this will just remove error checking.  It's not likely to
>happen and hence make a difference but on the other hand it
>introduces a problem, especially when backported in isolation.

I'll drop this and the follow up patch, thanks.

-- 
Thanks,
Sasha
