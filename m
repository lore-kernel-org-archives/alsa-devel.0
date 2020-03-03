Return-Path: <SRS0=CIz3=4U=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8F1C3F2C6
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Mar 2020 11:40:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B19FB2073D
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Mar 2020 11:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IZ2MHEjM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19FB2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 149EF166E;
	Tue,  3 Mar 2020 12:40:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 149EF166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583235650;
	bh=UXMhDI/Ql+Furl3D/dbvU82sBdWIKg63ndO+GYoJ1Hg=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IZ2MHEjMOOb/EyzqndR81VYRGSrrrt8akudv1h2QhtKvYJpGqIPwQmo2/P0pTPmuY
	 3GCavgKLLCkYZzagFT1Jx46/f3MM7So74BlSxlQclD5uvN3RBhWP3OlR93A9uaNYTG
	 ehsiR86otjLNzUkm0PYQzO5XMO+wW0flaBtckEdI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 96FF2F8012D;
	Tue,  3 Mar 2020 12:39:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DE415F8025F; Tue,  3 Mar 2020 12:39:56 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1E69CF80131
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2020 12:39:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1E69CF80131
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Mar 2020 03:39:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; d="scan'208";a="240044033"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga003.jf.intel.com with ESMTP; 03 Mar 2020 03:39:46 -0800
Date: Tue, 3 Mar 2020 13:39:45 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] ASoC: SOF: Fix snd_sof_ipc_stream_posn()
In-Reply-To: <20200303101858.ytehbrivocyp3cnf@kili.mountain>
Message-ID: <alpine.DEB.2.21.2003031321410.2957@eliteleevi.tm.intel.com>
References: <20200303101858.ytehbrivocyp3cnf@kili.mountain>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, kernel-janitors@vger.kernel.org,
 Keyon Jie <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>,
 Slawomir Blauciak <slawomir.blauciak@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
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

Hi, 

On Tue, 3 Mar 2020, Dan Carpenter wrote:

> We're passing "&posn" instead of "posn" so it ends up corrupting
> memory instead of doing something useful.
[...]
>  	/* send IPC to the DSP */
>  	err = sof_ipc_tx_message(sdev->ipc,
> -				 stream.hdr.cmd, &stream, sizeof(stream), &posn,
> +				 stream.hdr.cmd, &stream, sizeof(stream), posn,
>  				 sizeof(*posn));

ack, thanks, this is clearly wrong. This function is not used by current 
platforms, so the bug has gone unnnoticed. Most platforms either rely on 
direct MMIO queries of the DSP position, or the periodic position updates 
DSPs send after each ALSA period. This function for host to query DSP 
position via IPC is thus not used, although it's part of the generic audio
DSP IPC interface.

For the SOF folks in CC, I wonder should we keep this function at all? 

Anyways, that's probably a longer discussion, so while it's there, 
the code should be correct, so for the patch:
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Br, Kai
