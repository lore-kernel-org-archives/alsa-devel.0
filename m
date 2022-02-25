Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82782C433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Feb 2022 02:43:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE9EC1B23;
	Fri, 25 Feb 2022 03:42:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE9EC1B23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645756994;
	bh=NKI2tGNN1+xn4hT9aYWaqxnkkbPb03W5EFcXbYMpVX4=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yx/FctDEubt57nQssH+XlDu6aT9xbtTUo6eiV4QSXh98As6vyaK1Wiod2MDkJlikn
	 yCQg4NJNqPkZTv+BIoN/0aepwnHTNFi+tW5rszwq1sSB+R+zfjtYT8eCivshPHo0Zd
	 Xwuf2gS8XV4kxQdRUdQWq+F/SW9ayIMtIPuOJPII=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C6333F8052D;
	Fri, 25 Feb 2022 03:39:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1EBDFF80535; Fri, 25 Feb 2022 03:39:42 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A40E2F80533
 for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2022 03:39:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A40E2F80533
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="J1Mlagb6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645756780; x=1677292780;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=NKI2tGNN1+xn4hT9aYWaqxnkkbPb03W5EFcXbYMpVX4=;
 b=J1Mlagb6kG5AgcuNyBqj+tJHHzSU4HV49rvs1QTw4IswUDPkp6KwvuhT
 pjh3Fffwaz6GW+iA6rJntWOqwwxYe9J+u2EuJp0cxN3BRp01qyGJg4n8j
 wOeo3s7ZHvtVHb6WX0Oi3jcqZspUAz7kE/ZUDTZrbwmZpYkqu/dxYegSC
 N5tmo/PDtqPP0G/CDQPaaaw1Oad4B/ar99LrJe/EPt8/NFKnswnNOIDAA
 fkAt7Uy+lFjMZ5VxRUtUDsZToUZZzZrWyWteEdhQ887cZeerfB8ICvfaP
 jYDG9kHfL6zrdWrRoYPx+1UjdbP3KkIJdVlb6LpYwUd6nFpKHyLVk3nV2 A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="252133439"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; d="scan'208";a="252133439"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2022 18:39:33 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; d="scan'208";a="491832717"
Received: from jsegev-mobl1.ger.corp.intel.com (HELO [10.212.99.193])
 ([10.212.99.193])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2022 18:39:30 -0800
Message-ID: <fdfe86e5-f44a-134f-c98d-a808b22032a1@linux.intel.com>
Date: Thu, 24 Feb 2022 20:18:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH 15/17] ASoC: Intel: avs: Implement CLDMA transfer
Content-Language: en-US
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
References: <20220207122108.3780926-1-cezary.rojewski@intel.com>
 <20220207122108.3780926-16-cezary.rojewski@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220207122108.3780926-16-cezary.rojewski@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: upstream@semihalf.com, harshapriya.n@intel.com, rad@semihalf.com,
 tiwai@suse.com, hdegoede@redhat.com, broonie@kernel.org,
 amadeuszx.slawinski@linux.intel.com, cujomalainey@chromium.org,
 lma@semihalf.com
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




> +int hda_cldma_stop(struct hda_cldma *cl)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	/* disable interrupts */
> +	snd_hdac_adsp_updatel(cl, AVS_ADSP_REG_ADSPIC,
> +			      AVS_ADSP_ADSPIC_CLDMA, 0);

single line?

> +	snd_hdac_stream_updateb(cl, SD_CTL, SD_INT_MASK | SD_CTL_DMA_START, 0);
> +
> +	/* await DMA engine stop */
> +	ret = snd_hdac_stream_readb_poll(cl, SD_CTL, reg,
> +					 !(reg & SD_CTL_DMA_START),

move to previous line? we can use 100 chars these days, and that's what
you do below.

> +					  AVS_CL_OP_INTERVAL_US, AVS_CL_OP_TIMEOUT_US);
> +	cancel_delayed_work_sync(&cl->memcpy_work);
> +
> +	return ret;
> +}
