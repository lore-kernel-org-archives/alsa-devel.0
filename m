Return-Path: <SRS0=FEtg=KW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C53C47089
	for <alsa-devel@archiver.kernel.org>; Thu, 27 May 2021 09:50:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14B3E613F0
	for <alsa-devel@archiver.kernel.org>; Thu, 27 May 2021 09:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B3E613F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ungleich.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A5757170B;
	Thu, 27 May 2021 11:49:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A5757170B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622109045;
	bh=4fNjG8smV1GjFLyuMfaGTu8vUJj1tWuDfvwPraRvMnM=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CQWGTMfw/b5eGmjXvhT5VmCYVtqeON1riVnXHHV1bfWurOsT6eT4yDe6vWwIV0tdR
	 vP/g7pLUoElUIUyQBkpazKO9jTMsrpZcZFPWSi30bIQvGCeQx/qJfX0nNs7pfwJFpE
	 kbylojqHsbbRrjc2UlgOrJXlcVPLCueX3OObtjTE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 431B3F80116;
	Thu, 27 May 2021 11:49:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 132EAF80149; Thu, 27 May 2021 11:49:54 +0200 (CEST)
Received: from smtp.ungleich.ch (smtp.ungleich.ch
 [IPv6:2a0a:e5c0:0:2:400:b3ff:fe39:7956])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C3B0AF800F9
 for <alsa-devel@alsa-project.org>; Thu, 27 May 2021 11:49:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C3B0AF800F9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=ungleich.ch header.i=@ungleich.ch
 header.b="YNn/PI2W"
Received: from nb3.localdomain (localhost [IPv6:::1])
 by smtp.ungleich.ch (Postfix) with ESMTP id AE9551FF14
 for <alsa-devel@alsa-project.org>; Thu, 27 May 2021 11:49:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ungleich.ch; s=mail;
 t=1622108982; bh=4fNjG8smV1GjFLyuMfaGTu8vUJj1tWuDfvwPraRvMnM=;
 h=From:To:Subject:Date:From;
 b=YNn/PI2WdxLYB6sl7uVnzRyFn7d+wxJac7RiAimJ8YMQAhktBEq+Fw73vrHHhXyCO
 mrA7wBiSkjhkcyLGdM7L2dNJFuhoj1x/KihE1zZj6EKEejrfnGsRcAB3PHntezVUrC
 dpf9wn2051aX2BEhIAQ6Kl/YGvPsQZxhxhT96UOn5r2SwqpvV1krUcytAdkgmMF6Sl
 DwKiG0fhdTAtD6D7BV4SRX/Owg3x7B++G1GyPRFWrtY/M9nbFnQkTSMzGHF5Z8Gl50
 8WDGdDZ18QHLWP0I34NZX2RF/WbK48GoYjw+Dt4eM2LzI58bfQkq8cLOENaVRW/qnk
 SxiSWkcP4Ahjg==
Received: by nb3.localdomain (Postfix, from userid 1000)
 id 7B2E014C01E0; Thu, 27 May 2021 11:50:10 +0200 (CEST)
User-agent: mu4e 1.4.15; emacs 27.2
From: Nico Schottelius <nico.schottelius@ungleich.ch>
To: alsa-devel@alsa-project.org
Subject: Internal microphone does not work with 5.12 (Tiger Lake, X1 Nano)
Date: Thu, 27 May 2021 11:50:10 +0200
Message-ID: <874keoijzh.fsf@ungleich.ch>
MIME-Version: 1.0
Content-Type: text/plain
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


Hello,

it seems that the internal microphone does not work anymore with
5.12.6/5.12.7. I am somewhat sure it used to work within the 5.11.x
series and that sound did not work at all on 5.10.

I have uploaded the hardware information on

http://alsa-project.org/db/?f=f1a2b32db122695b2cf736db27cb6ed2fa8a9042

The microphone of a plugged in headset however *does* work.

Is this a known bug/regression and is there anything I can do to debug
it?

Best regards,

Nico


--
Sustainable and modern Infrastructures by ungleich.ch
