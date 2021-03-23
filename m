Return-Path: <SRS0=iUFt=IV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2D6C433C1
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Mar 2021 12:17:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0803B619B3
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Mar 2021 12:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0803B619B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 970AC1660;
	Tue, 23 Mar 2021 13:16:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 970AC1660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616501816;
	bh=9IhcIYUFkj6abO+vQ+MfUH/I1dxEbPt/1I1jSSlmOc8=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B+vARSBpdOgWbjTiBaBa7oVILi5PYu8di5lTaBD4qxVZijHR8NmC+Na1AzXTCAnEf
	 D2kGijwUXlpYxMLERk1w6mKAzgVCmy/BU00UiW6ZwH67rFNbv/rMzXsC2S4pJRYfzu
	 UjhHCCoBjyHZw3vCmeks/ljXQr8i19ySYCbujwIg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 15BA1F80257;
	Tue, 23 Mar 2021 13:16:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A3B2CF8025F; Tue, 23 Mar 2021 13:16:04 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E14DDF800EE
 for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2021 13:15:51 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 2729FA0040;
 Tue, 23 Mar 2021 13:15:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 2729FA0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1616501751; bh=L7RtC/J9cVnv8GxX8+4LxNg4WgklUuLLCUAYCPtdAPA=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Cct2tPYRtka1uAOJe3Kr8EryGViDEEB/mRyJYxpy6msE9ADZUzSEwgeiFo+NIwE9a
 Rbqswpf84YnohsVdSvY3toeWTU3E2z1T1CzNBPoAuFNTTNXFTNGseEmV/OuFhJ+UC0
 rc8z+A45mutcMSB/GXOirO1vQf+VlmvY2S5c0+HQ=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Tue, 23 Mar 2021 13:15:43 +0100 (CET)
Subject: Re: [RFC PATCH 0/3] Separate BE DAI HW constraints from FE ones
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20210323114327.3969072-1-codrin.ciubotariu@microchip.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <a0c862ec-44ba-52e0-551c-0347166ac4e9@perex.cz>
Date: Tue, 23 Mar 2021 13:15:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210323114327.3969072-1-codrin.ciubotariu@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: gustavoars@kernel.org, mirq-linux@rere.qmqm.pl, broonie@kernel.org,
 tiwai@suse.com, lgirdwood@gmail.com
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

Dne 23. 03. 21 v 12:43 Codrin Ciubotariu napsal(a):

> To achieve this, the first thing needed is to detect whether a HW
> constraint rule is enforced by a FE or a BE DAI. This means that
> snd_pcm_hw_rule_add() needs to be able to differentiate between the two
> type of DAIs. For this, the runtime pointer to struct snd_pcm_runtime is
> replaced with a pointer to struct snd_pcm_substream, to be able to reach
> substream->pcm->internal to differentiate between FE and BE DAIs.

Think about other not-so-invasive solution. What about to use
'runtime->private_data' (struct snd_soc_pcm_runtime *) to determine FE / BE?

					Jaroslav
-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
