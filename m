Return-Path: <SRS0=nXTK=HZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5CDC433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Feb 2021 16:26:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F7CF60234
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Feb 2021 16:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7CF60234
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 178B7166A;
	Tue, 23 Feb 2021 17:25:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 178B7166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614097587;
	bh=tOeas8zOZhkKzWYfglTAaPeV80FBDC0iiW8zaYAkkCc=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WdESMjiZGZhwCtjjq8ehAwV9MrNh4fwapD6FdCwmI70vtk+HT8OFHpFSfPJPahwKP
	 suQgnbGYM4CiqfSzJMyBFvqExxkgXHKu9eyD3K3r2aJWtMzoWAxD5ehfa+LSlU8qdW
	 WQWdCULml3WJcG9tdrxr/19Jt1x9helfby3dw5P0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 60FE5F80167;
	Tue, 23 Feb 2021 17:25:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 10218F80169; Tue, 23 Feb 2021 17:25:35 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF13FF80129
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2021 17:25:28 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 88220A003F;
 Tue, 23 Feb 2021 17:25:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 88220A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1614097527; bh=MsK2Zxf6f9WhhS2D3PK0K0x94ljaV2JsH5k2KeK/co4=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=tpJN/9jVo2eC6jODZtqXfZakuFXnBTUNJEZtBjS20r35WZXAq4+1zN2bbwwiXQt/q
 ubxzj5B/svN8e5ShfslEHm7Ap2u81qX2Egy/WXha9edtQTa1wArydm83Ud0yiNZUeB
 XNxtQjZupe5h5buuH6k8CxUSMXNJsZVRUI0+nV1o=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Tue, 23 Feb 2021 17:25:23 +0100 (CET)
Subject: Re: [PATCH] ALSA: hda/hdmi: let new platforms assign the pcm slot
 dynamically
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>
References: <20210223122205.233701-1-hui.wang@canonical.com>
 <alpine.DEB.2.22.394.2102231545050.864696@eliteleevi.tm.intel.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <ccc1fd32-5838-a2ca-39aa-75ef2d7e3b16@perex.cz>
Date: Tue, 23 Feb 2021 17:25:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2102231545050.864696@eliteleevi.tm.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
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

Dne 23. 02. 21 v 15:14 Kai Vehmanen napsal(a):

> This is somewhat arbitrary still. If we simply want to enable the mode for 
> TGL only, easier and cleaned would be to set this flag in 
> patch_i915_tgl_hdmi() directly.

A dumb question: Does TGL really support up to 11 separate displays or it's
just to handle 11 connections and the number of maximal simultanenous
connected displays is lower? In the later case, the dynamic allocation makes
sense a lot.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
