Return-Path: <SRS0=phwE=HF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DCBC433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Feb 2021 16:40:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD5CF64E50
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Feb 2021 16:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5CF64E50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F2E216FD;
	Wed,  3 Feb 2021 17:39:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F2E216FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612370410;
	bh=zQtOgbB7m+FsmzB3eiYRAsuKyqGMXV7NH2ngyTbUPaU=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B4DJ1T6vNtyEAhxnruoG+pQM968zbsSDg02ok8apkhe4S1gc59u5LdNYDOq7cdfae
	 M/RZDMiKWjKO78jkYBR5cdtko3I3iDMT4bUiquV5i7y31njKn09pJdkG9ajDZC0oEE
	 T1zSJrx2R9PMXI+TBHSYkec9K8EIEK3AXRoFBbto=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EA658F80156;
	Wed,  3 Feb 2021 17:39:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 77D4EF8015A; Wed,  3 Feb 2021 17:39:18 +0100 (CET)
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 30BEBF80154
 for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2021 17:39:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 30BEBF80154
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="OBHf5LoD"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B601ad1af0000>; Wed, 03 Feb 2021 08:39:11 -0800
Received: from [10.25.102.154] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 3 Feb
 2021 16:39:07 +0000
Subject: Re: Re: [PATCH 1/2] ASoC: audio-graph: Export graph_remove() function
To: Mark Brown <broonie@kernel.org>
References: <1612368575-25991-1-git-send-email-spujar@nvidia.com>
 <1612368575-25991-2-git-send-email-spujar@nvidia.com>
 <20210203161951.GG4880@sirena.org.uk>
From: Sameer Pujar <spujar@nvidia.com>
Message-ID: <64b65aaf-9971-e071-5d52-02286fe0cacc@nvidia.com>
Date: Wed, 3 Feb 2021 22:09:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210203161951.GG4880@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1612370351; bh=zQtOgbB7m+FsmzB3eiYRAsuKyqGMXV7NH2ngyTbUPaU=;
 h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
 MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 Content-Language:X-Originating-IP:X-ClientProxiedBy;
 b=OBHf5LoDGB/RlsY1s91yGCrRul3cssQmvkcJ0iSmrPdKXCagz9WdoHVssV1AB+TNH
 B/9yzmTSfJ0Z5u7D5ajEps+e6BM0zQyN0tgEGpCAaYqfj7eUG6trxM06w8B2NBudXA
 kfnkDFOR+dhi9h0Keq+U1Xw7qxo39xnN3CrNqRz9Nb9gx5182jg8G7SJQ7+1NuGZxq
 9LN92l1jjRasxlLWpNR0fBSAxuW8eT5JWm8kcNISi8kRuQC9HaHouIVXEVUR4sH5Jo
 QfLoUw0FH4R5nOR4zToO8DxTDtIhTZbovaarMTLyclnsdg9oV/XSuWBgAzUs59rmQo
 0qj/aS3UWakHA==
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com, sharadg@nvidia.com,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org
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



On 2/3/2021 9:49 PM, Mark Brown wrote:
> On Wed, Feb 03, 2021 at 09:39:34PM +0530, Sameer Pujar wrote:
>
>> +int graph_remove(struct platform_device *pdev);
> I think this needs better namespacing if it's going to be exported.

audio_graph_remove() can be a better choice?
