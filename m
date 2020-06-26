Return-Path: <SRS0=sUwr=AH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE43C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:36:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED9F120775
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TgHC93Nl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="LYdiuUMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9F120775
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 75D8C166A;
	Fri, 26 Jun 2020 12:36:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 75D8C166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593167810;
	bh=gYfg+9lmRiJaX/aPUWL9VfVp+XogdHqLLUWMTZy3siU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TgHC93NleRbEnLpuk/7zmVJL4Hsqe4SNa5p6jhNSbFjESHevbQhBCB4vmNoHBfXGQ
	 e4/9uUod6x6KvbbQUydUxMQoOUgBbODjoF2b4ckEFKxi+qjN7zuWEFJ84icFcVgBNn
	 jQGWYa5Th/L3uTpji9JL2jl30US+/l3KoaQ+Y1k4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 04E1AF8015A;
	Fri, 26 Jun 2020 12:36:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0B8B4F8015B; Fri, 26 Jun 2020 12:35:59 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 70D65F80096
 for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2020 12:35:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 70D65F80096
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="LYdiuUMr"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05QAYSJM000369; Fri, 26 Jun 2020 05:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=JpR8L4CQUgN3gWJ+RaStLce3t5Jm419G1nKBeC1oJcI=;
 b=LYdiuUMrfDaOxrq9RFIavsXd8d3eBK5U5J1GMoRbtPaXUpNddjU9FiIIRBrttJTfgYza
 K+cHaJmDpDfJg4s2hadfw9LJF5NBa2Y/6MD2zoB2eJdeWCJD4/CjdsNhNthGQWvzyogV
 r/6U11E0AMnXJ7qOvaZBPTedTUICu4Wo+YwASh3lvsrJFoPKsx/94+/WGy69jMyVr3xZ
 XHPB0qmAMkNahGh8uFIYYGTNw8NSJLYa4lUthPkW7X0RhwZ5h/5VGfFOwae9vjvwnbC/
 9tHzZFCziFu26nQD5ERgs0z95Kb+UQMA56J5A3b6nU0dkQrnlam7rAxP6Zj76Xb5fR2e FA== 
Authentication-Results: ppops.net;
 spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 31uus3c3ww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 26 Jun 2020 05:35:51 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 26 Jun
 2020 11:35:49 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 26 Jun 2020 11:35:49 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0D54C2C5;
 Fri, 26 Jun 2020 10:35:49 +0000 (UTC)
Date: Fri, 26 Jun 2020 10:35:49 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v3 3/3] ALSA: compress: fix partial_drain completion state
Message-ID: <20200626103549.GB71940@ediswmail.ad.cirrus.com>
References: <20200625154651.99758-1-vkoul@kernel.org>
 <20200625154651.99758-4-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200625154651.99758-4-vkoul@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com
 include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 spamscore=0 cotscore=-2147483648
 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006260077
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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

On Thu, Jun 25, 2020 at 09:16:51PM +0530, Vinod Koul wrote:
> On partial_drain completion we should be in SNDRV_PCM_STATE_RUNNING
> state, so set that for partially draining streams in
> snd_compr_drain_notify() and use a flag for partially draining streams
> 
> While at it, add locks for stream state change in
> snd_compr_drain_notify() as well.
> 
> Fixes: f44f2a5417b2 ("ALSA: compress: fix drain calls blocking other compress functions (v6)")
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
> @@ -187,7 +189,15 @@ static inline void snd_compr_drain_notify(struct snd_compr_stream *stream)
>  	if (snd_BUG_ON(!stream))
>  		return;
>  
> -	stream->runtime->state = SNDRV_PCM_STATE_SETUP;
> +	mutex_lock(&stream->device->lock);
> +	/* for partial_drain case we are back to running state on success */
> +	if (stream->partial_drain) {
> +		stream->runtime->state = SNDRV_PCM_STATE_RUNNING;
> +		stream->partial_drain = false; /* clear this flag as well */
> +	} else {
> +		stream->runtime->state = SNDRV_PCM_STATE_SETUP;
> +	}
> +	mutex_unlock(&stream->device->lock);

You have added locking here in snd_compr_drain_notify but....
>  
>  	wake_up(&stream->runtime->sleep);
>  }
> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> index e618580feac4..1c4b2cf450a0 100644
> --- a/sound/core/compress_offload.c
> +++ b/sound/core/compress_offload.c
> @@ -803,6 +803,9 @@ static int snd_compr_stop(struct snd_compr_stream *stream)
>  
>  	retval = stream->ops->trigger(stream, SNDRV_PCM_TRIGGER_STOP);
>  	if (!retval) {
> +		/* clear flags and stop any drain wait */
> +		stream->partial_drain = false;
> +		stream->metadata_set = false;
>  		snd_compr_drain_notify(stream);

that can be called from snd_compr_stop here which is already
holding the lock resulting in deadlock.

Thanks,
Charles
