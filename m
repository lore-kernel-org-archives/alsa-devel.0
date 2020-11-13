Return-Path: <SRS0=KFnC=ET=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D26C56202
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Nov 2020 20:35:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8046D2223C
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Nov 2020 20:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="c5yHAu53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8046D2223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD8E018B3;
	Fri, 13 Nov 2020 21:34:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD8E018B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605299742;
	bh=GVPFcwOeLMBcvV7E63Seqm9gx5VHEDhIdXKyh1wt800=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c5yHAu53Ho82zYJ4FUrbBNMfTfypX9x6uRtSoBrWCdHjfEMRdSzPGEJ+JIvmajoGr
	 X+hF+2FPxBYc2rapZXSjuRGVmllkAgKWAOY2ZKulloB1NqPLBFIni/6rE9RUM2Pc7E
	 xwhwE/S3ZsIjTF04TwThFVzHySGQTDSWvietDOaE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 620E3F801F5;
	Fri, 13 Nov 2020 21:34:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CC95BF8020C; Fri, 13 Nov 2020 21:34:49 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 42D11F800D1
 for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2020 21:34:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42D11F800D1
IronPort-SDR: 9f8+3WDkZafXmAiC5Q3Vd2rwa6/jnCUVTCgnXrPvuV9kZ0eO12EiIHNEjIhN8efQ6Jb3Vup6E5
 58Y+SOeDqI9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9804"; a="170700353"
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; d="scan'208";a="170700353"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2020 12:34:38 -0800
IronPort-SDR: O01dYxwLvVP8tSXSX07hP1EV/J4JfX9xKrgYhfKugfAgBs58lf2aixrfz4x5SMIgmp59m4N4/f
 ceCfKMCBwEdA==
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; d="scan'208";a="542792043"
Received: from maaghaza-mobl.amr.corp.intel.com ([10.212.113.233])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2020 12:34:37 -0800
Message-ID: <393c21beb01e2c3a11f3f606f8ec9c012fdcbc45.camel@linux.intel.com>
Subject: Re: [PATCH v2 00/12] ASoC: soc-component: add snd_soc_component_xxx()
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown
 <broonie@kernel.org>
Date: Fri, 13 Nov 2020 12:34:36 -0800
In-Reply-To: <87h7pt7v93.wl-kuninori.morimoto.gx@renesas.com>
References: <87h7pt7v93.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
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

On Fri, 2020-11-13 at 13:14 +0900, Kuninori Morimoto wrote:
> Hi Mark
> 
> These are v2 of snd_soc_component_compr_xxx() function patches.
> I think component related function should be implemented at
> soc-component.c, otherwise it is confusable to read.
> These are for it.
> 
> v1 -> v2
> 	- fixup function return timing on
> 		snd_soc_component_compr_get_params()
> 		snd_soc_component_compr_get_metadata()
> 
> 	- use mutex at compr side on
> 		snd_soc_component_compr_get_caps()
> 		snd_soc_component_compr_get_codec_caps()
> 		snd_soc_component_compr_copy()
> 
> Link: 
> https://lore.kernel.org/r/878sb78ac4.wl-kuninori.morimoto.gx@renesas.com
> 
> Kuninori Morimoto (12):
>   ASoC: soc-component: add snd_soc_component_compr_open()
>   ASoC: soc-component: add snd_soc_component_compr_free()
>   ASoC: soc-component: add snd_soc_component_compr_trigger()
>   ASoC: soc-component: add snd_soc_component_compr_set_params()
>   ASoC: soc-component: add snd_soc_component_compr_get_params()
>   ASoC: soc-component: add snd_soc_component_compr_get_caps()
>   ASoC: soc-component: add snd_soc_component_compr_get_codec_caps()
>   ASoC: soc-component: add snd_soc_component_compr_ack()
>   ASoC: soc-component: add snd_soc_component_compr_pointer()
>   ASoC: soc-component: add snd_soc_component_compr_copy()
>   ASoC: soc-component: add snd_soc_component_compr_set_metadata()
>   ASoC: soc-component: add snd_soc_component_compr_get_metadata()

LGTM. Thanks, Morimoto-san.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

