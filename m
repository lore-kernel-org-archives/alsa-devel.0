Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837A3C63797
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Jan 2023 14:31:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D61D95F58;
	Tue, 17 Jan 2023 15:30:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D61D95F58
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673965903;
	bh=wBmY79D/XBmCEo2WPDabE2wir7MUxUIlpHlWXck/7R0=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=ti8d3AoPNa2p/tS9rakYXRh8Ewam1K/ho6ZRk85drU2hWfEob4bj+t8puLJZkbHY0
	 oRThLuPSJs15k6rRL0UiCsIEzGKsMyMtiEP0O8amzbQcaoYz7j1WRV88jyxLHPTB/v
	 wnx/CFVmNm7O1Oj3fenT/udWbuCVfl3m5TFj7nJ0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9225AF8026D;
	Tue, 17 Jan 2023 15:30:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B8FDEF804DE; Tue, 17 Jan 2023 15:30:52 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 572C4F80083
 for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2023 15:30:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 572C4F80083
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=B4SVzCLB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1673965849; x=1705501849;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=wBmY79D/XBmCEo2WPDabE2wir7MUxUIlpHlWXck/7R0=;
 b=B4SVzCLBR6ztYCCmtorhnJ67/yyT76If4KSG/G0EZGnxXNSOe1HN2NHm
 IzeqRDugZ7Z6AjScuZREZhghXcKyBX7X5DEoMP8b4CHxRI5asp5+t6J9Y
 WWKGqeEVxLlZT30JTg0nHfI7P5rq+UQ25JXGByZ776YqyjJGa1PeZn6eu
 dtwkHun0i26iqxU/vVDmi2DMYl4rjqpSbDr7OM1cXKKEiGZ3GKocjLG2O
 hHCCwZ3+EUwPGxZmxa+YW9xJNUa3PJM2DLdqrcyPrt0gqoBMNqirg3kyU
 /mQZBECX8+ppTYgQq15aPj/Us/Yi2TmvjayFWG+o7U8dpwzFlpPOlXtJd A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="389204855"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; d="scan'208";a="389204855"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jan 2023 06:30:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="636886423"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; d="scan'208";a="636886423"
Received: from izakharo-mobl1.ger.corp.intel.com (HELO [10.252.14.16])
 ([10.252.14.16])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jan 2023 06:30:42 -0800
Message-ID: <63b9317b-97af-2264-0cce-5a0181496799@linux.intel.com>
Date: Tue, 17 Jan 2023 16:30:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v2 0/3] ASoC: SOF: sof-audio: Fixes for widget prepare and
 unprepare
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
References: <20230116125506.27989-1-peter.ujfalusi@linux.intel.com>
 <Y8afrS+wfZujFRHS@sirena.org.uk>
 <675f42a7-1d26-10bd-5862-f758d8b41849@linux.intel.com>
 <597d5cee-f9fd-411f-c780-8413b6fd422d@linux.intel.com>
 <Y8auL5VNefcFZAB4@sirena.org.uk>
From: =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <Y8auL5VNefcFZAB4@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
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
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 kai.vehmanen@linux.intel.com, lgirdwood@gmail.com, rander.wang@intel.com,
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com,
 angelogioacchino.delregno@collabora.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 17/01/2023 16:18, Mark Brown wrote:
> On Tue, Jan 17, 2023 at 04:05:18PM +0200, Péter Ujfalusi wrote:
> 
>> It is the topology ops optionality stuff. It is in itself a trivial (for
>> my eyes) conflict, but it is a conflict never the less.
> 
>> This is not going to backport cleanly to stable either.
> 
>> What would be the preferred way to handle this (for next, for 6.2 and
>> for 6.1.x)?
> 
> Can you send me a version that applies against for-6.2, if it
> doesn't backport to stable you can send an explicit backport
> patch once that becomes an issue.  I'm much happier resolving a
> merge between 6.2 and 6.3 than on initial application.

Sure, just to be sure: v3 which is against 6.2-rc, right?

I can assist you in case of a conflict.

-- 
Péter
