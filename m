Return-Path: <SRS0=1ACS=ZD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54470C43331
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 09:45:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CE6F214DB
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 09:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fdvBVQzm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE6F214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 29891166D;
	Mon, 11 Nov 2019 10:44:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 29891166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573465510;
	bh=qWwy4kFnqztI6xQBXJ3WuwJxp39oIhLc81Rn9Qb3iZA=;
	h=Date:From:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fdvBVQzmHr6y++JLNEJpx01IVMScfeYNh+lupApdnq+pZZv7nfAdsoffokCP+XtJi
	 V/m0BuOgjCNnqqIkgv5crsBKs1vkPuwszSGJkxRrSN5ubHDfF5ZK/gabZ/0W5BWv5L
	 zAwntdfhV/xwB/In0PVmmBYpLTYmvnN4pG5f/4VU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E23EF8045D;
	Mon, 11 Nov 2019 10:44:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AD597F8045D; Mon, 11 Nov 2019 10:44:17 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B924FF802E0
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2019 10:44:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B924FF802E0
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Nov 2019 01:44:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,292,1569308400"; d="scan'208";a="378441926"
Received: from zeliteleevi.tm.intel.com ([10.237.55.130])
 by orsmga005.jf.intel.com with ESMTP; 11 Nov 2019 01:44:09 -0800
Date: Mon, 11 Nov 2019 11:44:08 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@zeliteleevi
To: Curtis Malainey <cujomalainey@chromium.org>
In-Reply-To: <20191107015808.26844-1-cujomalainey@chromium.org>
Message-ID: <alpine.DEB.2.21.1911111125240.16459@zeliteleevi>
References: <20191107015808.26844-1-cujomalainey@chromium.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
Subject: Re: [alsa-devel] [PATCH 01/11] ucm: docs: Add JackName value
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi Curtis,

On Wed, 6 Nov 2019, Curtis Malainey wrote:

> This field represents the input device name for a jack detection line
> 
> Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>

this series looks good to me and I think it's a very good idea to bring 
extensions that have proven useful in Chromium to alsa-lib.

For reviewing, a bit of background context and pointers would probably 
help the wider audience. E.g. I found this very useful:

https://www.chromium.org/chromium-os/chromiumos-design-docs/cras-chromeos-audio-server
-> 
https://docs.google.com/document/d/1AcXZI9dvJBW0Vy6h9vraD7VP9X_MpwHx0eJ6hNc4G_s/edit?usp=sharing

Not directly related to this series, but it would be nice if the 
versioning would be aligned as well (especially now as ucmv2 is being 
proposed).

Br, Kai
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
