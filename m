Return-Path: <SRS0=YhdC=HD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C487C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 15:33:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAED964DE1
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 15:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAED964DE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 955EA1753;
	Mon,  1 Feb 2021 16:32:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 955EA1753
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612193620;
	bh=fvCTfVpAuqciI+P5y/yw6sVzUurzRvPuM0bij518BIU=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vzi7iMfYoR7yOEyaemUQPaeUQv4Ukeq5qdMIi5Dbw998EAYANtG2BCPnBsC5WqvVz
	 n6b3UEtD9M5K4rq3ggrCW1g2sZxCsU9o/tHBAsoHmkQ3T1W4QNoq4hTqN1sn3C+Nb1
	 UGzmIQL9H2fdS3rTdBM26n+C5vXDNhtMEEP06KWk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 12CCDF80152;
	Mon,  1 Feb 2021 16:32:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F0CBAF80153; Mon,  1 Feb 2021 16:32:47 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 99F80F800E2
 for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2021 16:32:40 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id A423FA003F;
 Mon,  1 Feb 2021 16:32:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz A423FA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1612193559; bh=vook9S95R4XlCekIfIeCMgXoGME9PK1gz2eShg9fY8U=;
 h=Subject:To:References:From:Cc:Date:In-Reply-To:From;
 b=vc55kyEVs8Us++TLKtI/SYCR+aRC5wxKHsqlTLXvMmBGCPOSsx4q0GPqkOFDX21Lj
 62/h4r22vmexZ5cbvAUJZzAz8+cMZugbfhthQjwB/x5nvNgX1WERvrX5uzA8v09AMb
 Sds5DpR0FnZQn1QS9Ow62xpXEALSFd+eTa9b8zok=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon,  1 Feb 2021 16:32:36 +0100 (CET)
Subject: Re: [PATCH] Add support to expose controls of ladspa plugin
To: Camel Guo <camel.guo@axis.com>
References: <20210201150352.6342-1-camel.guo@axis.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <c94055e4-20f0-f4d5-8aa2-26d99fa30486@perex.cz>
Date: Mon, 1 Feb 2021 16:32:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210201150352.6342-1-camel.guo@axis.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Takashi Iwai <tiwai@suse.de>,
 ALSA development <alsa-devel@alsa-project.org>
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

Dne 01. 02. 21 v 16:03 Camel Guo napsal(a):
> From: Camel Guo <camelg@axis.com>
> 
> In order for external software components to adjust ladspa plugin
> dynamically, this commit adds an option to exposes the control array of
> input control ports of a ladspa plugin to a file, through which any
> applications with proper permission can control this plugin.

It looks like a pure hack (although the implementation is interesting). The
controls may be exposed via the ctl (control) API like we do in
src/pcm/pcm_softvol.c for example. The floats can be mapped to integer64 or we
may discuss to add the float type to the control API elements.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
