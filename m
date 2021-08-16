Return-Path: <SRS0=rgkk=NH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EB3C4338F
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Aug 2021 16:08:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 912F960F58
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Aug 2021 16:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 912F960F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diwic.se
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5E9B016AF;
	Mon, 16 Aug 2021 18:07:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5E9B016AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629130076;
	bh=mEKnC2Nz/2iVluHF78TpF+3H5JmAlHswK8HO6PhUpFI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mwbYBNpkDOcUCqrgvtJffwx0DSjNsp1GIGbkIxPEg3PY3odAgjHudCsid6s/ToJG8
	 UcHrus7Goh61/1dm+DtkVhLL70o/wKnoh/lNiSkADiAJsHI/ebPCtPylYCTPW2Ilb8
	 qUlcfzwNVsqro0K8maa3iW+S+h1y8mKUi79NhQGI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E0D36F80249;
	Mon, 16 Aug 2021 18:07:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E23E1F8028D; Mon, 16 Aug 2021 18:07:03 +0200 (CEST)
Received: from ns4.inleed.net (mailout4.inleed.net
 [IPv6:2a0b:dc80:cafe:104::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 58D96F800AF
 for <alsa-devel@alsa-project.org>; Mon, 16 Aug 2021 18:06:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 58D96F800AF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=diwic.se header.i=@diwic.se
 header.b="h/awexmN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=diwic.se;
 s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:
 From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ROB3ZKTXF964yivwQ+h+oKLCMGkU/2DGLtyDZ9pRQZ0=; b=h
 /awexmNnMpDBQV08tDH4fgqU+9NrobUsEql4CMIa2AWkaYRGumONEh0m7WbhZkhXFJJFUr+dCfPcl
 NKHv+h5kOoh+3e26kxhfnhC9LtNA0t6ZHRcfdYopkJ0wea3CRP211CsZwOEmphJSuLuhjDGysaLAJ
 4uEjtH0uReB9no3gV0JQ+7kd2jV/+AswvmfJhu5IXLQEGEP0v6AWAMvXb2sqtSPFQPqbr3AXQ3i1F
 6R2hcCSgfQYLW13TTO1ygzBgKiU5h5P8jJ61x1Fp9IbzPbgspmb3EERF9vVz+r3s54WyxbrFLHkH2
 yPWI7Bt+T8lDss3ASw4Uucr4daCExmlOA==;
Received: from c83-254-143-147.bredband.tele2.se ([83.254.143.147]
 helo=localhost.localdomain)
 by ns4.inleed.net with esmtpsa (TLS1.2) tls
 TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <coding@diwic.se>)
 id 1mFf8S-0044Nq-I6; Mon, 16 Aug 2021 18:06:48 +0200
From: David Henningsson <coding@diwic.se>
To: tiwai@suse.de,
	perex@perex.cz,
	alsa-devel@alsa-project.org
Subject: [PATCH 0/2] alsa-lib patches for rawmidi tstamp framing
Date: Mon, 16 Aug 2021 18:06:23 +0200
Message-Id: <20210816160625.17796-1-coding@diwic.se>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: coding@diwic.se
Cc: David Henningsson <coding@diwic.se>
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

Well, now that we're about to release a kernel with support for rawmidi tstamp framing,
how about some alsa-lib support for it as well?

David Henningsson (2):
  Add rawmidi framing API
  Add test for rawmidi framing API

 include/rawmidi.h           | 26 ++++++++++++
 include/sound/uapi/asound.h | 30 +++++++++++++-
 src/rawmidi/rawmidi.c       | 83 +++++++++++++++++++++++++++++++++++++
 src/rawmidi/rawmidi_hw.c    |  2 +
 src/rawmidi/rawmidi_local.h |  2 +
 test/rawmidi.c              | 65 ++++++++++++++++++++++++++---
 6 files changed, 200 insertions(+), 8 deletions(-)

-- 
2.25.1

