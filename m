Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2771C41513
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Jun 2024 15:29:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 10D2D84C;
	Mon, 24 Jun 2024 17:29:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 10D2D84C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1719242993;
	bh=Z8b/An1gpBRx3EBNEgucKedKqJ1Ejw6k10nsaOGsUbQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=I15AhMPwGc6aRxbKVav5nLUREcm25+KffiVei6XDEmLFURnKPcq8qQRudpW5co4mY
	 0X948SAD63wlQPQSaaprUfqviW2r7sjwsBHZlnPqfr5vu8nG4tjaL6+EgStpZGJK/W
	 pV6POIylkd+73BOEV7wuc8dKx6xiBeBb7olaFeyE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C960BF8049C; Mon, 24 Jun 2024 17:29:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 52F03F805AE;
	Mon, 24 Jun 2024 17:29:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5110EF8049C; Mon, 24 Jun 2024 17:29:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F3E69F800E4
	for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2024 17:29:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F3E69F800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KCEUnjAl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719242945; x=1750778945;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z8b/An1gpBRx3EBNEgucKedKqJ1Ejw6k10nsaOGsUbQ=;
  b=KCEUnjAlJkDKpNsJ/UdsUftDnZjWh+ff75Q44ZXY9TPrUPlmR0KdPpKH
   k35d0NVHi5qLYnDAM/0vywIgT2uCEYCZ7lWIevWM+8F76t/WoCOLZogsw
   yI/nJKbqNz1hO1KskndIZy+vo84B724e+TkeOB3UTzjdsM+m/nLfIbI2p
   MzVATuHog5SMhJL3OxL3OqkHxsepDatsM2NZ9oH5XME67t+i0dhRbv3GI
   hibN8HN6iqD8TwEgPyCA5PBCcjwENK6D6MwZ2e09r6XkZOXInMpje7zmF
   EbP9NMFdVi0hB2OuLxwAMTFDd+YOSBou0SwNBs878/6DcegX8b1CbykGd
   Q==;
X-CSE-ConnectionGUID: CORmntvKRpKS87Kj6VA4XQ==
X-CSE-MsgGUID: fLAT7N/qSGOhJEuuzYSLvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="19121768"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000";
   d="scan'208";a="19121768"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2024 08:29:00 -0700
X-CSE-ConnectionGUID: GI/hu555S7+wE0XC4sZLFA==
X-CSE-MsgGUID: 2w5dN8AwQeatpRI/PILLdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000";
   d="scan'208";a="47703946"
Received: from ksztyber-mobl2.ger.corp.intel.com (HELO [10.245.246.230])
 ([10.245.246.230])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2024 08:28:57 -0700
Message-ID: <7372501f-0393-4ba5-9e05-71d59dc1449b@linux.intel.com>
Date: Mon, 24 Jun 2024 17:26:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ASoC: SOF: ipc4-topology: Use correct queue_id for
 requesting input pin format
To: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, stable@vger.kernel.org
References: <20240624121519.91703-1-pierre-louis.bossart@linux.intel.com>
 <20240624121519.91703-3-pierre-louis.bossart@linux.intel.com>
 <ec992bf9-667c-48a4-81ed-3a1232123987@sirena.org.uk>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <ec992bf9-667c-48a4-81ed-3a1232123987@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: UTW7SQJMTPERVTD2EEMPFKTA7KIQJUFF
X-Message-ID-Hash: UTW7SQJMTPERVTD2EEMPFKTA7KIQJUFF
X-MailFrom: pierre-louis.bossart@linux.intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UTW7SQJMTPERVTD2EEMPFKTA7KIQJUFF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 6/24/24 14:36, Mark Brown wrote:
> On Mon, Jun 24, 2024 at 02:15:18PM +0200, Pierre-Louis Bossart wrote:
>> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
>> Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Cc: <stable@vger.kernel.org> # v6.8+
>> ---
> 
> Please put fixes at the start of serieses, or send them separately -
> it makes things much easier to handle if they're separate.  This ensures
> that the fixes don't end up with spurious dependencies on non-fix
> changes.

Agree, I wasn't sure if this was really linux-stable material, this
patch fixes problems on to-be-released topologies but it doesn't have
any effect on existing user setups. At the same time, it certainly fixes
a conceptual bug. Not sure if the tag is needed for those cases?
