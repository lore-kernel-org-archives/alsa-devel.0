Return-Path: <SRS0=t/pq=4B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4670C3B18C
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Feb 2020 17:16:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 421B7206D7
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Feb 2020 17:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ogbdqw4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 421B7206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8DD9116CF;
	Thu, 13 Feb 2020 18:15:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8DD9116CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581614173;
	bh=KPU7c2iwvaadITdyxvPQdU53KsS5TWN7qdTxoVGEJEc=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ogbdqw4nbO/pJONBtWNvXB330tHNaNf0rNCrydgv7ggJ5r/2rze0VHkH3WW1OJPp3
	 kmLrOBLd2hqC+f1hYvBSwiHFxvCMjlyMHEt360nTxlrgSicLJHNaK+CFuEBlojCere
	 /yR4dQukSwMrvNQaXcLyU432aRPiX0e1iMqs2654=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F156CF8013E;
	Thu, 13 Feb 2020 18:15:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 22063F80145; Thu, 13 Feb 2020 18:15:22 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DD439F800F0
 for <alsa-devel@alsa-project.org>; Thu, 13 Feb 2020 18:15:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD439F800F0
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Feb 2020 09:15:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,437,1574150400"; d="scan'208";a="432730286"
Received: from pjshinde-mobl.amr.corp.intel.com ([10.255.69.176])
 by fmsmga005.fm.intel.com with ESMTP; 13 Feb 2020 09:15:15 -0800
Message-ID: <52cbcac8705fef8409b2bd7d759dc0d43c219b5a.camel@linux.intel.com>
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown
 <broonie@kernel.org>
Date: Thu, 13 Feb 2020 09:15:15 -0800
In-Reply-To: <871rqzru2y.wl-kuninori.morimoto.gx@renesas.com>
References: <87blq3ru4w.wl-kuninori.morimoto.gx@renesas.com>
 <871rqzru2y.wl-kuninori.morimoto.gx@renesas.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
Subject: Re: [alsa-devel] [PATCH 07/10] ASoC: soc-pcm: add
 snd_soc_dpcm_can_be() and remove duplicate code
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

On Thu, 2020-02-13 at 13:26 +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Below functions are doing very similar things, the difference is
> only used state.
> 
> 	snd_soc_dpcm_can_be_free_stop()
> 	snd_soc_dpcm_can_be_params()
> 
> This patch adds common snd_soc_dpcm_can_be(), and use it from
> snd_soc_dpcm_can_be_free_stop() / snd_soc_dpcm_can_be_params().
> This can reduce duplicate code.

Morimoto-san,

Only minor but does it make it a bit more intuitive to call this new
function snd_soc_dpcm_check_state() or something equivalent maybe?

Thanks,
Ranjani

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
