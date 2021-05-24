Return-Path: <SRS0=TLt2=KT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE0FC04FF3
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 10:56:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53A58610C7
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 10:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A58610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4BE01844;
	Mon, 24 May 2021 12:55:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4BE01844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621853781;
	bh=WqhjOZRgo3FM+tgPkRVlFN9ZMrMUXaXvk01c35YuPQI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DbXoZ2oTsGqhxYMfN6vJEw+FVFLK3sJh8MQoQ5ZDSPYIWBNxTfEJJbnvxhX62R1pV
	 +tFrmr9Id8vYpXi1z6/DX8iu2boNCplMTFP0S/hdHg2SUODYB/VdpbnMMUfoq5qTpj
	 j2h8fw4/mP5D5JJgL2KZ0fTHyZilgq+9RYLj/NoI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D5A43F8023A;
	Mon, 24 May 2021 12:55:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 35CC6F8025C; Mon, 24 May 2021 12:55:13 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4F2A9F80137
 for <alsa-devel@alsa-project.org>; Mon, 24 May 2021 12:55:07 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id E19A2A0040;
 Mon, 24 May 2021 12:55:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz E19A2A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1621853706; bh=SsQADfu4c/5DcA6Rxn7R2IhZKuoFdZKz0HMzZ/XLUd0=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=ySU4G582M9Vq5C4bhSHgjxixBUY2m0/V0CRlX3VSktSbDx34n6WyYeNLI6GRnfymJ
 zyR7KQqlgwI9cMgKf2CYrTHfCMZ9yLFozlp3mklMBoy0qNkGJYjBOQwODp/87iGptw
 GW8wzqdVhh+Dp1CGuTKxcwc84f0+PFrUmOEapvdc=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 24 May 2021 12:54:55 +0200 (CEST)
Subject: Re: [PATCH v3 3/4] ASoC: tegra: Specify components string for each
 card
To: Dmitry Osipenko <digetx@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Ion Agorria <ion@agorria.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>
References: <20210523234437.25077-1-digetx@gmail.com>
 <20210523234437.25077-4-digetx@gmail.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <682a8978-a2fa-1a2d-e312-fc13ab3a843e@perex.cz>
Date: Mon, 24 May 2021 12:54:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210523234437.25077-4-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Dne 24. 05. 21 v 1:44 Dmitry Osipenko napsal(a):
> Specify components string for each card of each supported device. It's
> a free form string that describes audio hardware configuration. This
> information is useful for ALSA UCM rules. It allows to generalize UCM
> rules, potentially removing a need to add new UCM rule for each device.
> 
> This patch also adds asoc->components hook that allows to specify
> components description per device.
> 
> Suggested-by: Jaroslav Kysela <perex@perex.cz>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Acked-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
