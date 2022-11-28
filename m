Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D52C433FE
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Nov 2022 14:42:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 04E4216CB;
	Mon, 28 Nov 2022 15:42:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 04E4216CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669646574;
	bh=yns+R2HE+8EQwUjsmVT40C2yEbZABretYQlqqfAW/0c=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hijhGbkuW1Yi2brsU82MkEsUV94jVIDdJywB+ld10S5AeXkJTtv43y9udq2UkAjV+
	 fIf5lsX9Gulg2vX3HCTGaVQ0y6mpStBvIVQPtBU6F7qA5X7bmedl9JXg4DjXtUBhvp
	 44iRrc/Gd7205MJ48SSSdF5cW+Bi2Z3pJq4ZAYYY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 93A92F8027D;
	Mon, 28 Nov 2022 15:42:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2AB0DF8020D; Mon, 28 Nov 2022 15:42:01 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B644FF80166;
 Mon, 28 Nov 2022 15:41:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B644FF80166
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="Djh0oCHL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1669646519; x=1701182519;
 h=date:from:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=yns+R2HE+8EQwUjsmVT40C2yEbZABretYQlqqfAW/0c=;
 b=Djh0oCHLdwQPCws+TX+gW9l0//4qnE65t8biAQWy3x9hAvUV8D7RX+CR
 gcblladURAqAJXpBXfRRlO5tREfJNBKssstN+SlAXqdF9z7Ec4aqy61o6
 FwBiyuZwEhbYqGG4QOHpuyApzrX01sa9/DeyByq2w77iiId+yaeCDMBGc
 Q04FBn+TvYyc9nEVpphMajwaJz7h2aD2etlqjZ1PF7LSsnTf6Q29YFrA6
 oYqx41TZLp4K5FGRGkdW2YeWDRtlF0V3TVhSoE/yowwgTMTqIOw40UPqy
 c+54x4sh+5v9KSG2VeRg/FSFxN+5Cme5jwAf2Yhvzos1J9KQqHqOaEPmq Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="295232813"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; d="scan'208";a="295232813"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Nov 2022 06:41:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="972284888"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; d="scan'208";a="972284888"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Nov 2022 06:41:49 -0800
Date: Mon, 28 Nov 2022 16:41:33 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Ricardo Ribalda <ribalda@chromium.org>
Subject: Re: [PATCH v5] ASoC: SOF: Fix deadlock when shutdown a frozen
 userspace
In-Reply-To: <20221127-snd-freeze-v5-0-4ededeb08ba0@chromium.org>
Message-ID: <alpine.DEB.2.22.394.2211281629120.3532114@eliteleevi.tm.intel.com>
References: <20221127-snd-freeze-v5-0-4ededeb08ba0@chromium.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Alsa-devel <alsa-devel@alsa-project.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, stable@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, linux-kernel@vger.kernel.org,
 sound-open-firmware@alsa-project.org
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

On Mon, 28 Nov 2022, Ricardo Ribalda wrote:

> During kexec(), the userspace is frozen. Therefore we cannot wait for it
> to complete.
> 
> Avoid running snd_sof_machine_unregister during shutdown.
[...]
>  	/*
> -	 * make sure clients and machine driver(s) are unregistered to force
> -	 * all userspace devices to be closed prior to the DSP shutdown sequence
> +	 * make sure clients are unregistered prior to the DSP shutdown
> +	 * sequence.
>  	 */
>  	sof_unregister_clients(sdev);
>  
> -	snd_sof_machine_unregister(sdev, pdata);
> -
>  	if (sdev->fw_state == SOF_FW_BOOT_COMPLETE)

this is problematic as removing that machine_unregister() call will (at 
least) bring back an issue on Intel platforms (rare problem hitting S5 on 
Chromebooks).

Not sure how to solve this, but if that call needs to be removed 
(unsafe to call at shutdown), then we need to rework how SOF 
does the cleanup.

Br, Kai
