Return-Path: <SRS0=0KZO=YC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE96ECE58D
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Oct 2019 15:40:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D632721848
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Oct 2019 15:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eiKny57X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D632721848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1852A1675;
	Wed,  9 Oct 2019 17:39:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1852A1675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570635609;
	bh=tacDbGdR7TCRIyRuIWeJg5zYrrMayG+imO7i+Mc+hqo=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eiKny57XdAjHVaw520yGjP8rIn/aYcOMfRbZdfeuAQcTWFMJkZsG3vuQJ0JX/SCrQ
	 9+h95cGauyNxrSuncYr40umAhnQgBjoAB5rbr9YTBK9jaL7By162KBNu0zbuYEAPTV
	 6BLblwnxxa4ro8VLVcboHmoKJT3stmKDzHQRpWiY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2F2ECF8060E;
	Wed,  9 Oct 2019 17:37:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C7155F80610; Wed,  9 Oct 2019 17:37:37 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 84BA9F800AE
 for <alsa-devel@alsa-project.org>; Wed,  9 Oct 2019 17:37:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 84BA9F800AE
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Oct 2019 08:37:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,276,1566889200"; d="scan'208";a="223620854"
Received: from mmahler-mobl1.amr.corp.intel.com (HELO [10.251.30.188])
 ([10.251.30.188])
 by fmsmga002.fm.intel.com with ESMTP; 09 Oct 2019 08:37:31 -0700
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Mark Brown <broonie@kernel.org>
References: <87r23mgxl7.wl-kuninori.morimoto.gx@renesas.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <2a28be44-91ad-c140-062b-4d14982042e9@linux.intel.com>
Date: Wed, 9 Oct 2019 09:20:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87r23mgxl7.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
Subject: Re: [alsa-devel] Question about DPCM FE vs BE
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



On 10/9/19 2:57 AM, Kuninori Morimoto wrote:
> 
> Hi ALSA ML
> 
> In my understanding, DPCM needs FE and BE.
> And, one FE can have multiple BE, and one BE can have multiple FE.
> 
> My question this time is that one snd_soc_pcm_runtime can be both
> FE and BE in the same time (= Sometimes FE, sometimes BE) ??
> 
> In my understanding, it never happen.
> But, is this correct ?

It is my understanding that the current code would not support a case 
where a FE is also a BE.

That said, do we want to preclude it? at some point we probably want to 
get rid of the FE/BE distinction and have 'domains' that can be chained. 
So it may not be a good thing to cast a restriction in stone. If at some 
point we need a list of upstream/downstream clients maybe we should keep 
this.

> 
> I'm asking because do we need .be_clients/.fe_clients ?
> If one pcm_runtime can't be FE / BE in the same time,
> just .clients is enough I think.
> 
> 	static int dpcm_be_connect(...)
> 	{
> 		...
> -		list_add(&dpcm->list_be, &fe->dpcm[stream].be_clients);
> -		list_add(&dpcm->list_fe, &be->dpcm[stream].fe_clients);
> +		list_add(&dpcm->list_be, &fe->dpcm[stream].clients);
> +		list_add(&dpcm->list_fe, &be->dpcm[stream].clients);
> 		...
> 	}
> 
> 
> Thank you for your help !!
> Best regards
> ---
> Kuninori Morimoto
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
