Return-Path: <SRS0=KW3j=BN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8693C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 15:57:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FACF2072A
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 15:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MXayqu/V";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="EfMIg6MX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FACF2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D09F81683;
	Mon,  3 Aug 2020 17:56:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D09F81683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596470268;
	bh=V83m2dJoBrjPRbwCiE1KtO7YZuTP51r4vsm9UrtohdU=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MXayqu/Vj5dVKojVC4IN9xRUd97WiYuFPzRA6VpWfOAUrl7oX9+cP6rnu06JyEkDN
	 Bc1SLF4VpWapgH7DapsWgHeEkaXKXg3D/kwZIwK+xKnGre7IacgvwHamXwFzcKlFN1
	 Ha2HJYU86hyrCoyed1Sk5UcPNOKs/DWWPupndFwo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BF901F8023E;
	Mon,  3 Aug 2020 17:55:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 35804F80249; Mon,  3 Aug 2020 17:55:35 +0200 (CEST)
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5DD94F80148
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2020 17:55:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5DD94F80148
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="EfMIg6MX"
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5f28335c0000>; Mon, 03 Aug 2020 08:55:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Mon, 03 Aug 2020 08:55:22 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Mon, 03 Aug 2020 08:55:22 -0700
Received: from [10.25.96.161] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 3 Aug
 2020 15:55:20 +0000
Subject: Re: [PATCH 0/5] ASoC: tegra: Fix compile warning with CONFIG_PM=n
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
References: <20200803141850.23713-1-tiwai@suse.de>
From: Sameer Pujar <spujar@nvidia.com>
Message-ID: <add3844d-cc65-29bf-fd90-42a01f9df426@nvidia.com>
Date: Mon, 3 Aug 2020 21:25:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200803141850.23713-1-tiwai@suse.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1596470108; bh=YahrkqjDZQw0U6IZ0T+qnx12xm5yp6t6kPqO3hN+LOs=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
 Content-Language;
 b=EfMIg6MXKW6U0QVr568AFvGmE8xTNWbp/iTh5FKPsa4qWpNX0bHmYVwvDEEs+vkG8
 /dBGfqvtcPuQbeYcT9Y1/nz4fvnM3QxXs2dxnnnfkn6mn91wJVQrboxT146r7EiEek
 8j9MXJEru9kytCF5G05ItgtZFZS/IkvkOFyrjfqK1ZmybuGOO+YDJ5bB/IM+JgIFPq
 qiqC//zRLtYAT4MdrK9GM8HqxyLFySpuCCw5g1DOGnIumE+MMcqMQNMUhZLlmisuVp
 M5k84QsyrmvqHPr64TT3lljjNDt6sWWS0Devfzg54RZiRbzzZKE9ZVLC+dXaeugGS7
 RwJwxdJM20Hjw==
Cc: alsa-devel@alsa-project.org
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


On 8/3/2020 7:48 PM, Takashi Iwai wrote:
> External email: Use caution opening links or attachments
>
>
> Hi,
>
> this is a trivial patch set to add the missing __maybe_unused for
> covering the compile warnings with CONFIG_PM=n.
>
>
> Takashi
>
> ===
>
> Takashi Iwai (5):
>    ASoC: tegra: tegra186_dspk: Fix compile warning with CONFIG_PM=n
>    ASoC: tegra: tegra210_admaif: Fix compile warning with CONFIG_PM=n
>    ASoC: tegra: tegra210_ahub: Fix compile warning with CONFIG_PM=n
>    ASoC: tegra: tegra210_dmic: Fix compile warning with CONFIG_PM=n
>    ASoC: tegra: tegra210_i2s: Fix compile warning with CONFIG_PM=n
>
>   sound/soc/tegra/tegra186_dspk.c   | 4 ++--
>   sound/soc/tegra/tegra210_admaif.c | 4 ++--
>   sound/soc/tegra/tegra210_ahub.c   | 4 ++--
>   sound/soc/tegra/tegra210_dmic.c   | 4 ++--
>   sound/soc/tegra/tegra210_i2s.c    | 4 ++--
>   5 files changed, 10 insertions(+), 10 deletions(-)

Thank you for the series.

Reviewed-by: Sameer Pujar <spujar@nvidia.com>

>
> --
> 2.16.4
>
