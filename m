Return-Path: <SRS0=4l9v=GP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842ACC433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jan 2021 17:40:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 652102311D
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jan 2021 17:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 652102311D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 008DE16B4;
	Tue, 12 Jan 2021 18:40:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 008DE16B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610473251;
	bh=sjJtnxgf9X1EwQ/SxBo1zCUmEFMV3vIZjVH9VjM5nbY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LuE5rPf22h/x4fo7qtZMXUD70WCnUltqGTlJtWAVtQoS74mEKTv3R/W5y0rHX5mzk
	 AaOU9Cmw615in9xQPeUYn+0J+0RIpFul4kqAexkobCZbiHurSJhs4LZw3ayWXPDY0b
	 gniu5Tuqh01HAYM8rYtWnIaEwuv3xNZh1OdJR73g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D38CF80249;
	Tue, 12 Jan 2021 18:40:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CF3ABF8025E; Tue, 12 Jan 2021 18:39:57 +0100 (CET)
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1A554F800B9
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2021 18:39:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1A554F800B9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="tjeh69wn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=2pPPhrxgRtHCGXKNAyS2DWDRTyhPu01Ss0FZFp58vxQ=; b=tjeh69wnZ3Uc3cUL7S8hqIqMcx
 GlRdTOBB6FToDN9zsdefzbTpHAAid3+NXcnsJxLRvLtGpBtuWixKRzI1JaSjXSw9vZQ84QUZs6ZoS
 8H2k180wrGFYmDSwkFR0sEIwi1llBv/TQIzk60muOos2a2SR0Fy4yhvFDXlvUqhdWo7PVTRHIo46b
 ZWmW4z11IqzTrkWSKXFaBk/n6gUTl0dbZZEepM4L96/ImDixm8cdksv/6WTv7QSc+J+30qvi0VTAf
 IOM2GKPTc34Syu+wZywvMLVgPj8lxVoPVHi20CjOvNquQBsQNHR6BmyJyk1nz42GdqPrCLm2ynu/4
 Ijxj8VdQ==;
Received: from [2601:1c0:6280:3f0::79df]
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzNdp-00015h-Oj; Tue, 12 Jan 2021 17:39:38 +0000
Subject: Re: [PATCH v3 1/3] platform/x86: dell-privacy: Add support for Dell
 hardware privacy
To: Perry Yuan <Perry.Yuan@dell.com>, oder_chiou@realtek.com, perex@perex.cz, 
 tiwai@suse.com, hdegoede@redhat.com, mgross@linux.intel.com
References: <20210112171723.19484-1-Perry_Yuan@Dell.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cc83351b-a19a-9a3e-d511-4553cf4d7ef0@infradead.org>
Date: Tue, 12 Jan 2021 09:39:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210112171723.19484-1-Perry_Yuan@Dell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Mario.Limonciello@dell.com,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 platform-driver-x86@vger.kernel.org, broonie@kernel.org
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

On 1/12/21 9:17 AM, Perry Yuan wrote:
> +config DELL_PRIVACY
> +	tristate "Dell Hardware Privacy Support"
> +	depends on ACPI
> +	depends on ACPI_WMI
> +	depends on INPUT
> +	depends on DELL_LAPTOP
> +	depends on LEDS_TRIGGER_AUDIO
> +	select DELL_WMI
> +	help
> +	This driver provides support for the "Dell Hardware Privacy" feature
> +	of Dell laptops.
> +	Support for a micmute and camera mute privacy will be provided as
> +	hardware button Ctrl+F4 and Ctrl+F9 hotkey

	End above with a period '.' please.

> +
> +	To compile this driver as a module, choose M here: the module will
> +	be called dell_privacy.

Please follow coding-style for Kconfig files:

from Documentation/process/coding-style.rst, section 10):

For all of the Kconfig* configuration files throughout the source tree,
the indentation is somewhat different.  Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces.


thanks.
-- 
~Randy

