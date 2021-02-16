Return-Path: <SRS0=ZdwS=HS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AACC433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Feb 2021 11:27:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92DE064DEC
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Feb 2021 11:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92DE064DEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E976784A;
	Tue, 16 Feb 2021 12:26:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E976784A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613474844;
	bh=Uj+TdJaM4jzmHhz6HKRH1T/zJBsvIwEItVq9/cIsDNU=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CbCAtAtM8osXnCWqEfLskmu+OK+vqolXNzLWboI1udwRbqMNKluP0sj7M83oFYZCp
	 UhvEsecbsXS2YhmJzcrVaZ8dEWsW58skGKLmTylQrULzHSULF/raYIJzqPSAiAZ98P
	 PIiW6vOXIiiGD7m1Le+gsb7evBBxuAZ97kSlml0k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 76F50F80155;
	Tue, 16 Feb 2021 12:26:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 018A7F8015A; Tue, 16 Feb 2021 12:26:32 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2D826F8014D
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2021 12:26:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2D826F8014D
IronPort-SDR: hXZJN+tbbdmrvPFudnN3CfxSTMMWQS6DdKpEXZcKHnxnlrLVHMuKMN71/2/69UAQs+McPPxv0+
 HHu0WWcd4VXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9896"; a="246924530"
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; d="scan'208";a="246924530"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2021 03:26:18 -0800
IronPort-SDR: fthKNm5j7n80W8wzMqZ/coovCA8g/GQhcGzV3uuEXeidATm7/wC69+RouZh1civIBtpSdIy1LW
 lL0BNhunibcg==
X-IronPort-AV: E=Sophos;i="5.81,183,1610438400"; d="scan'208";a="399469127"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2021 03:26:17 -0800
Date: Tue, 16 Feb 2021 13:22:46 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 2/3] ASoC: soc-pcm: add soc_pcm_hw_update_chan()
In-Reply-To: <alpine.DEB.2.22.394.2102161024120.864696@eliteleevi.tm.intel.com>
Message-ID: <alpine.DEB.2.22.394.2102161308330.864696@eliteleevi.tm.intel.com>
References: <87tuqs90rl.wl-kuninori.morimoto.gx@renesas.com>
 <87r1lw90oo.wl-kuninori.morimoto.gx@renesas.com>
 <62f03ec8-7b9c-4550-d63d-cc50693e62fa@linux.intel.com>
 <alpine.DEB.2.22.394.2102142311050.864696@eliteleevi.tm.intel.com>
 <20210215204527.GC4378@sirena.org.uk>
 <alpine.DEB.2.22.394.2102160840420.864696@eliteleevi.tm.intel.com>
 <87zh04wkf4.wl-kuninori.morimoto.gx@renesas.com>
 <alpine.DEB.2.22.394.2102161024120.864696@eliteleevi.tm.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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

Hey,

On Tue, 16 Feb 2021, Kai Vehmanen wrote:

> On Tue, 16 Feb 2021, Kuninori Morimoto wrote:
> 
> > Current fixup patch always initialize hw at dpcm_set_fe_runtime()'s loop,
> > but I guess we need is initialize once.
> > 
> > How about this patch ?
> 
> I kicked off SOF CI with this patch applied. It should be all good, but 
> testing just in case.

tests results came back good:
https://sof-ci.01.org/linuxpr/PR2756/build5294/devicetest/

Let's cook up a proper patch for this.

Br, Kai
