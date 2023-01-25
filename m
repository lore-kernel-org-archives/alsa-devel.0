Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74171C27C76
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Jan 2023 20:16:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 90CD7203;
	Wed, 25 Jan 2023 21:16:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 90CD7203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674677812;
	bh=PrRnoTOSItQxShpM/zD41RIlzMsV/FLCN4WtDpeo6pI=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=t2S9SUtSkdLQgX4XR4RSMzM8ZgByYGJnDbMp8fwL0YE9IpTs2Bbz3O3LQdKcb68/s
	 WNeQsv1yoaVqI7ER7RCSCwFm07anS9J7fkq/OErANG4s67At056ZnQvlgptg8yH5ci
	 eIsis+3h+uI2zxA35WIB7GyJM+IOTM8J64yoD86E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 13CDCF802E8;
	Wed, 25 Jan 2023 21:16:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5DC4DF80424; Wed, 25 Jan 2023 21:16:00 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C9746F800AE
 for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2023 21:15:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C9746F800AE
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=PdtDTowW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1674677757; x=1706213757;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PrRnoTOSItQxShpM/zD41RIlzMsV/FLCN4WtDpeo6pI=;
 b=PdtDTowWOSkc3N0BG6Jw9RBNpEna8OK9PeYYr09KSdbjviSs3buaAR5e
 GCWFSXPlNqYDrqjQRklWukkRRK4EMFnn13D7IlxjgGOuVx34c3VmbGqlK
 1OkNr+UtKadFtHDvgBjv6bkAMwpkJppR6QILOzGed01YDpKDiE6ubaXhR
 0IUOoO+BWCDEaelV5ABwMbW8QipUhSrTdOohZ7YZArajRiINfu5M2/v9Z
 n9IoT97PHzRbl4pR44A9aZvAcApVkkXN8U/i/DlhFHYOLvbvdeUtZQAdc
 LnHN2W7BzpL3KNm2lfu3Hmz8hx+AglfFWD1hADPdMLqmHrHaBTGwnfVgC g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="326696210"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; d="scan'208";a="326696210"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2023 12:15:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="770874591"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; d="scan'208";a="770874591"
Received: from kccheng-desk.amr.corp.intel.com ([10.254.42.201])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2023 12:15:33 -0800
Message-ID: <cc0b1faa49bb86d68426a3f0223ff96829358c47.camel@linux.intel.com>
Subject: Re: [PATCH 00/11] ASoC: topology: Fixes and cleanups
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Amadeusz =?UTF-8?Q?S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>, Mark Brown <broonie@kernel.org>
Date: Wed, 25 Jan 2023 12:15:32 -0800
In-Reply-To: <20230125194649.3485731-1-amadeuszx.slawinski@linux.intel.com>
References: <20230125194649.3485731-1-amadeuszx.slawinski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Wed, 2023-01-25 at 20:46 +0100, Amadeusz Sławiński wrote:
> Following is series of fixes and cleanups for core topology code. Few
> patches fixing various problems all around and few fixing function
> names.
> 
> Amadeusz Sławiński (11):
>   ASoC: topology: Properly access value coming from topology file
>   ASoC: topology: Remove unused SOC_TPLG_PASS_PINS constant
>   ASoC: topology: Fix typo in functions name
>   ASoC: topology: Fix function name
>   ASoC: topology: Rename remove_ handlers
>   ASoC: topology: Remove unnecessary forward declarations
>   ASoC: topology: Pass correct pointer instead of casting
>   ASoC: topology: Return an error on complete() failure
>   ASoC: Topology: Remove unnecessary check for EOF
>   ASoC: topology: Use unload() op directly
>   ASoC: topology: Unify kcontrol removal code

 LGTM, thanks, Amadeusz!

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

