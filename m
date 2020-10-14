Return-Path: <SRS0=7Yh/=DV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9A7C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:53:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A9ED2222C
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="juLNlyCU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A9ED2222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB45C1742;
	Wed, 14 Oct 2020 17:52:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB45C1742
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602690809;
	bh=yt9DmDUJ1O2Z+DJTsQPJKxy7Y0NfQmA2RaWk8VBNjZ8=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=juLNlyCU5WmKzqzOSA+8aNcqxa+4ZtzMUNwaQtv/KT7EYeE5ScsVAQH9mOwLnG0bU
	 kcK2jhN/80iKwt5m9oqzO44x8xCCH/NXqsJAvrkfGg9Y3wJ1H0e2aV1pQ3KufzpLt3
	 eSlEMCie/UoRvNkpssaemxcKML1kwmgELbFchA3Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D5FEF80224;
	Wed, 14 Oct 2020 17:52:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 90C41F80217; Wed, 14 Oct 2020 17:52:35 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3C04DF8012B;
 Wed, 14 Oct 2020 17:52:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3C04DF8012B
IronPort-SDR: YB/VvqWNP2sc1aYsrmgwKkq3KZRfZh1kKkeok0MEZQe8NaVHkpoHS6d8Xxe/RneSmNxKSvYA53
 wiJUq9sx4TuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="230307948"
X-IronPort-AV: E=Sophos;i="5.77,375,1596524400"; d="scan'208";a="230307948"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2020 08:52:23 -0700
IronPort-SDR: TiMpkT6Vr5KRL2Rb3SJMqROFDgAygZNDRfFesudJonJg+mkNpycV56Meh+jvgxEaCQptmnDMvZ
 i/WjTR7QwHJA==
X-IronPort-AV: E=Sophos;i="5.77,375,1596524400"; d="scan'208";a="357411121"
Received: from mbhutani-mobl.amr.corp.intel.com (HELO [10.212.4.214])
 ([10.212.4.214])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2020 08:52:22 -0700
Subject: Re: [PATCH 0/3] ASoC: sof: cleanup Kconfig files
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
References: <20201014025633.4879-1-rdunlap@infradead.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <86a0251d-3d0d-bff8-a591-22d184c40fc7@linux.intel.com>
Date: Wed, 14 Oct 2020 09:37:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201014025633.4879-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>,
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



On 10/13/20 9:56 PM, Randy Dunlap wrote:
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Cc: sound-open-firmware@alsa-project.org
> Cc: alsa-devel@alsa-project.org
> 
> Some general editing of sound/soc/sof/ Kconfig files:

Thanks Randy!

That looks all good to me, but I see you didn't CC: Mark Brown and 
Takashi Iwai so not sure if Mark can apply this directly. Might need to 
resend the series?

I also can take this series in the SOF tree and combine it with other 
changes I am making to Kconfigs to remove hard-coded exclusions, that 
would mean less churn on the same files.
>   [PATCH 1/3] ASoC: sof: imx: fix Kconfig punctuation
>   [PATCH 2/3] ASoC: sof: intel: fix Kconfig punctuation and wording
>   [PATCH 3/3] ASoC: sof: Kconfig: fix Kconfig punctuation and wording
> 
>   sound/soc/sof/Kconfig       |   42 +++++++++++------------
>   sound/soc/sof/imx/Kconfig   |   10 ++---
>   sound/soc/sof/intel/Kconfig |   62 +++++++++++++++++-----------------
>   3 files changed, 57 insertions(+), 57 deletions(-)
> 
