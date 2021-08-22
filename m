Return-Path: <SRS0=JRP5=NQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D32C4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Aug 2021 06:20:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0BA061374
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Aug 2021 06:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F0BA061374
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 95EF8168D;
	Wed, 25 Aug 2021 08:19:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 95EF8168D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629872449;
	bh=1C1n0+I4cewGwzLYoFpQRL/IDtmL5MjDyBAep5WYVug=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=rbEB2W61/CPWgzVKlo1KWGuQBSsoIe+rc1PFUtq3B7X3X8asBNFd9kuDtcDq/NBll
	 SP2WT4fOtKY+4xk3NDKM9DDSDqpI6IcmBuoS/g7u6WWuDfqCf+GmqFO3DNGdEVZeDD
	 QhusSK3SeH0DA/G+WiImCz0L/lgSYo/LHtTR/gcE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1AE5AF804E2;
	Wed, 25 Aug 2021 08:18:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C1F66F801D5; Mon, 23 Aug 2021 01:05:17 +0200 (CEST)
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 02FFBF800FA
 for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2021 01:05:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 02FFBF800FA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=protonmail.ch header.i=@protonmail.ch
 header.b="rr2SSecf"
Date: Sun, 22 Aug 2021 23:05:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
 s=protonmail; t=1629673506;
 bh=KTJw/bWX9ydfK9tpgFxlZ26w0KPJRBLXNKHYUhJy7ns=;
 h=Date:To:From:Reply-To:Subject:From;
 b=rr2SSecfxpt2kgaGesXubWxmkfq3VL1ivptsIh2wSu+5wrKjcBkdNbcmz3YDCqrmZ
 8ITgvVLDNAtOkOvEOsz7DyqGvfP+jPwqwdawS/qLezC5FUEw8Zgz8T7AfpA4/70fLE
 5UVQhZtOgykZOTsy7Sbrr2DpY4Nh58FkYVlzy0Yg=
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
From: Callum Parker <C.P.K.C@protonmail.ch>
Subject: pulseaudio bug
Message-ID: <0yexXXNvNs09tHRft3zJtfjvHaXkrfY9yKV-z0xLq_V-Mf0Oa6iZMCnGuFtGhDMmss48gN3vN3DSL6Cx24UrQX5ww4UFN1P_USwRmPO2csY=@protonmail.ch>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 25 Aug 2021 08:18:36 +0200
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
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
Reply-To: Callum Parker <C.P.K.C@protonmail.ch>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

SGVsbG8sCgpJIGhhdmUgYmVlbiBwcm9tcHRlZCBieSBteSBsb2dzIHRoYXQgYSBidWcgaXMgaW4g
dGhlIEFMU0EgZHJpdmVyLgpbaW1hZ2UucG5nXQpodHRwOi8vYWxzYS1wcm9qZWN0Lm9yZy9kYi8/
Zj1hMWM3NjRkYWYzOGE2YjUzMmZhNjJjZTNkMDY5Y2EyM2E5ODk2YWM4IGhlcmUgaXMgdGhlIHVw
bG9hZCBJIHVwbG9hZGVkIGZyb20gdGhlIGNvbW1hbmQgZGlzdHJvIEkgYW0gdXNpbmcgaXMgTGlu
dXggTWludDIwLjIKS2luZCByZWdhcmRzCgpDYWxsdW0gUGFya2VyCgpTZW50IHdpdGggW1Byb3Rv
bk1haWxdKGh0dHBzOi8vcHJvdG9ubWFpbC5jb20vKSBTZWN1cmUgRW1haWwu
