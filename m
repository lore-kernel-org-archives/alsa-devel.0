Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C111CC433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Apr 2022 20:24:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A4D8C18D8;
	Fri,  1 Apr 2022 22:23:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A4D8C18D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1648844643;
	bh=veSvfeQfSeJ1wNPQaioz6GV6Ka1zgcvCtiiFPznvOws=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pAa7QTdCxOYB/k23WNma8YCO5QN3h4eGH1nYm9lCRgBm2FeJ4Xif8FZe1Bz0xHj09
	 skizTk8/9cpubqqzLy3YHczXHGXxI2EC8hv3eSXbxClzKS2O8myfZt8yL51DIgwtYb
	 gB3LripB9uAVXa4DteHNydIT+LH4XjolQq6zlL28=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E3BEF8020D;
	Fri,  1 Apr 2022 22:23:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C1F91F80279; Fri,  1 Apr 2022 22:23:10 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 59FD2F801D8
 for <alsa-devel@alsa-project.org>; Fri,  1 Apr 2022 22:23:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 59FD2F801D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="g0zDwWKS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648844584; x=1680380584;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=veSvfeQfSeJ1wNPQaioz6GV6Ka1zgcvCtiiFPznvOws=;
 b=g0zDwWKS61I1VsTUbAd/AXI3HAMArjVm+Ol7y134DLH47WfKVatxRjtT
 +B4dL9uknDCXkwfEQ6MqgO3Z9cUkpyHwNHMjyo5lFzg4WLsTmd2zWlFFD
 aLcDZfvI4+hUcQecvYkoiO31GCw0jbiWbzeHEUB4P+AtxrTXav9//qD8g
 gQR0QWnol3zP5u4cfSmUy/7PFxSigZU0dzvXUiU23Fus/QMO+5+vONX3p
 atKz3NiWxpLaulbG9gLz4qCqJsrMAugRJdawabQp/Mr7FjiTOyThrm2Yk
 o2IYJGObl47vMMMqNbJIvXLJHa5LMBDHSv7PYvGkSy7cwbc/8jo+zZuRb g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="323399752"
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; d="scan'208";a="323399752"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2022 13:22:58 -0700
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; d="scan'208";a="555579112"
Received: from ppawar-mobl.amr.corp.intel.com ([10.254.54.75])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2022 13:22:58 -0700
Message-ID: <66dc2dbe3fe0bc25164018927fa010d0d4b69791.camel@linux.intel.com>
Subject: Re: [PATCH 0/6] ASoC: topology: Cleanup patches
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Amadeusz =?UTF-8?Q?S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Date: Fri, 01 Apr 2022 13:22:57 -0700
In-Reply-To: <20220401120200.4047867-1-amadeuszx.slawinski@linux.intel.com>
References: <20220401120200.4047867-1-amadeuszx.slawinski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
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

On Fri, 2022-04-01 at 14:01 +0200, Amadeusz Sławiński wrote:
> Following patches contain minor changes, cleaning up code to be
> easier
> to read.
> Clean up few loops, to be simpler or altogether remove them.
> Rename some things to make code easier to understand.
> 
> Amadeusz Sławiński (6):
>   ASoC: topology: Use for loop instead of while
>   ASoC: topology: Remove unnecessary looping
>   ASoC: topology: Return bool instead of int
>   ASoC: topology: Rename SOC_TPLG_PASS_MIXER to _CONTROL
>   ASoC: topology: Correct error message
>   ASoC: topology: Rename soc_tplg_init_kcontrol() function
> 
>  sound/soc/soc-topology.c | 455 ++++++++++++++++++-------------------
> --
>  1 file changed, 208 insertions(+), 247 deletions(-)

Looks good to me. Thanks!

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

