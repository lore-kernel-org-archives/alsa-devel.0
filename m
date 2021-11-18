Return-Path: <SRS0=e+ka=QF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006DDC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Nov 2021 16:03:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA1660F4B
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Nov 2021 16:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9CA1660F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1A191181A;
	Thu, 18 Nov 2021 17:02:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1A191181A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637251386;
	bh=ub84j9rdTIwqwdNs3ctYGtUcf4mJn/Qrc4K2uDP+luw=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tZwZwgEPGnY15MwcqaCrUIKiSI8Ahmyx0xZQz4wtyf9wTJNs42/9tiAdOB6iYyJbB
	 7kpBXKorpy6MEa84GL58/nT+T2P/UINllfy9UycglydpWP7w34HCEzyaGNEoZiDmRr
	 6t43f+F4012nqkJpjjAb6ShqU1nk1IB4O3F9TIHQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E0B6F8026D;
	Thu, 18 Nov 2021 17:02:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BA9B8F80272; Thu, 18 Nov 2021 17:02:13 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4966AF800FA
 for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2021 17:02:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4966AF800FA
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="295026000"
X-IronPort-AV: E=Sophos;i="5.87,245,1631602800"; d="scan'208";a="295026000"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2021 08:01:33 -0800
X-IronPort-AV: E=Sophos;i="5.87,245,1631602800"; d="scan'208";a="672852247"
Received: from jherna2-mobl2.amr.corp.intel.com (HELO [10.212.70.149])
 ([10.212.70.149])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2021 08:01:32 -0800
Subject: Re: [PATCH 5.16 regression fix] ASoC: soc-acpi: Set mach->id field on
 comp_ids matches
To: Hans de Goede <hdegoede@redhat.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jie Yang <yang.jie@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
References: <20211118153014.349222-1-hdegoede@redhat.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9c56f0e5-f4f0-efa9-2777-70b38d4eae08@linux.intel.com>
Date: Thu, 18 Nov 2021 10:01:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211118153014.349222-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Brent Lu <brent.lu@intel.com>
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



On 11/18/21 9:30 AM, Hans de Goede wrote:
> Commit dac7cbd55dca ("ASoC: Intel: soc-acpi-byt: shrink tables using
> compatible IDs") and commit 959ae8215a9e ("ASoC: Intel: soc-acpi-cht:
> shrink tables using compatible IDs") simplified the match tables in
> soc-acpi-intel-byt-match.c and soc-acpi-intel-cht-match.c by merging
> identical entries using the new .comp_ids snd_soc_acpi_mach field to
> point a single entry to multiple ACPI HIDs and clearing the previously
> unique per entry .id field.
> 
> But various machine drivers from sound/soc/intel/boards rely on mach->id
> in one or more ways, e.g. some drivers contain the following snippets:
> 
> 	adev = acpi_dev_get_first_match_dev(mach->id, NULL, -1);
> 
> 	pkg_found = snd_soc_acpi_find_package_from_hid(mach->id, ...
> 
> 	if (!strncmp(snd_soc_cards[i].codec_id, mach->id, 8)) { ...
> 
> All of which are broken by the match table shrinking.
> 
> Make the snd_soc_acpi_mach.id field non const (the storage for the tables
> already is non const) and on a comps_ids match copy the matching HID to
> the id field to fix this.
> 
> Fixes: dac7cbd55dca ("ASoC: Intel: soc-acpi-byt: shrink tables using compatible IDs")
> Fixes: 959ae8215a9e ("ASoC: Intel: soc-acpi-cht: shrink tables using compatible IDs")
> Suggested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Brent Lu <brent.lu@intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thanks Hans for reporting and fixing this, much appreciated.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
