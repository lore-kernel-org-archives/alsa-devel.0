Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E66EC4321E
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Dec 2022 17:12:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 584C61887;
	Fri,  2 Dec 2022 18:11:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 584C61887
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670001144;
	bh=1IRzqlMUWV5VXnaiNn611U+VEGSXJ4pseArlJj71lP0=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qBAOT8EmaoRrfDIRpXQsGIb360THk8y7aomrZ2WDvfXV25U5XumJJd3O/5VLkaQpt
	 +VUo+uoluTBZG6XqK6dHr9G6YtAUXzHSV9M9Pj6FAFCv5g6xbWUSrNeXwdtJXaXn3c
	 oKMhUq5G0hHad1aQHqZ39dJWJCQK+UubNwS7I1ac=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A40AAF80162;
	Fri,  2 Dec 2022 18:11:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E0C85F804FC; Fri,  2 Dec 2022 18:11:12 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4CAC7F80162
 for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2022 18:11:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4CAC7F80162
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="hrCgJXMA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1670001067; x=1701537067;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=1IRzqlMUWV5VXnaiNn611U+VEGSXJ4pseArlJj71lP0=;
 b=hrCgJXMA0cnr6D0KibgUpcFXRNT/AZh/pVkYt46qqoS8Q+YpWuVUvBc8
 CqUFjBBDezgTfw9dluA8RLnCXrI17IKaS6yVsiRl+vUT+ux9TNMAClxP+
 WWTTO+V0QS3LixenbJ2hi8TC1Cjk5oRnkdVg80oQzkRrqH/yoYcuwxV6+
 ay1RLeTvDF6gEoBkgLT71UnbUgSJNklf3HZAAydAIm30MheZ6GZ99t2CJ
 mcB7fqkxIZyRp/0Iuwgon7hYmBhpOMR1oejzMcRCSO4rz7NQHdejicXJE
 wpo0x52mURLCg+s3yASyGKbJBcD9+Ik8l5aGmwdaJYk5iha4RXprMJqGu w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="380286134"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; d="scan'208";a="380286134"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2022 09:11:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="645091238"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; d="scan'208";a="645091238"
Received: from ofaiz-mobl1.amr.corp.intel.com (HELO [10.212.59.186])
 ([10.212.59.186])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2022 09:11:02 -0800
Message-ID: <4da03ca3-55b7-5c68-e424-ff23acb9cd0e@linux.intel.com>
Date: Fri, 2 Dec 2022 11:10:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2 0/3] soundwire: cadence: Fix oversized FIFO size define
Content-Language: en-US
To: Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org
References: <20221202161812.4186897-1-rf@opensource.cirrus.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221202161812.4186897-1-rf@opensource.cirrus.com>
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



On 12/2/22 10:18, Richard Fitzgerald wrote:
> As determined by experimentation and asking a hardware person, the FIFO
> in the Cadence IP is actually only 8 entries long, not 32. This is fixed
> in patch #1.
> 
> As a bonus, patches #2 and #3 fix two other things I noticed while
> debugging this.
> 
> Changes since v1:
> - Rewrite commit message of patch #1
> - Only reduce response_buf to 34 (32 + 2)
> - Trim RX_FIFO_AVAIL to length of response_buf instead of expected
>   FIFO size

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> Richard Fitzgerald (3):
>   soundwire: cadence: Don't overflow the command FIFOs
>   soundwire: cadence: Remove wasted space in response_buf
>   soundwire: cadence: Drain the RX FIFO after an IO timeout
> 
>  drivers/soundwire/cadence_master.c | 46 +++++++++++++++++++-----------
>  drivers/soundwire/cadence_master.h | 13 ++++++++-
>  2 files changed, 41 insertions(+), 18 deletions(-)
> 
