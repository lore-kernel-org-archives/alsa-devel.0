Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59545C43464
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:53:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15982214F1
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HRmz3juD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15982214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 47C5C1614;
	Mon, 21 Sep 2020 10:52:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 47C5C1614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600678380;
	bh=76jrQW4yBF7jDR5TJDcbMjSZobncCWzGdmUTPqDdWlg=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HRmz3juDsWjTo0vxTWxkclUGjNqKXxPhTaT+hZqdQF8LRMr64xqdzfcSIzzbFgBeD
	 /ZVf2vZ0D5kHMOv8DBKpJgxm34fXLGF6Kf5S+SDa/01TLmNoGkWKXIdeUl/fjPhdQM
	 lXkU9U70sAjGLnUZdKBYxOKlssr3KHLupxJqjGZg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 91668F800B2;
	Mon, 21 Sep 2020 10:52:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BF2F1F80162; Mon, 21 Sep 2020 10:52:07 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5F031F800B2
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 10:51:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5F031F800B2
IronPort-SDR: NF9402xcUiJ/pKpNoykj0PwLimeEhtY3bi+4HhmdmsDHEnBZF90sYKucyr+KLXVJqT90wnqWB4
 MBsyY89I6K8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9750"; a="139833978"
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; d="scan'208";a="139833978"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 01:51:53 -0700
IronPort-SDR: XAdz7lMQ0OmOcO0NEgG57uWbE99CUA9s2EztxBf27uEqEtutgVq9Yug+7DRVIT5o1DBQpEgESM
 UddRYHxG0QWg==
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; d="scan'208";a="321676092"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 01:51:48 -0700
Date: Mon, 21 Sep 2020 11:50:11 +0300 (EEST)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Philipp Leskovitz <philipp.leskovitz@secunet.com>
Subject: Re: PROBLEM: A page fault occurs when the sound driver is loaded
 (ThinkPad X13/T14)
In-Reply-To: <60074f02-de79-95e1-d03d-62e843f9c691@secunet.com>
Message-ID: <alpine.DEB.2.22.394.2009211148520.3186@eliteleevi.tm.intel.com>
References: <60074f02-de79-95e1-d03d-62e843f9c691@secunet.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: alsa-devel@alsa-project.org, tiwai@suse.com
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

Hi,

On Thu, 17 Sep 2020, Philipp Leskovitz wrote:

> [1.] One line summary of the problem:
> 
> A page fault occurs when the sound driver is loaded.
> 
> [2.] Full description of the problem/report:
> 
> A page fault occurs when the sound driver for Intel Commet-Lake platform
> is loaded. This happens e.g. on Lenovo ThinkPad X13 and T14 at startup
> and version 1.4.3 of intel-sof-firmware binaries
> (https://github.com/thesofproject/sof-bin/tree/stable-v1.4.3). Same
> result with version 1.5.1.

I think this has same rootcause as:
https://github.com/thesofproject/linux/issues/2311

I have a patch already and will be posting it to alsa-devel later today.

Br, Kai
