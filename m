Return-Path: <SRS0=vr1N=NB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631FCC4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Aug 2021 11:24:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CEF360EC0
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Aug 2021 11:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9CEF360EC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3AF03850;
	Tue, 10 Aug 2021 13:23:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3AF03850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628594647;
	bh=sBHXmUFS8DYIws4jnNr9X1026zEGXMLtXVIlH5qeAjU=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XgqYJAg1ABQRF7yU4S/YP6vLL4uAG9QcC6FKW6qEfkkagFiV2AE04AiBjJ8GwkNvB
	 O4AtkWJjzEZ5UT85H78Xch2p7H3PitGEHK+R1cKMiwRryl2MzHx5C7kH3+TAgbnsb7
	 IOfc34NQ3wHdgNHbhg5PbbSNQye5D08iGTaSpr5A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B9094F80245;
	Tue, 10 Aug 2021 13:23:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4C691F8025D; Tue, 10 Aug 2021 13:23:15 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BBE49F800FD
 for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2021 13:23:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BBE49F800FD
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="300469188"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; d="scan'208";a="300469188"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2021 04:23:03 -0700
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; d="scan'208";a="671730248"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.2.144])
 ([10.213.2.144])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2021 04:23:00 -0700
Subject: Re: [PATCH v2] ASoC: Intel: Fix platform ID matching
To: Curtis Malainey <cujomalainey@chromium.org>, alsa-devel@alsa-project.org
References: <20210809213544.1682444-1-cujomalainey@chromium.org>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <ac87ebd8-d10e-450d-80bb-3fe29554b73e@intel.com>
Date: Tue, 10 Aug 2021 13:22:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210809213544.1682444-1-cujomalainey@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Paul Olaru <paul.olaru@oss.nxp.com>,
 Rander Wang <rander.wang@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Matt Davis <mattedavis@google.com>, Brent Lu <brent.lu@intel.com>
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

On 2021-08-09 11:35 PM, Curtis Malainey wrote:
> Sparse warnings triggered truncating the IDs of some platform device
> tables. Unfortunately some of the IDs in the match tables were missed
> which breaks audio. The KBL change has been verified to fix audio, the
> CML change was not tested as it was found through grepping the broken
> changes and found to match the same situation in anticipation that it
> should also be fixed.
> 
> Fixes: 94efd726b947 ("ASoC: Intel: kbl_da7219_max98357a: shrink platform_id below 20 characters")
> Fixes: 24e46fb811e9 ("ASoC: Intel: bxt_da7219_max98357a: shrink platform_id below 20 characters")
> Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
> Tested-by: Matt Davis <mattedavis@google.com>

Thanks for the update, Curtis.

This is still missing Suggested-by tag from my previous review.
As kbl bits were tested by Lukasz it would be good to have his Tested-by 
tag too.

With said tags appended:

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>


Regards,
Czarek
