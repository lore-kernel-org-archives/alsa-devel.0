Return-Path: <SRS0=zqBf=P3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FFEC433F5
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Nov 2021 17:38:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7CB561360
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Nov 2021 17:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B7CB561360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E489B1654;
	Mon,  8 Nov 2021 18:37:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E489B1654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636393105;
	bh=ksF/ht9OvKDO0GSFx8wYZwFM8UlEGls9WbPt+s8H5Xo=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q5YTSwcOzNNCd9/sdn1dZ/nQYF0Btg8Vr/f/mkRXc/bOs0XSCrmEBUsu3x9RYiT/0
	 rP75pnpYhDjhd2wqB1QR4HYnkUtCIibeDKQGqIOKXqQ4rbf29FltiI4KQelrAPTZoX
	 1ZqwLf7XC9PLx8mIeODAzDg/MQgaovD9pNzkJJ64=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EB36BF80227;
	Mon,  8 Nov 2021 18:37:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 758F3F8049E; Mon,  8 Nov 2021 18:37:30 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EA057F8007E;
 Mon,  8 Nov 2021 18:37:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EA057F8007E
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="232228919"
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; d="scan'208";a="232228919"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2021 09:18:23 -0800
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; d="scan'208";a="533392402"
Received: from anushave-mobl1.amr.corp.intel.com (HELO [10.255.85.158])
 ([10.255.85.158])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2021 09:18:21 -0800
Subject: Re: [Sound-open-firmware] [PATCH] ASoC: SOF: build compression
 interface into snd_sof.ko
To: Arnd Bergmann <arnd@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>
References: <20211108111132.3800548-1-arnd@kernel.org>
 <63c5b1fb-575e-f026-5a76-f08a366f7f38@linux.intel.com>
 <bae1a17c-af6e-d77a-19e7-f3f6408951fa@nxp.com>
 <CAK8P3a2-=-JM+p2b4v4F8O9O2ZhB-3Uhd_F+gcGAinAztSDH9A@mail.gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <948c8add-2a31-a7aa-f16c-8629dab690cc@linux.intel.com>
Date: Mon, 8 Nov 2021 11:18:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2-=-JM+p2b4v4F8O9O2ZhB-3Uhd_F+gcGAinAztSDH9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Bud Liviu-Alexandru <budliviu@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Paul Olaru <paul.olaru@oss.nxp.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 sound-open-firmware@alsa-project.org
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



On 11/8/21 10:15 AM, Arnd Bergmann wrote:
> On Mon, Nov 8, 2021 at 3:13 PM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>> On 11/8/21 3:39 PM, Pierre-Louis Bossart wrote:
>>> On 11/8/21 5:11 AM, Arnd Bergmann wrote:
>>>> From: Arnd Bergmann <arnd@arndb.de>
>>>>
>>>> Fixes: 858f7a5c45ca ("ASoC: SOF: Introduce fragment elapsed notification API")
>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> It's Monday morning and my memory is still foggy but I think we fixed
>>> this problem with https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fthesofproject%2Flinux%2Fpull%2F3180&amp;data=04%7C01%7Cdaniel.baluta%40nxp.com%7C25ac869cfd1040f1be1708d9a2bd3460%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637719755777370422%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=E4K2DPkpLX2SgVJ1K99Qs3uz7l7mS96gIzYlJw9akbg%3D&amp;reserved=0,
>>> where we changed the Kconfigs for i.MX. We haven't sent this update
>>> upstream for some reason.
>>>
>>> Arnd, can you share the configuration that breaks with the existing
>>> upstream code, I can check if the problem still exists.
> 
> https://pastebin.com/6JqM6Gkr

Ack, the problem still exists and is fixed by this patch

Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


On a related note, with this randconfig we have a separate problem on an
AMD patch on the SOF tree

ERROR: modpost: "snd_amd_acp_find_config"
[sound/soc/amd/snd-acp-config] is a static EXPORT_SYMBOL

That wasn't detected earlier, any idea what Kconfig option I need to
enable to filter this out?
