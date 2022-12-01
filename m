Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BF4C43217
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Dec 2022 20:40:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C62F177E;
	Thu,  1 Dec 2022 21:39:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C62F177E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669927221;
	bh=2enUtKIc8eJ6XSYCeVwSSEPFKwqA1PlfLZhjpcLXjdg=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UUvAEqQi9biLjcTYcKJFIEWxvxot9tyQjcz9OmFEDrHIdQ3bl8Ia1tiSxmlbo0LxO
	 LCUFPQ1Mjx+9SVX8za+Pw/+OOu1fo8xXV0YQLqsF3Kis7OiyeRLrGVaWlSqgUnh+qz
	 CZd0Nstx3iTSdS7EC4tCYqBrTg1B4ylxFIBz4aPU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 67A21F8053D;
	Thu,  1 Dec 2022 21:38:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A158CF8028D; Thu,  1 Dec 2022 21:38:40 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2A1A3F8028D
 for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2022 21:38:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2A1A3F8028D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="N45Qxg06"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1669927116; x=1701463116;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=2enUtKIc8eJ6XSYCeVwSSEPFKwqA1PlfLZhjpcLXjdg=;
 b=N45Qxg062QCxV1Bo/6ijDFx3SzL8+J9iviQLSauipQfjLAnoFDIEoU2l
 XJuOIwEa+3MbYZ95jD5juMe/gfS3Vdfjwg5lZX92xa7llyhb3i0SucbII
 5N3UojOS8wUTx7BY3i0AvOBuj9qGR12w6nYUfnIK7UCq/z+uwGFGTz55U
 UqwPC9xG04xxjoF4MLv3HchTmUFd6GNTmz9tYqx4Db4GT6fHgcW2/Fexo
 V37CBmPNHbuZF6yiqMUOTBkNsApiyjlPkcYWpeNkkzn6BK27rnfnjvh8n
 SWy24UgMqcZt4lf/hpuD01wlY89xnL7O2uzJZz4XOjPPc8qq+dVKj81Jw w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="314498396"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; d="scan'208";a="314498396"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2022 12:38:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="644781670"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; d="scan'208";a="644781670"
Received: from twcarol-mobl.amr.corp.intel.com (HELO [10.212.10.40])
 ([10.212.10.40])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2022 12:38:07 -0800
Message-ID: <002826da-f22f-9ce2-1688-345fe4e3c7ed@linux.intel.com>
Date: Thu, 1 Dec 2022 12:31:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 0/2] soundwire: Remove redundant zeroing of page registers
Content-Language: en-US
To: Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org
References: <20221201140813.4062146-1-rf@opensource.cirrus.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221201140813.4062146-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 yung-chuan.liao@linux.intel.com, linux-kernel@vger.kernel.org,
 sanyog.r.kale@intel.com
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



On 12/1/22 08:08, Richard Fitzgerald wrote:
> Writing zero to the page registers after each message transaction can add
> up to a lot of overhead for codecs that need to transfer large amount of
> data - for example a firmware download.
> 
> There's no spec reason I can see for this zeroing. The page registers are
> only used for a paged address. The bus code uses a non-paged address for
> registers in page 0. It always writes the page registers at the start of
> a paged transaction.
> 
> If this zeroing was a workaround for anything, let me know and I will
> re-implement the zeroing as a quirk that can be enabled only when it is
> necessary.

It's a feature, not a bug :-)

The page registers have to be zeroed out so that any bus-management
command hits the page0 instead of using a value that was set by codec
driver for vendor-specific configurations.

The implementation is far from optimal though, and indeed if we have
long transactions that are not interrupted by anything else we could
avoid resetting the page registers.

I tried to implement a 'lazy approach' some time back, but at the time I
didn't see any benefits due to the limited number of configurations.

I can't remember where the code is, but the initial enhancement was
listed here: https://github.com/thesofproject/linux/issues/2881

> 
> Richard Fitzgerald (2):
>   soundwire: bus: Don't zero page registers after every transaction
>   soundwire: bus: Remove unused reset_page_addr() callback
> 
>  drivers/soundwire/bus.c             | 23 -----------------------
>  drivers/soundwire/cadence_master.c  | 14 --------------
>  drivers/soundwire/cadence_master.h  |  3 ---
>  drivers/soundwire/intel_auxdevice.c |  1 -
>  include/linux/soundwire/sdw.h       |  3 ---
>  5 files changed, 44 deletions(-)
> 
