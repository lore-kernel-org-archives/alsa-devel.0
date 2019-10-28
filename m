Return-Path: <SRS0=lYxt=YV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8BBCA9EAF
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 02:16:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14902070B
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 02:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qMTsY7iL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14902070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8562B1919;
	Mon, 28 Oct 2019 03:15:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8562B1919
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572228997;
	bh=e1gbdHAJ8i6a2Ec0TN8j0pVxaA1lBEsEWXq+ybmu4L4=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qMTsY7iLwCkIaJ2IG1XTNcHoVeQbIf3p+vDz4M3MEpWqfGHyPArVOpueaUHtoCJ5r
	 ZDDp4qwJZjEp9RAUI5ivAbt20+vMXWOXMBgmu8VioFPdpPBDro3HU1jellYzbeQEdK
	 oHnX536c3fX0zibpjsRpwwxYj5LQKHObW4rN1gaU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 175CBF80228;
	Mon, 28 Oct 2019 03:15:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A0C18F80392; Mon, 28 Oct 2019 03:15:44 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF450F80228
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2019 03:15:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF450F80228
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Oct 2019 19:15:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,238,1569308400"; d="scan'208";a="189497387"
Received: from jestoute-mobl1.amr.corp.intel.com (HELO [10.251.144.224])
 ([10.251.144.224])
 by orsmga007.jf.intel.com with ESMTP; 27 Oct 2019 19:15:36 -0700
To: Navid Emamdoost <navid.emamdoost@gmail.com>
References: <20191027215330.12729-1-navid.emamdoost@gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <fb4fa7f3-fefb-e2d0-da4d-842396a7c251@linux.intel.com>
Date: Sun, 27 Oct 2019 21:15:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191027215330.12729-1-navid.emamdoost@gmail.com>
Content-Language: en-US
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pan Xiuli <xiuli.pan@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 kjlu@umn.edu, Liam Girdwood <lgirdwood@gmail.com>,
 Slawomir Blauciak <slawomir.blauciak@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, smccaman@umn.edu,
 linux-kernel@vger.kernel.org, emamd001@umn.edu
Subject: Re: [alsa-devel] [PATCH] ASoC: SOF: ipc: Fix memory leak in
 sof_set_get_large_ctrl_data
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



On 10/27/19 4:53 PM, Navid Emamdoost wrote:
> In the implementation of sof_set_get_large_ctrl_data() there is a memory
> leak in case an error. Release partdata if sof_get_ctrl_copy_params()
> fails.
> 
> Fixes: 54d198d5019d ("ASoC: SOF: Propagate sof_get_ctrl_copy_params() error properly")
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

May I ask which tool you used to find those issues, looks like we have a 
gap here?

> ---
>   sound/soc/sof/ipc.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sof/ipc.c b/sound/soc/sof/ipc.c
> index b2f359d2f7e5..086eeeab8679 100644
> --- a/sound/soc/sof/ipc.c
> +++ b/sound/soc/sof/ipc.c
> @@ -572,8 +572,10 @@ static int sof_set_get_large_ctrl_data(struct snd_sof_dev *sdev,
>   	else
>   		err = sof_get_ctrl_copy_params(cdata->type, partdata, cdata,
>   					       sparams);
> -	if (err < 0)
> +	if (err < 0) {
> +		kfree(partdata);
>   		return err;
> +	}
>   
>   	msg_bytes = sparams->msg_bytes;
>   	pl_size = sparams->pl_size;
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
