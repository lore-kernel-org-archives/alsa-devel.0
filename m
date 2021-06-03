Return-Path: <SRS0=JknX=K5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DD9C47082
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Jun 2021 10:45:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E7E613BF
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Jun 2021 10:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E7E613BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF27416E7;
	Thu,  3 Jun 2021 12:45:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF27416E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622717150;
	bh=Q9GzYyO3MLOEF+16xEo7OOBPtskk5ro9mDed/HyHwWM=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tivRGt66WGF+JIcMBQ5xlE/9PamDzW05PV1u6s2bjJXGChd++dE0Ey4UGWIMixx28
	 QzAoXQ4hLDAovidcXaeisOp0mDYAStQn9ijn3FXCpHHWQ0bE7ZojxEW66r0DkKhJVP
	 prAY03N6aYKsZqX4cVtNvwJX+4xHBEmSDLcdMgkM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 588C1F80253;
	Thu,  3 Jun 2021 12:45:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0FBA3F80254; Thu,  3 Jun 2021 12:44:59 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0C86AF80103
 for <alsa-devel@alsa-project.org>; Thu,  3 Jun 2021 12:44:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0C86AF80103
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
 by youngberry.canonical.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <colin.king@canonical.com>)
 id 1lokqD-0000F1-Fr; Thu, 03 Jun 2021 10:44:45 +0000
Subject: Re: [PATCH][next] ASoC: rsnd: check for zero node count
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <20210602103722.12128-1-colin.king@canonical.com>
 <20210602112135.GF1955@kadam>
From: Colin Ian King <colin.king@canonical.com>
Message-ID: <569dcd35-8bd5-91eb-1d6a-e0ac6506586d@canonical.com>
Date: Thu, 3 Jun 2021 11:44:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210602112135.GF1955@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
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

On 02/06/2021 12:21, Dan Carpenter wrote:
> On Wed, Jun 02, 2021 at 11:37:22AM +0100, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The call to rsnd_node_count can potentially return a zero node count
>> so add a check for this corner case. (Note that the two other calls
>> to rsnd_node_count in the kernel perform this check, so I think it
>> justifies adding this). This avoids using a zero nr in a devm_kcalloc
>> call.
> 
> I don't have a problem with the patch, but really the code works fine
> as is.  A better commit message is:
> 
>   Most callers of_get_child_count() check that "nr" is non-zero so it
>   causes a static checker warning when we don't do that here.  This
>   doesn't cause a problem or a crash, but having zero SSUIes (What's
>   plural of ssui?) doesn't make sense either so let's add a check.

Good idea. I'll send a V2. Thanks Dan.

> 
> regards,
> dan carpenter
> 

