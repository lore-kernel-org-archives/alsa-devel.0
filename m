Return-Path: <SRS0=FEtg=KW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49754C47089
	for <alsa-devel@archiver.kernel.org>; Thu, 27 May 2021 11:02:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DE49613D1
	for <alsa-devel@archiver.kernel.org>; Thu, 27 May 2021 11:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE49613D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D76771705;
	Thu, 27 May 2021 13:01:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D76771705
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622113340;
	bh=lHLRA/ygty2iAQPlx7CfLPlWs/Jih86Q7QS69P13H+8=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MkwA9KHIK3XWA8Yq4CJ13NQGOar8sotJHYcynhgE7Hp6rUGWgxDbfV7n5yMawTpXP
	 0aavLSOXLSksDd6VFDwy6zIbmHDcVkDy7h6r5MDzJJaa/yQSYWG+++0LsWXYgiacyJ
	 mMx2vwuYw0t7HvmiVa7wrkV3YeW0oKLnIMiVeG/w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 77108F8012E;
	Thu, 27 May 2021 13:01:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7D260F80147; Thu, 27 May 2021 13:01:27 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 23259F800F9
 for <alsa-devel@alsa-project.org>; Thu, 27 May 2021 13:01:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 23259F800F9
IronPort-SDR: sYejQoZ9iYxK92PXsNhit9ep8Zf5XiCk6FNJFnhiLh48r1uqmyIb4uJ3PsrJTEsFQO7Ckp9ia6
 ZtcRouzExxJw==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="189824730"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; d="scan'208";a="189824730"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2021 04:01:14 -0700
IronPort-SDR: 3sKgMIQoSND41JU7+P6Aq2jt4cImaQ4NXBEXjucBooaOU53tLy3SkzoTIos/+K0CrDoKP5bqxT
 ainGgXD52/Iw==
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; d="scan'208";a="397696652"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2021 04:01:13 -0700
Date: Thu, 27 May 2021 13:56:18 +0300 (EEST)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Nico Schottelius <nico.schottelius@ungleich.ch>
Subject: Re: Internal microphone does not work with 5.12 (Tiger Lake, X1 Nano)
In-Reply-To: <87r1hs31h6.fsf@ungleich.ch>
Message-ID: <alpine.DEB.2.22.394.2105271343540.3922722@eliteleevi.tm.intel.com>
References: <874keoijzh.fsf@ungleich.ch>
 <f2e7c889-cc99-63b3-3bd3-302faf1745fa@perex.cz> <87r1hs31h6.fsf@ungleich.ch>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Hi Nico,

On Thu, 27 May 2021, Nico Schottelius wrote:

> Just checked, it was disabled. I rebuilt 5.12.6, rebooted, but now the
> sound card is gone (no device files in /dev/snd anymore), proably
> failing due to:
> 
> [   55.713668] snd_hda_intel 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040380
> [   55.713679] snd_hda_intel 0000:00:1f.3: Digital mics found on Skylake+ platform, using SOF driver
> [   55.745863] sof-audio-pci-intel-tgl 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040380
> [   55.745872] sof-audio-pci-intel-tgl 0000:00:1f.3: Digital mics found on Skylake+ platform, using SOF driver
> [   55.746033] sof-audio-pci-intel-tgl 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if 0x040380
> [   55.748315] sof-audio-pci-intel-tgl 0000:00:1f.3: use msi interrupt mode
> [   55.752671] sof-audio-pci-intel-tgl 0000:00:1f.3: warning: No matching ASoC machine driver found
> [   55.752673] sof-audio-pci-intel-tgl 0000:00:1f.3: error: no matching ASoC machine driver found - aborting probe
> [   55.752673] sof-audio-pci-intel-tgl 0000:00:1f.3: error: failed to get machine info -19
> [   55.752764] sof-audio-pci-intel-tgl 0000:00:1f.3: error: failed to probe DSP hardware!

it seems more kernel config options are missing. Distribution kernels 
typically enable all the machine drivers, but you are specifically missing
CONFIG_SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=m

Distribution kernels are a good reference when building on your own, and 
we in SOF also maintain example kconfig settings for typical systems. 
Here's the bit for systems with DSP and HDA codecs:
https://github.com/thesofproject/kconfig/blob/master/hdaudio-codecs-defconfig

More info at:
https://github.com/thesofproject/kconfig/

Br, Kai

