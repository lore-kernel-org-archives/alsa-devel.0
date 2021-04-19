Return-Path: <SRS0=gP9u=JQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EC4C433ED
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Apr 2021 15:40:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF44660FEA
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Apr 2021 15:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF44660FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 69D32166B;
	Mon, 19 Apr 2021 17:39:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 69D32166B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618846808;
	bh=1LcBNEIV/TZaRPI5cJq3yRh+XW0dzfpTuIBNrhd7Css=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=evcdmDaTqokRlKJkcDHbieye4qeYfD+drZfsEwFre2gOITDRwMv2oin9zjr5/awgL
	 f92g8Aket4oFTZF0xI54vvQn0nB+UgemTNthW7OQyjBp/E5cNAPOmstmHGWiG6HneA
	 UrZpHrsswzsriN11koUY3u7OG8fGNt9VWFn1f+wI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C435AF8019B;
	Mon, 19 Apr 2021 17:39:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6A808F80227; Mon, 19 Apr 2021 17:39:16 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B075FF80164
 for <alsa-devel@alsa-project.org>; Mon, 19 Apr 2021 17:39:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B075FF80164
IronPort-SDR: ZnkE5j+sP+JCFhCHZc6kflWN9gvLjcx6YkLo2KqvqcAGokLeyVFD/3uZ6o/RmCKIcBj1LeIX4V
 MhhY69VwUzWg==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="182844305"
X-IronPort-AV: E=Sophos;i="5.82,234,1613462400"; d="scan'208";a="182844305"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2021 08:39:03 -0700
IronPort-SDR: CJCwi/X0uSRFcA5nMVqrXZtNtoPYqtkJqADfGbPTOLl3fPFm26uqBxlzSYY/mFPnLF/Z/OFuT6
 tD9VatOrrT3w==
X-IronPort-AV: E=Sophos;i="5.82,234,1613462400"; d="scan'208";a="400674108"
Received: from flpartri-mobl.amr.corp.intel.com (HELO [10.213.175.38])
 ([10.213.175.38])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2021 08:39:02 -0700
Subject: Re: [PATCH 0/5] ASoC: rt286/rt298: Fixes for DMIC2 config and combo
 jack
To: David Ward <david.ward@gatech.edu>, Oder Chiou <oder_chiou@realtek.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
References: <20210418134658.4333-1-david.ward@gatech.edu>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <bbc446c3-5146-f658-38a5-e632f9a2faf1@linux.intel.com>
Date: Mon, 19 Apr 2021 09:54:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210418134658.4333-1-david.ward@gatech.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Shuming Fan <shumingf@realtek.com>, alsa-devel@alsa-project.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Mario Limonciello <mario_limonciello@dell.com>
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



On 4/18/21 8:46 AM, David Ward wrote:
> The last two patches in this series fix a longstanding issue that prevented
> the ALC3263 codec from using a headset mic. This codec can be found on Dell
> systems including the Latitude 13 7350, Venue 11 Pro 7140, and XPS 13 9343.
> In fact, there is an ACPI quirk for the XPS 13 9343, which forces it to use
> legacy HD Audio just to avoid this issue:
> 
> https://lore.kernel.org/alsa-devel/CAPeXnHv07HkvcHrYFmZMr8OTp7U7F=k_k=LPYnUtp89iPn2d2Q@mail.gmail.com/
> 
> This may allow that ACPI quirk to be removed. Either way, the other systems
> mentioned above do not support this quirk and already use the ASoC driver,
> so this fix is necessary for headset mic support on those systems.

You should probably add a Fixes tag for the 5 patches so that the 
changes make their way into the -stable kernel that most distributions use?

The patches themselves look ok to me

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> 
> Note: there is likely other handling for this codec that only exists in the
> HDA driver, but which also belongs in the ASoC driver. Commit 394c97f824fa
> ("ALSA: hda/realtek - Change EAPD to verb control") describes an issue that
> does not seem to be resolved in the ASoC driver, to give an example.
> 
> 
> Other patches in this series are not specific to the ALC3263. These patches
> set the correct combo jack configuration when headphones are inserted, and
> fix a misaligned value set in the DMIC2 Configuration Default register.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=114171
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=150601
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=205961
> Signed-off-by: David Ward <david.ward@gatech.edu>
> 
> David Ward (5):
>    ASoC: rt286: Fix upper byte in DMIC2 configuration
>    ASoC: rt286: Configure combo jack for headphones
>    ASoC: rt298: Configure combo jack for headphones
>    ASoC: rt286: Make RT286_SET_GPIO_* readable and writable
>    ASoC: rt286: Generalize support for ALC3263 codec
> 
>   sound/soc/codecs/rt286.c | 34 +++++++++++++++++++++-------------
>   sound/soc/codecs/rt298.c |  9 +++++++--
>   2 files changed, 28 insertions(+), 15 deletions(-)
> 
