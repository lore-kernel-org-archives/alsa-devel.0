Return-Path: <SRS0=wVxo=FS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4171C4361B
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Dec 2020 19:34:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F593224B1
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Dec 2020 19:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F593224B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E3682179C;
	Mon, 14 Dec 2020 20:33:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E3682179C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607974461;
	bh=puX4FoV1wDyC48wB7KGJn+S3DoHK+zWyL+qz7q0FaCk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g8zm2oe8xVKw4/PCPp8qHFKPpEy1tValHraYwiHjSXWRhzqs/zgpLZTvvPilexWMn
	 1h3994bZSlev+v3+tTvXPFyoaeILjL18U/pgJ0lriwUIwM4ad5yQuixCwAZaNuaR+v
	 ErjwjpjuC++RuvqCiQYhYbxBLhYVL7xWplcCZ66Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6C797F801F7;
	Mon, 14 Dec 2020 20:33:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C958CF801F7; Mon, 14 Dec 2020 20:33:26 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CDECEF80121;
 Mon, 14 Dec 2020 20:33:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CDECEF80121
IronPort-SDR: EVsgd/C4tnJipjfThloLj8d1QJKWL+rIScm9HsuxuO6PXwRIqyNo3mKtIpylMBCvnjnMAOEz7J
 N4xDqKsbRNAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9834"; a="154571721"
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; d="scan'208";a="154571721"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2020 11:33:18 -0800
IronPort-SDR: b8P2FUpvlD3AnIkbogshYHGI7bR6BVjBgMTsQWq88brPw8w8HDwEXXDkLgOPmATftUlqvkXlvC
 WcCHgnHKVHqg==
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; d="scan'208";a="367598976"
Received: from cmrice1-mobl.amr.corp.intel.com (HELO [10.209.79.220])
 ([10.209.79.220])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2020 11:33:17 -0800
Subject: Re: [Sound-open-firmware] SoF support for 8086:9d71?
To: Kai-Heng Feng <kai.heng.feng@canonical.com>,
 sound-open-firmware@alsa-project.org
References: <9I9CLQ.GP190FSJBRXK3@canonical.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f05cb5ff-b5b1-2882-ba4a-380e696b2569@linux.intel.com>
Date: Mon, 14 Dec 2020 13:33:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9I9CLQ.GP190FSJBRXK3@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: SOUND <alsa-devel@alsa-project.org>
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


> On more recent kernels legacy HDA stops working for device 8086:9d71:
> [   47.211381] snd_hda_intel 0000:00:1f.3: DSP detected with PCI 
> class/subclass/prog-if info 0x040100
> [   47.211383] snd_hda_intel 0000:00:1f.3: Digital mics found on 
> Skylake+ platform, using SST driver
> 
> However, only legacy HDA supports it:
> 00:1f.3 Multimedia audio controller [0401]: Intel Corporation Sunrise 
> Point-LP HD Audio [8086:9d71] (rev 21)
> ..
>      Kernel modules: snd_hda_intel
> 
> Ubuntu kernel doesn't select SND_SOC_INTEL_SKYLAKE, which builds 
> snd-soc-skl, because based on the Kconfig description SOF should support 
> it.
> 
> I wonder if SND_SOC_INTEL_SKYLAKE should be select again?

SOF does not support Skylake and Kabylake, and only the Up2 board for 
APL. I am not sure what you mean by 'recent' kernels since this dynamic 
selection has been in place for a year now?

At any rate, to make this work again:

1. You can select SND_SOC_INTEL_SKYLAKE or alternatively to be more 
accurate:

SND_SOC_INTEL_SKL
SND_SOC_INTEL_APL
SND_SOC_INTEL_KBL

There are known issues with Conexant codecs, typically on HP devices, 
only Realtek codecs are supported.

2. In addition you will need to have the topology for SKL/KBL w/ HDaudio 
codecs. It's in alsa-topology-conf but would need to be compiled and 
installed.

3. UCM files should be already handled in alsa-ucm-conf	

Hope this helps
-Pierre
