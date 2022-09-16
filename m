Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CB3ECAAD8
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Sep 2022 06:10:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F20281943;
	Fri, 16 Sep 2022 08:09:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F20281943
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663308639;
	bh=J7O8Db5zychnn9pqpy/+HOfX2XnRu2bb9lxUdAMZF/4=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=asOi084wg5oEqfm3VpEk4At+O1dmiDlLG13ZyzsHpKOR0G9ThIPqgeK8t+6vGldAG
	 IPL1HO2BwI2sYsSTyF8Kq6tqMCB1W6e9FRPdm2pjhTYRbF5vs487ObXfdXxGaxP6XD
	 IFUqfaYhCU3RjZLoCwmzh500GX7I4QyKI8fcR/mw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 994B6F80165;
	Fri, 16 Sep 2022 08:09:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 008CBF800FE; Fri, 16 Sep 2022 08:09:46 +0200 (CEST)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5A02DF800FE
 for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2022 08:09:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5A02DF800FE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com
 header.b="dZShnQEU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; q=dns/txt; s=axis-central1; t=1663308585;
 x=1694844585;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=D0HPam3uXp20QwjRsF+rhFJxUO9gM3NmJTY0Xhv1DbQ=;
 b=dZShnQEUiU5hO+VH5OBsTtLXcYb935CFSYVgxaH2hddQuuWCim/Rz/P+
 eBT+ZwcmPtn6ZZsjrlyN1BcwP8qzi5GhrkmBUGhHGT5+L3ftms9yBrx1B
 gm2HyngSav0Qw1yAQ3Rp9wPsA0lTTqEft1Ef1ReDeKNAPlm9kzOwZbnTx
 ppCorHlrw/OjFIaJFmsnT1JGsj205if5HrA0700byMGpYbGtGI/Vujd3X
 zZtcBYcJzjKTkRLCmYsdEL2S1wXLkaSLZ2MhA+2de1MkJ8r+5kpEW/4cP
 WxFqNFHxJB8PJL0VDO9JYJmesdH533sEBAI3BY5JWVVC6InOymbLRO03/ A==;
Message-ID: <2c476092-f577-cc8d-580a-29975f9271f8@axis.com>
Date: Fri, 16 Sep 2022 08:09:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] ASoC: fsl_spdif: add ALSA event on dpll locked
Content-Language: en-US
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Robert Rosengren
 <Robert.Rosengren@axis.com>
References: <20220908133319.2149486-1-robert.rosengren@axis.com>
 <CAA+D8AOeSM4W1nS=oaWfFzYRqzgERh7_-sdh3wj+7iZthYm9Eg@mail.gmail.com>
From: Robert Rosengren <robertr@axis.com>
In-Reply-To: <CAA+D8AOeSM4W1nS=oaWfFzYRqzgERh7_-sdh3wj+7iZthYm9Eg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail04w.axis.com (10.20.40.10) To se-mail01w.axis.com
 (10.20.40.7)
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>, kernel <kernel@axis.com>,
 Fabio Estevam <festevam@gmail.com>
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

On 9/9/22 10:26, Shengjiu Wang wrote:
>
>     +      struct snd_soc_dai *dai;
>
>
> warning: Function parameter or member 'dai' not described in 
> 'fsl_spdif_priv'
> please add.
> Best regards
> Wang shengjiu

Thanks! Sorry for a bit late answer, but submitted new patch few days
ago with fix for this and the other remarks.

Best regards,
Robert


