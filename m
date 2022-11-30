Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5917EC433FE
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Nov 2022 15:55:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8060B16BA;
	Wed, 30 Nov 2022 16:54:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8060B16BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669823717;
	bh=DepN27OpZlgbeuoWYTFKVyj3/uCClQNbsv2Ccqz0OMY=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nXJRS4cLWgvOT9SaVK17tMsMkjMdGs1eREMOtVQq6sKTyUxmNvgp9/uaxkke5viWu
	 XGF876+t/uH4gRKwJMAQSt6HrulqQ/9em2Vdj6iOkVvzaSOrtryraDAfd5nQz9H+QT
	 7y5//Eem2xf16HUoKIMeA5p9ZTuCaBSp0pcD+Akw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 22D07F800B6;
	Wed, 30 Nov 2022 16:54:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CCC98F80118; Wed, 30 Nov 2022 16:54:25 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3CDE7F80118;
 Wed, 30 Nov 2022 16:54:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3CDE7F80118
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="PeBuwNSI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1669823663; x=1701359663;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=DepN27OpZlgbeuoWYTFKVyj3/uCClQNbsv2Ccqz0OMY=;
 b=PeBuwNSI45uLHCfCCNbBQUFRLcmlD3g+1BAt2WYFvc+SC4qBx8w24NOg
 JTSYhXLOezLUzsfA0fy9jN/N9HG5vXAUF95GFYGh8IsSqlTxNDA5tP7Bq
 Uqcwcrn9l1CoOGEDO2vWTNvtr5Qbxp7lVt5wpQSsWuF56N0pjKLt/w35E
 R50u152D9KiHN3nqM/FXlEyBX0gHAoIcaCaG86uHuKVfH4yC1prtvm14f
 Gq1tWEWCDiRWH/CXTk6P/rtC7REL2Gr7lvzG79Wy3C+MXRswRD/pY4Ip1
 SYWR11VZ2bcIIG3OYiw+q+8v/20F+xkBIiEENHv5AtgM+pottyZbE6+4y w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="295126306"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; d="scan'208";a="295126306"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2022 07:54:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="707693261"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; d="scan'208";a="707693261"
Received: from schaud2-mobl1.amr.corp.intel.com (HELO [10.209.164.68])
 ([10.209.164.68])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2022 07:54:12 -0800
Message-ID: <62a3dbbd-3144-d560-17de-cada6a34502b@linux.intel.com>
Date: Wed, 30 Nov 2022 09:54:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v6 2/2] ASoC: SOF: Fix deadlock when shutdown a frozen
 userspace
Content-Language: en-US
To: Ricardo Ribalda <ribalda@chromium.org>,
 Chromeos Kdump <chromeos-kdump@google.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Eric Biederman <ebiederm@xmission.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Mark Brown <broonie@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, Jaroslav Kysela
 <perex@perex.cz>, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>, Steven Rostedt <rostedt@goodmis.org>
References: <20221127-snd-freeze-v6-0-3e90553f64a5@chromium.org>
 <20221127-snd-freeze-v6-2-3e90553f64a5@chromium.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221127-snd-freeze-v6-2-3e90553f64a5@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
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



On 11/30/22 09:47, Ricardo Ribalda wrote:
> During kexec(), the userspace is frozen. Therefore we cannot wait for it
> to complete.
> 
> Avoid running snd_sof_machine_unregister during shutdown.

That's not what you are doing below - you only unregister clients
conditionally.

I don't know if that's a stale commit message and can't reconcile it
either with the initial discussions in this thread where we were
referring to snd_card_disconnect(), etc?

Confused.

> @@ -484,7 +485,8 @@ int snd_sof_device_shutdown(struct device *dev)
>  	 * make sure clients and machine driver(s) are unregistered to force
>  	 * all userspace devices to be closed prior to the DSP shutdown sequence
>  	 */
> -	sof_unregister_clients(sdev);
> +	if (!kexec_with_frozen_processes())
> +		sof_unregister_clients(sdev);
>  
>  	snd_sof_machine_unregister(sdev, pdata);
>  
> 
