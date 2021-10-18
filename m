Return-Path: <SRS0=JS7s=PG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DCAC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Oct 2021 22:22:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D595D60F57
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Oct 2021 22:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D595D60F57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7378016BB;
	Tue, 19 Oct 2021 00:21:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7378016BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634595761;
	bh=2tyQvzLbT24FBlFtqUv2a2d0gRafS4gVUocq2CU4Q5k=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FQPQNBPpAv8wXDlj+mFRM0YZZtIQPZzDfm0C7yR5dPIonza4w9zbqWkE0H/zyOmhw
	 sxWH/zVRdkIa+CL/iJeZPVztk3hJ3XGVSwNXgUzYZn2RNZQvyennPxocms1gtJMayY
	 akpevru7qS8drX7CPh6NjVZP3NOtq0ALUrFR5XuI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 075D2F80217;
	Tue, 19 Oct 2021 00:21:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0C9B0F80224; Tue, 19 Oct 2021 00:21:49 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 74BFEF80159
 for <alsa-devel@alsa-project.org>; Tue, 19 Oct 2021 00:21:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 74BFEF80159
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="228255213"
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; d="scan'208";a="228255213"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2021 15:21:37 -0700
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; d="scan'208";a="629370386"
Received: from dsardana-mobl.amr.corp.intel.com (HELO [10.209.189.174])
 ([10.209.189.174])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2021 15:21:36 -0700
Subject: Re: [PATCH v2 0/4] ALSA: hda: New NHLT functions and cleanup
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
References: <20211018144054.286268-1-cezary.rojewski@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8a65e6d8-c3ab-bad1-5bc1-3bee64290815@linux.intel.com>
Date: Mon, 18 Oct 2021 17:21:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211018144054.286268-1-cezary.rojewski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: hdegoede@redhat.com, broonie@kernel.org, tiwai@suse.com
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



On 10/18/21 9:40 AM, Cezary Rojewski wrote:
> Changes add two crucial functions: endpoint presence-check and
> retrieval of endpoint's BLOB (hardware configuration) to NHLT API.
> 
> Few cleanups accompany the above:
> Work is done to align NHLT-struct naming with other, commonly used
> ACPI-structs. While cleaning up, don't forget about "is DMIC in NHLT?"
> check. No need to check for channel count or anything DMIC-configuration
> related, just straight up verify link_type presence.
> 
> Changes in v2:
> - patch "ALSA hda: Drop device-argument in NHLT functions" has been
>   dropped
> - updated newly added declarations in intel-nhlt.h so warning:
>   "no-previous-prototype-for-function" and error:
>   "use-of-undeclared-identifier" are no longer observed when
>   CONFIG_SND_INTEL_NHLT is not enabled
> - added Mark's tag to the last patch of the series
> 
> Amadeusz Sławiński (4):
>   ALSA: hda: Follow ACPI convention in NHLT struct naming
>   ALSA: hda: Fill gaps in NHLT endpoint-interface
>   ALSA: hda: Simplify DMIC-in-NHLT check
>   ASoC: Intel: Skylake: Use NHLT API to search for blob

Our tests don't show any regressions:
https://sof-ci.01.org/linuxpr/PR3218/build6579/devicetest/

and the code looks fine

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
