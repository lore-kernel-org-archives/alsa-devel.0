Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD79C47DD9
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Mar 2024 18:58:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 70BB22C71;
	Wed, 27 Mar 2024 19:57:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 70BB22C71
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1711565883;
	bh=OfAba53dQ06otKA3IjFlOaA0wy3ja83eDdFvPK/hbB0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=PaJeDeXqGrrCGFUOQ/p9s+FJlLMjnpdBWn8DXnJkTKqzN4lvwpyb9pIYJF0EU5D1O
	 DUcdlY4ZYTlRpSDmu1BGUoqOulC/grW1Tcvg3ZdrrrJciNbQeevkUnboAoDtM5sQyT
	 7xv5FjisORd6835rVym1PSOlRVBrJyUZK59H4iIc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D3FD8F805A8; Wed, 27 Mar 2024 19:57:31 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 09750F805AC;
	Wed, 27 Mar 2024 19:57:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 89190F8025F; Wed, 27 Mar 2024 19:57:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A7BE2F801D5
	for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2024 19:57:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A7BE2F801D5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OtZnBNuN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711565844; x=1743101844;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OfAba53dQ06otKA3IjFlOaA0wy3ja83eDdFvPK/hbB0=;
  b=OtZnBNuNUagNq6SQZm9PPZnuFs6Zya3SnKOC2ne1OGQ7lCpBK1Go2ATD
   GAkCPiriDLs1g8hfAL2Cb7NKYD1gcRDDmVhuskIS7AzgeJ4Kw5Ph15JGn
   RATkM8XKA+82X1t4Hl+mrDhynsI2aMc3xkf0LfLtHN8e0ge0/8xGoi9Q1
   C8T4MtcZ4o8QC3dGuXnzGpbVbkvUZ0jRYTl+7kfn0iHL2t7EZLYpmaBm5
   hKtw4pAewAAOLmrq+OAq88c49gUmIvn2kOScxK5xsO1Gnp8IXqU6CwUpD
   RwlOfKoxE6TE722q4tabvizoRAI8gwVtURpXo7j+mdGnrRFgHPgr7GA+7
   A==;
X-CSE-ConnectionGUID: FoUeIgupSziGCNzdtc3iGQ==
X-CSE-MsgGUID: 0ndxgt+eRj+uXdhC3DrsFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6555475"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000";
   d="scan'208";a="6555475"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 11:57:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000";
   d="scan'208";a="16404593"
Received: from ssherman-mobl.amr.corp.intel.com (HELO [10.212.117.1])
 ([10.212.117.1])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 11:57:17 -0700
Message-ID: <a256c478-2cdb-4012-ab95-b6ccba1194e8@linux.intel.com>
Date: Wed, 27 Mar 2024 13:14:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] ASoC: drop driver owner assignment
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
 Baojun Xu <baojun.xu@ti.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org
References: <20240327-module-owner-var-v1-0-86d5002ba6dc@linaro.org>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240327-module-owner-var-v1-0-86d5002ba6dc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: 2BF7B6I6BB3XWZ2PLQTRZL6VJXUMEJD4
X-Message-ID-Hash: 2BF7B6I6BB3XWZ2PLQTRZL6VJXUMEJD4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2BF7B6I6BB3XWZ2PLQTRZL6VJXUMEJD4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 3/27/24 12:44, Krzysztof Kozlowski wrote:
> Core for several drivers already sets the driver.owner, so driver does
> not need to.  Simplify the drivers.

Nice cleanup, thanks.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
