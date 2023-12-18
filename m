Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF17C46CCD
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Dec 2023 10:47:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 01935844;
	Mon, 18 Dec 2023 11:47:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 01935844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1702896445;
	bh=zAyQ5UH+r5YxvrIXMRC6ZH0irL4Aw9kXIfCoGJNnn00=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=XkCfPlkyu7QOmtXkSwDGzjrkd2BMTRKUymLMeSP04/K8RdY9rtx5r3HC9BXxu/8oi
	 QZGp7amvYQyGRiwCcZF/ajU/9zeEUeZWnXS1SZqNvWnUb/7Sf1LkM85HeINixNIAZe
	 NVH1Zl0kMd2vlqpO8oKA44S60Auk/536YdlMTbWk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CD725F805B6; Mon, 18 Dec 2023 11:46:43 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 49367F805BA;
	Mon, 18 Dec 2023 11:46:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1504CF80425; Mon, 18 Dec 2023 11:46:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2C257F80212
	for <alsa-devel@alsa-project.org>; Mon, 18 Dec 2023 11:46:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2C257F80212
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=VEJr5Yyr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702896392; x=1734432392;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zAyQ5UH+r5YxvrIXMRC6ZH0irL4Aw9kXIfCoGJNnn00=;
  b=VEJr5Yyr18h8kepgT1662HU3Ezz4XUJQnDBVwqLcqXbXRUAtj2+reBa4
   yAfesf2lBCfJBJztnSkBS+c32vm4IibcTg3l1jOw0XpXh/Ed5HTiMJ9cI
   2pPlEVF7rQOYqJcEtpdFyP0Z3skWRVZ1CiOvT1tgh6CI3rIDMH/2/de//
   iwFwWy/2PnMRk3kxvd68gV9dmmiqU2s2u2wwyFlZYfd9m8ucArzVf/OVA
   XDFjHmBmmTGDgJqVxd77GewVlhOoNNgsBpK80pGVroSIPYwomSWTySp8E
   NyzRmoPWUBhdsVEHc1L4sgc7fyES01w3gfRcDmLa4VIsWCCQfQJ9XoYha
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="8851358"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600";
   d="scan'208";a="8851358"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2023 02:46:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="779048123"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600";
   d="scan'208";a="779048123"
Received: from mmaiores-mobl1.ger.corp.intel.com (HELO [10.249.34.197])
 ([10.249.34.197])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2023 02:46:26 -0800
Message-ID: <8efc7277-44ae-406c-8406-badd894f028f@linux.intel.com>
Date: Mon, 18 Dec 2023 10:41:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ASoC: Intel: bytcr_rt5640: Add new swapped-speakers
 quirk
Content-Language: en-US
To: Hans de Goede <hdegoede@redhat.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
References: <20231217213221.49424-1-hdegoede@redhat.com>
 <20231217213221.49424-2-hdegoede@redhat.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20231217213221.49424-2-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: 7YWBX6LKMI23CLUM4XNOHJ5P2HIGAO5S
X-Message-ID-Hash: 7YWBX6LKMI23CLUM4XNOHJ5P2HIGAO5S
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7YWBX6LKMI23CLUM4XNOHJ5P2HIGAO5S/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 12/17/23 15:32, Hans de Goede wrote:
> Some BYTCR x86 tablets with a rt5640 codec have the left and right channels
> of their speakers swapped.
> 
> Add a new BYT_RT5640_SWAPPED_SPEAKERS quirk for this which sets
> cfg-spk:swapped in the components string to let userspace know
> about the swapping so that the UCM profile can configure the mixer
> to correct this.
> 
> Enable this new quirk on the Medion Lifetab S10346 which has its
> speakers swapped.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

