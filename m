Return-Path: <SRS0=G+7e=EJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BD3C388F2
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 06:11:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABBA92227F
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 06:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CZ9CVtEx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="pGLNxA/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABBA92227F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E94701743;
	Tue,  3 Nov 2020 07:10:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E94701743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604383862;
	bh=Kt5ReNuEC/rMDljs+qABItHrQ0K29W2bd4ESZVCRebQ=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CZ9CVtExGw6b9LFHngxkJgQ4VlvSIxSBqPpaP42WT4jGa/mBlrlSvXklyQDYbxIfZ
	 uLRlqFdu4q4gAZLw2b8luOXHI/Q0ZhuvL6P0R75ig9wamkhZwnGAomzUvRLRDYUbBr
	 ToOoGbUUagiCjT2U0Yh8xDLw+i9150aXQFXwUzSQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2DD20F8015A;
	Tue,  3 Nov 2020 07:10:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9B3CCF80171; Tue,  3 Nov 2020 07:10:08 +0100 (CET)
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4773AF8015A
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2020 07:10:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4773AF8015A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="pGLNxA/D"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fa0f4380001>; Mon, 02 Nov 2020 22:10:00 -0800
Received: from [10.25.99.190] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Nov
 2020 06:09:52 +0000
Subject: Re: [PATCH] ASoC: tegra: remove unneeded semicolon
To: <trix@redhat.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
 <perex@perex.cz>, <tiwai@suse.com>, <thierry.reding@gmail.com>,
 <jonathanh@nvidia.com>
References: <20201101172412.2306144-1-trix@redhat.com>
From: Sameer Pujar <spujar@nvidia.com>
Message-ID: <353e4c77-7166-071a-b1d9-2c1e0b2548a4@nvidia.com>
Date: Tue, 3 Nov 2020 11:39:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201101172412.2306144-1-trix@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1604383800; bh=Kt5ReNuEC/rMDljs+qABItHrQ0K29W2bd4ESZVCRebQ=;
 h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
 MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 Content-Language:X-Originating-IP:X-ClientProxiedBy;
 b=pGLNxA/DnK69oH1y9GE8RkfmH9QWFqusHNw+jJ1J9boBX8FgDTZVbfIgbAtJ8SOFo
 MiT4kiQf+9BQVAm5CAnA6m7rskFLXkQcA+oP0UhVjeVgQzJbD3rsIsa6aebqXb4iXg
 L0vKO1u5c6ASyyO8h/tcGlIjVdSKsfgtXQlmqxy1cNwYRrdjptU0xlHOniZ4n0ea4M
 TkBJt6ZduB3JQIg/O01z9vRPfSjGfPiIZmtNRay12Q9CVpK65CZq2B6uWktbCXyejg
 ps31j655soRrO5xzWWI5F05NuIFQ5RvvwMFVjxdL81I62st5t9yR3JUxtF7rBkfUfk
 /z4TBrmF3vH4Q==
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

Hi Tom,

> From: Tom Rix <trix@redhat.com>
>
> A semicolon is not needed after a switch statement.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---

Acked-by: Sameer Pujar <spujar@nvidia.com>

Thanks for the update.
