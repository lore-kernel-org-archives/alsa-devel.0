Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA0EC54E67
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Mar 2024 06:50:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 96FEA2343;
	Tue, 26 Mar 2024 07:50:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 96FEA2343
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1711435820;
	bh=BryRaYY8gDCNMKjyWhkiqyRLyJyQD8c5mGX0+SIlf/s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=iC2qZSDKp5peulwWCJd+iaFZB2KddYXZJWUE11FMQd1p6BpyQVs3bkrYhO0aOVxcf
	 uwXTlw/DP8Z63dqYFO19jE2h0OsMXAYfn0RTRBOCnsBlQ01xeLQEWYXK3v4Y6gBXRL
	 H/Tmps1m57zNgyip8cIi4tpGYpo9HQkPd9Wu7qtE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 02F69F805A1; Tue, 26 Mar 2024 07:49:46 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 523E9F802DB;
	Tue, 26 Mar 2024 07:49:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4D593F8025F; Tue, 26 Mar 2024 07:49:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4D2BDF801D5
	for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2024 07:49:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D2BDF801D5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=d/Fbatpy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711435776; x=1742971776;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BryRaYY8gDCNMKjyWhkiqyRLyJyQD8c5mGX0+SIlf/s=;
  b=d/Fbatpy3PKAuud4zn/78vrly7ayLYvRZ/lEsF66GayNx7/TobgAhVYk
   7J/jWUe7fZhL4Rq7vCXqDRVap5M4DqlCVoo+v3IgrTGiQt08xQU1qbML8
   uL+WJ1az1Gy2R708BjZWcVLOXRrSnhwe4pQl6m3utTC9SOmwvmv66Ytgp
   OPdVIWip2PQfFYn0hUfcmjwzsNVBsLs6u2c0Py7EPEAC/u5vrMoQNoqdy
   gr1TuqEfl+yW36jUjJcmzpSUUxCpSNXASyFk2TRF7H1G4lg1zIr9MYLn+
   0yrjHJVPA5SjXjuq8qAyj/9Z1fxlVaLy47VJve3SqyhXDUFvx8/CFbhyW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6337203"
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000";
   d="scan'208";a="6337203"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2024 23:49:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000";
   d="scan'208";a="47020258"
Received: from shartkam-mobl.ger.corp.intel.com (HELO [10.252.56.51])
 ([10.252.56.51])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2024 23:49:30 -0700
Message-ID: <5dcff452-516a-4b4b-ade9-c7ed62e469f4@linux.intel.com>
Date: Tue, 26 Mar 2024 08:49:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ALSA/ASoC/SOF: SSP dev_type support
To: Takashi Iwai <tiwai@suse.de>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com,
 brent.lu@intel.com
References: <20231127120657.19764-1-peter.ujfalusi@linux.intel.com>
 <ca5cddbe-3ebb-4808-8fdc-767369cb1328@linux.intel.com>
 <87plvmwkzo.wl-tiwai@suse.de>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <87plvmwkzo.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: S3AYOMMVAURHI32PI6WGCKBVIPC6XAHG
X-Message-ID-Hash: S3AYOMMVAURHI32PI6WGCKBVIPC6XAHG
X-MailFrom: peter.ujfalusi@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/S3AYOMMVAURHI32PI6WGCKBVIPC6XAHG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 22/03/2024 13:42, Takashi Iwai wrote:
> On Fri, 22 Mar 2024 12:30:44 +0100,
>> Can you take these patches via the ALSA tree, I have hoped that it would
>> land in 6.9.
> 
> It seems like to be overlooked.  I applied those now to for-linus
> branch.  But it missed the PR to 6.9-rc1, so at earliest for 6.9-rc2.

Thank you! 6.9-rc is perfect

-- 
Péter
