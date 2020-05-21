Return-Path: <SRS0=D4yB=7D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FB6C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 21 May 2020 18:26:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3611520823
	for <alsa-devel@archiver.kernel.org>; Thu, 21 May 2020 18:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZD4vX/Yh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3611520823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 89654183A;
	Thu, 21 May 2020 20:25:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 89654183A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590085582;
	bh=B4ShNZgO5goC/dtaFT/PFGIWmqsvBiKHxtDUUxMlllc=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZD4vX/YhYO8eS5FSSJwKvW/1gfR+sLONKAlSrYK5eC+9PZ7oh5otsa4zzGEW8u+jm
	 mQIt3uaiNzH1dn97CyG5tPFYjmqmZ6OW5m7565cx3+M04vPkEbjHxkXMPCff6juW1S
	 84brUdHH8P8oeb89yO0N75t8UV49QobJSKgkC0IM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B814F801A3;
	Thu, 21 May 2020 20:25:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BF931F801D8; Thu, 21 May 2020 20:25:29 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 881EAF80111
 for <alsa-devel@alsa-project.org>; Thu, 21 May 2020 20:25:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 881EAF80111
IronPort-SDR: i64rkLd26RRFg1PkZNrOUCI+zFHKMJ6TH7IzJQ6HEX6ED8IZQWdcYmnAcoTJNWIqV+DS12kmM8
 3Ytn4ZnDfUrA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2020 11:25:18 -0700
IronPort-SDR: ihzWGxkf5YDH3NuBOKUq0UMm3JkoogHCO8ioRw1kXo+aK2z0s0uhdJOyijtX/MxFIqdnpnVUGw
 biR0wSiQ2NYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,418,1583222400"; d="scan'208";a="466895369"
Received: from dclifton-mobl.amr.corp.intel.com ([10.251.134.247])
 by fmsmga005.fm.intel.com with ESMTP; 21 May 2020 11:25:18 -0700
Message-ID: <7626c159ca13b65d6caf87f7d195ade69586e4ff.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/7] ASoC: add soc-link
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown
 <broonie@kernel.org>
Date: Thu, 21 May 2020 11:25:17 -0700
In-Reply-To: <874ksa59wc.wl-kuninori.morimoto.gx@renesas.com>
References: <874ksa59wc.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
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

On Thu, 2020-05-21 at 10:55 +0900, Kuninori Morimoto wrote:
> Hi Mark
> 
> Current ALSA SoC is handling dai_link related operation,
> but it is implmemented directly without using function/macro,
> and at random place.
> 
> This v2 patch-set creates new snd_soc_link_xxx() functions
> which handles dai_link related operation,
> and implmement these at new soc-link.c.
> 
> v1 -> v2
> 	- #include <sound/soc-link.h> is added on each c source file
> 	  instead of soc.h
> 	- not have extra error message after snd_soc_link_xxx(),
> 	  because it already indicate it via snc_link_ret()
> 	- snd_soc_link_compr_xxx() doesn't have rtd parameter,
> 	  because it can be created from cstream
> 
> Link: 
> https://lore.kernel.org/r/877dx868op.wl-kuninori.morimoto.gx@renesas.com
> 
> Kuninori Morimoto (7):
>   ASoC: add soc-link.c
>   ASoC: soc-link: move soc_rtd_xxx()
>   ASoC: soc-link: remove unneeded parameter from snd_soc_link_xxx()
>   ASoC: soc-link: add snd_soc_link_be_hw_params_fixup()
>   ASoC: soc-link: add snd_soc_link_compr_startup()
>   ASoC: soc-link: add snd_soc_link_compr_shutdown()
>   ASoC: soc-link: add snd_soc_link_compr_set_params()

The series LGTM except for the missing include for soc-link.h in soc-
link.c. Thanks, Morimoto-san.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

