Return-Path: <SRS0=OACP=ZY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5710C432C0
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Dec 2019 20:40:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0F3D2073C
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Dec 2019 20:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Q/ABZ9v8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F3D2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B09884A;
	Mon,  2 Dec 2019 21:39:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B09884A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575319231;
	bh=5J0vG4qxw2U2jBcbsJygYx4eoHh6QTOLj3pbKTOB17k=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q/ABZ9v82hl6G5hSSPGNpaxzfoyVs9S2ugtvpKSmYuFESqTE8wjvz47UAySODMbs+
	 lLqYls+1nfLZiIUm8RGHpKc8pbNUsOAYoup4iznuHz3DPSeYi+LpAAybpE5blXJodJ
	 ysrmEaqDW8ciSsdpeWCaccASS6BWd7/m8Gxry/no=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F278F801D9;
	Mon,  2 Dec 2019 21:39:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DD961F80214; Mon,  2 Dec 2019 21:39:38 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 05283F800F0
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2019 21:39:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 05283F800F0
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Dec 2019 12:39:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,270,1571727600"; d="scan'208";a="204709999"
Received: from rniessen-mobl3.amr.corp.intel.com (HELO [10.251.5.154])
 ([10.251.5.154])
 by orsmga008.jf.intel.com with ESMTP; 02 Dec 2019 12:39:31 -0800
To: alsa-devel@alsa-project.org
References: <20191126142815.21856-1-pierre-louis.bossart@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d86b3869-274c-e96e-69d6-9122dc044ae3@linux.intel.com>
Date: Mon, 2 Dec 2019 14:39:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191126142815.21856-1-pierre-louis.bossart@linux.intel.com>
Content-Language: en-US
Cc: tiwai@suse.de, broonie@kernel.org
Subject: Re: [alsa-devel] [PATCH 00/10] ASoC: SOF: initial cleanup for DT
 and multi-client support
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


> 
> Daniel Baluta (2):
>    ASoC: SOF: Make creation of machine device from SOF core optional

This patch conflicts with Jaroslav's "[PATCH] ASoC: intel/skl/hda - 
export number of digital microphones via control components"

I will resubmit a v2 when Jaroslav's patches are available in Mark's 
tree. For SOF development Jaroslav's changes were already applied and 
the conflict solved already.

>    ASoC: SOF: Remove unused drv_name in sof_pdata
> 
> Ranjani Sridharan (8):
>    ASoC: SOF: topology: remove snd_sof_init_topology()
>    ASoC: SOF: core: modify the signature for snd_sof_create_page_table
>    ASoC: SOF: core: move check for runtime callbacks to core
>    ASoC: SOF: Introduce default_fw_filename member in sof_dev_desc
>    ASoC: SOF: partition audio-related parts from SOF core
>    ASoC: SOF: intel: hda: Modify signature for hda_codec_probe_bus()
>    ASoC: SOF: remove nocodec_fw_filename
>    ASoC: SOF: nocodec: Amend arguments for sof_nocodec_setup()
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
