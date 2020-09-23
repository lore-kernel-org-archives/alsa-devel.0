Return-Path: <SRS0=GKc0=DA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFDCC2D0A8
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:26:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D55C21BE5
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MXEuhOLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D55C21BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E0541721;
	Wed, 23 Sep 2020 19:25:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E0541721
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600881963;
	bh=LrbiITwnFukvkeu8EoEkNdkN/jEaQUGXlIX2Hc8nurI=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MXEuhOLp4aiVUC1x8XCPKBsF1o9w0+nEfHzFemd+lI1UD4AzPNGJPLc3YiGbA8eHO
	 fY+SqDSxJWHNNbw59WT6kiv2hHVX+NUqd7bOCEZQf2QeoQfNjOeUXtLfdNM1P0IJLM
	 48zP6hZn+Zf2VYHDu0RmQ8mIJXstwHNN2rzlCgVA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DD69AF80162;
	Wed, 23 Sep 2020 19:25:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D8BF4F80171; Wed, 23 Sep 2020 19:25:10 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6086AF8015F
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2020 19:24:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6086AF8015F
IronPort-SDR: 3t0sWglaPRDtVeeU3u+Kd7dgHUwuwWHaOPhwj0TaAabeQUI146gg30fCt3j0mX+13Rpj1a6T6o
 Sl3c+atuEv1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="140431219"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; d="scan'208";a="140431219"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2020 10:24:58 -0700
IronPort-SDR: QcSHUbiHLtrUJQTxpIGThrJoc1Ms6vtfbh/XMmOFYDr+RUXDr4BucnrNZTTwoR+ZLUvz3OFWgn
 YeT6wxu2nuHw==
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; d="scan'208";a="486521553"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2020 10:24:55 -0700
Date: Wed, 23 Sep 2020 20:23:22 +0300 (EEST)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASOC: Intel: sof_sdw: restore playback functionality
 with max98373 amps
In-Reply-To: <20200923163657.GA46671@sirena.org.uk>
Message-ID: <alpine.DEB.2.22.394.2009232022140.3186@eliteleevi.tm.intel.com>
References: <20200923080514.3242858-1-kai.vehmanen@linux.intel.com>
 <20200923080514.3242858-2-kai.vehmanen@linux.intel.com>
 <20200923163657.GA46671@sirena.org.uk>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Keyon Jie <yang.jie@linux.intel.com>, pierre-louis.bossart@linux.intel.com,
 lgirdwood@gmail.com, ranjani.sridharan@linux.intel.com,
 Rander Wang <rander.wang@intel.com>, daniel.baluta@nxp.com
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

On Wed, 23 Sep 2020, Mark Brown wrote:

> On Wed, Sep 23, 2020 at 11:05:09AM +0300, Kai Vehmanen wrote:
> 
> > Fixes: 7eec07f389a60 ('ASOC: Intel: sof_sdw: add dailink .trigger callback')
> > Fixes: 5595f95c32650 ('ASOC: Intel: sof_sdw: add dailink .prepare and .hw_free callback').
> 
> I don't seem to have either of these commits, I think you meant
> ae3a3918edf57b and 06998d49bcac8a9 respectively?

d'oh, indeed, the patches had sof-dev commit-ids. Let me resend v2 
with the correct commits.

Br, Kai

