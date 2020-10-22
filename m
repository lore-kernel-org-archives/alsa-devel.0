Return-Path: <SRS0=uLsF=D5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CEAC388F2
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Oct 2020 03:37:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C7742224B
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Oct 2020 03:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TCo3I7K+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7742224B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=flatmax.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 568C0176F;
	Thu, 22 Oct 2020 05:36:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 568C0176F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603337817;
	bh=Fn2Do/4CaDgHMJsgxHL7BcRber2bFuA1H/ymuFVD9EA=;
	h=To:From:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TCo3I7K+WgFfnpO+NEhi9MzC6HLeSl8LldrVmcUVztB762NDS7YW/mwXNNcwfNy2g
	 prABzFAsFNlWe7LOLuo4W19pwVr5bWaYWHX95cwZpm9scWRFCVyZJE+3HrZBeqbABg
	 1vLD2TU6fQUId7RNG6LQLiCiW49Df9jiH9YY4OM8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DB572F800CE;
	Thu, 22 Oct 2020 05:36:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B3CCCF804A9; Thu, 22 Oct 2020 05:36:04 +0200 (CEST)
Received: from mx.flatmax.org (mx.flatmax.org [13.55.16.222])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AE587F800CE
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2020 05:35:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AE587F800CE
Received: from 41.68.233.220.static.exetel.com.au ([220.233.68.41]
 helo=[192.168.1.51])
 by mx.flatmax.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <flatmax@flatmax.org>) id 1kVROK-0004YT-8t
 for alsa-devel@alsa-project.org; Thu, 22 Oct 2020 14:35:52 +1100
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
From: Matt Flax <flatmax@flatmax.org>
Subject: PCM link state
Message-ID: <2509e89f-bb3c-bf9f-9e9f-ba2699ef786e@flatmax.org>
Date: Thu, 22 Oct 2020 14:35:52 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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

Is there a way to check whether PCMs are linked ?

Linking is done with snd_pcm_link :

https://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html#gac6c33091b049985baa6466e8fe93917e

But this is no function to tell if a pcm is linked.

Matt

