Return-Path: <SRS0=rgkk=NH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1B6C4338F
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Aug 2021 15:10:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADBCD60ED5
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Aug 2021 15:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ADBCD60ED5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 810E416B0;
	Mon, 16 Aug 2021 17:09:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 810E416B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629126598;
	bh=6HFiPE1qw6l2Lc4obceqRDiIYfM21H5OoO9p55+MIow=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hxvVkZTRZJyP2vwdMMjuD1Lyh4gW4bx2VITx/H3fHO9BNCPZ34Ivi69nsEqofwhPR
	 GW5Prbf1Gtq6g9zPLuCUOBFJgPdfmVFeH6E+lKxfYcFT3U5Izug8RkRf/dxYWrOvRF
	 ++9gGNg6mW1jB+6eDhMbcLSmo4gj5TloDlHKtycg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EBDACF80246;
	Mon, 16 Aug 2021 17:09:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9AD95F80249; Mon, 16 Aug 2021 17:09:05 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 62848F80154
 for <alsa-devel@alsa-project.org>; Mon, 16 Aug 2021 17:08:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 62848F80154
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="203033967"
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; d="scan'208";a="203033967"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2021 08:08:49 -0700
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; d="scan'208";a="519684587"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.17.51])
 ([10.213.17.51])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2021 08:08:48 -0700
Subject: Re: [PATCH v3 0/8] ASoC: Intel: boards: use software node API
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
References: <20210813151116.23931-1-pierre-louis.bossart@linux.intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <a4feb922-fe6b-1194-ac25-80f0a157ae80@intel.com>
Date: Mon, 16 Aug 2021 17:08:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210813151116.23931-1-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: tiwai@suse.de, Hans de Goede <hdegoede@redhat.com>, broonie@kernel.org,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

On 2021-08-13 5:11 PM, Pierre-Louis Bossart wrote:
> This is an update on an earlier contribution from Heikki Krogerus
> 
> The function device_add_properties() is going to be removed.
> Replacing it with software node API equivalents.
> 
> Thanks for Hans de Goede and Andy Shevchenko for their comments,
> suggestions and Reviewed-by tags on GitHub. The review thread can be
> found at https://github.com/thesofproject/linux/pull/3041)
> 
> v3 changes:
> Fixed nit-picks from Andy: label, return value, missing commas/periods.
> Added Andy's Reviewed-by tag
> 
> v2 changes: feedback from Andy and Hans
> Better error handling
> Codec reference is kept until the .remove callback
> Remove bus search to find device
> 
> v1 changes from Heikki's patches:
> Avoid the use of devm_ routines for Baytrail machine drivers.

While sof_sdw_* machine boards history shows these have been updated 
concurrently, the same cannot be said for other, older Intel boards. And 
thus, I'd advise to separate changes for each older board, here: 
bytcht_es8316, bytcr_rt5640 and bytcr_rt5651. You could even squash 
smaller changes so the number of patches isn't getting out of control.

If regression occurs in just one of them - even due to spelling error or 
unintended code line - revert will impact all the boards. In the past 
having separate patches for kbl_*, bdw_* and such saved a lot of 
trouble, especially given their history.

This is more of an suggestion than a blocker. Haven't found any code issues:

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>

Regards,
Czarek
