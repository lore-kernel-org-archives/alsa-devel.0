Return-Path: <SRS0=LzfN=Z3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64061C43603
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Dec 2019 04:12:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ED2F20640
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Dec 2019 04:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BOa77/dh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED2F20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6D62B1669;
	Thu,  5 Dec 2019 05:11:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6D62B1669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575519158;
	bh=ONkGf0MwcQbHSzUUTMlX2tHzEiWU897HiEd9vrRr0wE=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BOa77/dhW4F5wjhcufnjlx4psfLFhIw0GfejBAFLkB3dPLBFNx+0WzSpCTDPywYdd
	 CZLqOsUz/CqSbsDjdYbPvBb14RBxUERLRT47DkjPXUn/N2/5HqX/GvKa1TGNC/4fFW
	 2KlYUqKBJ/DqDJcYaRPtRcNSBerGWBacXLlFTqEA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 85DB7F80229;
	Thu,  5 Dec 2019 05:10:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6BFC4F800B4; Thu,  5 Dec 2019 05:10:42 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 781A2F800B4
 for <alsa-devel@alsa-project.org>; Thu,  5 Dec 2019 05:10:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 781A2F800B4
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Dec 2019 20:10:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,279,1571727600"; d="scan'208";a="219099140"
Received: from bcmarin-mobl.amr.corp.intel.com (HELO [10.255.230.27])
 ([10.255.230.27])
 by fmsmga001.fm.intel.com with ESMTP; 04 Dec 2019 20:10:32 -0800
To: Curtis Malainey <cujomalainey@chromium.org>, alsa-devel@alsa-project.org
References: <20191205001605.229405-1-cujomalainey@chromium.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b2eb65e3-d9ee-f6ed-197b-c40d90ab1e8d@linux.intel.com>
Date: Wed, 4 Dec 2019 22:09:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191205001605.229405-1-cujomalainey@chromium.org>
Content-Language: en-US
Cc: Hui Wang <hui.wang@canonical.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Alexios Zavras <alexios.zavras@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Ben Zhang <benzh@chromium.org>, Mac Chiang <mac.chiang@intel.com>,
 Mark Brown <broonie@kernel.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Naveen Manohar <naveen.m@intel.com>, Bard Liao <bardliao@realtek.com>,
 Thomas Gleixner <tglx@linutronix.de>, Jon Flatley <jflat@chromium.org>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Allison Randal <allison@lohutok.net>
Subject: Re: [alsa-devel] [PATCH v2] ASoC: intel: Add Broadwell rt5650
	machine driver
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 12/4/19 6:15 PM, Curtis Malainey wrote:
> From: Ben Zhang <benzh@chromium.org>
> 
> Add machine driver for Broadwell + rt5650.
> 
> v2 (Curtis):
> * Addressed Pierre's comments
>    * Added SOF dependencies
>    * Added platform override
>    * Fixed Kconfig
> * Moved to devm register

you want the version info below the --- mark

> 
> Signed-off-by: Bard Liao <bardliao@realtek.com>

Not sure what the recommendation is when an address is no longer valid?

> +static struct platform_driver bdw_rt5650_audio = {
> +	.probe = bdw_rt5650_probe,
> +	.driver = {
> +		.name = "bdw-rt5650",
> +		.owner = THIS_MODULE,

this .owner is not needed.

The rest looks good
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
