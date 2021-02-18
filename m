Return-Path: <SRS0=3Kie=HU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448B6C433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Feb 2021 09:46:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B34C364E85
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Feb 2021 09:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34C364E85
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3ADB615E2;
	Thu, 18 Feb 2021 10:45:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3ADB615E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613641556;
	bh=ANxDFueEGT3ydSHv2cOxxx4BGcKcBroTXJ2cOX3IDjc=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QiCuKG3lVkdOZ+FvsR8KxqFSgL13SsWep5Q+YHply6iwavzE1CM8cU03z/qiqyzUY
	 Lmw3BIQQYGARoLwp8KvRFv7WTT/fHWPVIm/PWu51o1JR28bLZDNJlAXpKzolb+FbY8
	 u+tbpyx/ffRHwIRJ3f/Xu76/IzRCvCC0JbhTI71o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AF570F80155;
	Thu, 18 Feb 2021 10:45:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 24697F8015A; Thu, 18 Feb 2021 10:45:03 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7E922F800E9
 for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2021 10:44:51 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 8B688A0040;
 Thu, 18 Feb 2021 10:44:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 8B688A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1613641485; bh=RHuMMOldgT2N4e/k3DrFXxjKtIKOlSntxMSbC/HNZww=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=sZLvuTjeJzPU37i5abIgrJE/tqd6GAj82IcWfn4S+pqIR4MtFtrkmLehQbd7dtxcD
 41EH7ZZP3FGTg8FS88uUQB9bNV2v809uqjvL6O2KaY12fC+JTK7qPYggugkS7ZoD0j
 nHS1s/NLgIHGwRzEDj61/a+bhtcu0k7W1adGwjbA=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Thu, 18 Feb 2021 10:44:34 +0100 (CET)
Subject: Re: [PATCH v2] ASoC: rt1316: Add RT1316 SDCA vendor-specific driver
To: shumingf@realtek.com, broonie@kernel.org, lgirdwood@gmail.com
References: <20210218091208.28734-1-shumingf@realtek.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <350ee43a-af99-bb8e-60d3-2a0dc561cb45@perex.cz>
Date: Thu, 18 Feb 2021 10:44:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210218091208.28734-1-shumingf@realtek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, derek.fang@realtek.com, flove@realtek.com,
 bard.liao@intel.com, pierre-louis.bossart@intel.com
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

Dne 18. 02. 21 v 10:12 shumingf@realtek.com napsal(a):

> +	SND_SOC_DAPM_SWITCH("DAC L", SND_SOC_NOPM, 0, 0, &rt1316_sto_dac_l),
> +	SND_SOC_DAPM_SWITCH("DAC R", SND_SOC_NOPM, 0, 0, &rt1316_sto_dac_r),

Truly, I don't understand the reason to have a separate L/R switch when we can
map this functionality to one stereo (multichannel) control.

It's an issue for all ASoC drivers. We should consider to be more strict for
the new ones.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
