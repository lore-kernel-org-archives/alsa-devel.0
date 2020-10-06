Return-Path: <SRS0=FemE=DN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05A7C41604
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Oct 2020 14:58:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 758F0206CB
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Oct 2020 14:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lfqg05fm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758F0206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8EB63171E;
	Tue,  6 Oct 2020 16:57:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8EB63171E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601996305;
	bh=jJEbpm6E5HKVzJQiC7e5w/jgIFfdfd+COF2Tp9TOerM=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lfqg05fmAUbViI1E4pxnit8yU7QTZBEKd6+NF5HHkzxftB3kDpnB9hG/65kckszAJ
	 PCUEfN57On2Z4V02elCjLWG/egBBB2ltrbBi1tF4gyagnfj3/3GNeqbntfTB5iJvuY
	 QoSgq0WpJYy3S4PPCdzx921T6dOIMNHMfjIFuaew=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 67E68F80129;
	Tue,  6 Oct 2020 16:57:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4D288F8012A; Tue,  6 Oct 2020 16:57:33 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4F6E0F80127
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2020 16:57:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4F6E0F80127
IronPort-SDR: 2qPv3Zw4Pj0E1n5rWeJYF+DZpX3D/iK/Xo00R6iSXvK4rJMJ2Tq5CwGaD7oIDv1n7gNqCKDgqf
 sHv1d7eO5/qA==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="228660453"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; d="scan'208";a="228660453"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2020 07:57:07 -0700
IronPort-SDR: m916GjOTq2Vau7mUEnc2NfON60SI4DuK2Aq3Y0/c+D4lNE5+oxe84PRNseQmacEmdipKhT73IC
 RayMP/ga3mNg==
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; d="scan'208";a="460830216"
Received: from mforsman-mobl.amr.corp.intel.com (HELO [10.212.97.68])
 ([10.212.97.68])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2020 07:57:05 -0700
Subject: Re: [PATCH] ALSA: compress: allow pause and resume during draining
To: Vinod Koul <vkoul@kernel.org>
References: <CGME20200929084051epcas2p35fb2228ed1bdfce6a7ddf5b37c944823@epcas2p3.samsung.com>
 <000001d6963c$3cc53690$b64fa3b0$@samsung.com> <s5heemlklo0.wl-tiwai@suse.de>
 <20201001102938.GU2968@vkoul-mobl>
 <2bf52360-bd11-b4cd-b255-8a5610b4aa5f@linux.intel.com>
 <20201006062105.GQ2968@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4bbc385b-d35a-8766-7981-034455287225@linux.intel.com>
Date: Tue, 6 Oct 2020 09:57:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201006062105.GQ2968@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, khw0178.kim@samsung.com,
 Takashi Iwai <tiwai@suse.de>, tiwai@suse.com, lgirdwood@gmail.com,
 kimty@samsung.com, hmseo@samsung.com, tkjung@samsung.com, s47.kang@samsung.com,
 pilsun.jang@samsung.com, Gyeongtaek Lee <gt82.lee@samsung.com>
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


> The SM in kernel might be bit more convoluted so was wondering if we can
> handle this in userland. The changelog for this patch says that for
> test case was sending whole file, surely that is not an optimal approach.

It's rather common to have to deal with very small files, even with PCM, 
e.g. for notifications. It's actually a classic test case that exposes 
design issues in drivers, where e.g. the last part of the notification 
is not played.

> Should we allow folks to send whole file to kernel and then issue
> partial drain?

I don't think there should be a conceptual limitation here. If the 
userspace knows that the last part of the file is smaller than a 
fragment it should be able to issue a drain (or partial drain if it's a 
gapless solution).

However now that I think of it, I am not sure what happens if the file 
is smaller than a fragment. That may very well be a limitation in the 
design.
