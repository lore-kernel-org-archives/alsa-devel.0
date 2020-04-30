Return-Path: <SRS0=nm6W=6O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668AFC47247
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2020 17:36:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB87C208C3
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2020 17:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kUQxIbOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB87C208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=depni.sinp.msu.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6180A1669;
	Thu, 30 Apr 2020 19:36:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6180A1669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588268215;
	bh=PZ48SsLzwfT9t2FGibzbBtbh8cmNkqmewGA9KyuPYcQ=;
	h=From:To:Subject:References:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kUQxIbOK94w2n3AkzXqUXDKHihetoOECRXKjdEN2lmDRbwmsGJBAhR2w8yODyqYwK
	 IY/abQwmWSEeax41mwVXZVeTlC4+8cCCWgXCbjBMYn/OejMFxq1h6J8vOhDsQLb+oM
	 NoY41N/c2jPJTfb2eW3iin5lVp9drEM67Y9YBc5M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D461AF80136;
	Thu, 30 Apr 2020 19:36:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0D91AF801DB; Thu, 30 Apr 2020 19:36:03 +0200 (CEST)
Received: from depni-mx.sinp.msu.ru (depni-mx.sinp.msu.ru [213.131.7.21])
 by alsa1.perex.cz (Postfix) with ESMTP id 5E01FF80123
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2020 19:35:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E01FF80123
Received: from spider (unknown [176.192.247.171])
 by depni-mx.sinp.msu.ru (Postfix) with ESMTPSA id E49C11BF43D;
 Thu, 30 Apr 2020 20:36:17 +0300 (MSK)
From: Serge Belyshev <belyshev@depni.sinp.msu.ru>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ALSA: pcm: oss: Avoid plugin buffer overflow
References: <20200309082148.19855-1-tiwai@suse.de>
 <87v9lhkk5h.fsf@depni.sinp.msu.ru> <s5hlfmckjne.wl-tiwai@suse.de>
Date: Thu, 30 Apr 2020 20:35:54 +0300
In-Reply-To: <s5hlfmckjne.wl-tiwai@suse.de> (Takashi Iwai's message of "Thu,
 30 Apr 2020 18:44:53 +0200")
Message-ID: <87r1w4lvut.fsf@depni.sinp.msu.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org
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

> The fix is already in sound git tree, and will be in the next pull
> request to 5.7-rc4.
>

I have tested sound-5.7-rc4 tag in sound git tree and it worked for me,
thanks!
