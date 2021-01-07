Return-Path: <SRS0=NlLR=GK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69042C433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Jan 2021 11:50:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB4FB2333F
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Jan 2021 11:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4FB2333F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F334167C;
	Thu,  7 Jan 2021 12:49:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F334167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610020210;
	bh=cNnWtonx4aB7cXFOitm9RswpNoIMzVzXIHEibUjXtO8=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q4R3KKYPbQesQX+x0DABO2WjTW3icCU2L7bd1UezHblhWWN3oQI48d2b3ik9OvoUn
	 qbCqqNmkrg1qt7FhCITelfgvh7altyvVl0WIV+xEuoGW/4TOzLFnWTKihkySOJezx6
	 KC7dGvPbkkdA5bOjTgklen0apwtcfirsOGmABUF4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BBAADF801F5;
	Thu,  7 Jan 2021 12:49:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E7A15F80258; Thu,  7 Jan 2021 12:49:12 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 45453F800FD;
 Thu,  7 Jan 2021 12:49:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 45453F800FD
IronPort-SDR: fZihJCkEhnszCtJC6XQIYDXJpGtdtfqIc2LBzwtpayEsoaCswCUqBAQVWHfknyFTgiSKfhXnFx
 8uK/VW9BiiIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9856"; a="165108474"
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; d="scan'208";a="165108474"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2021 03:48:57 -0800
IronPort-SDR: Vp/wh3zZhv7tbV1si8fHMXjBU0nZMi1HsmC9tCjFgdrmDWGL7Ib0sQwf2xq8S2yEg2qqO2+yUM
 yO8B8xcUuL1Q==
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; d="scan'208";a="379688763"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2021 03:48:53 -0800
Date: Thu, 7 Jan 2021 13:45:55 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] ASoC: SOF: Intel: avoid reverse module dependency
In-Reply-To: <CAK8P3a1rp3d_H4uFN1hy_nASYTCZouH3x8ZhQ1JVvMYr+LsK_g@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2101071303040.864696@eliteleevi.tm.intel.com>
References: <CAK8P3a0PXXHXLK36SB_4eia6z0u3nbBPanATwZEhposKOScqcw@mail.gmail.com>
 <20210105190808.613050-1-arnd@kernel.org>
 <CAK8P3a1rp3d_H4uFN1hy_nASYTCZouH3x8ZhQ1JVvMYr+LsK_g@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Takashi Iwai <tiwai@suse.de>,
 "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, YueHaibing <yuehaibing@huawei.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, sound-open-firmware@alsa-project.org
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

Hi Arnd,

On Wed, 6 Jan 2021, Arnd Bergmann wrote:

> On Tue, Jan 5, 2021 at 8:07 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > Change it to use the normal probe order of starting with a specific
> > device in a driver, turning the sof-acpi-dev.c driver into a library.
> 
> There were a couple of build failures introduced by this version. I have
> one that does build now, and can post that if others think this is the
> direction they want to go.

thanks for the follow-up. We have many SOF maintainers still out on 
holidays this week, so let's give some time for people to digest. This is 
certainly a big change. The version you posted is already sufficient to 
describe the idea for sure.

Br, Kai
