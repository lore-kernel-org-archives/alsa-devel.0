Return-Path: <SRS0=1P3b=4D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CC9C352A3
	for <alsa-devel@archiver.kernel.org>; Sat, 15 Feb 2020 06:31:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE6F2082F
	for <alsa-devel@archiver.kernel.org>; Sat, 15 Feb 2020 06:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="T+/bO/SJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gl9lDyvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE6F2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 108F21664;
	Sat, 15 Feb 2020 07:30:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 108F21664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581748259;
	bh=pEVabzJluk4vc7Hz7enElEP2VebSwY0rTQCJ3OEwqv4=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=T+/bO/SJqm9if9CWH/86manl3i2jEuAjSOp+ziyrFQ+1s75g/FHdzVSfSvTdIfeQA
	 TIzignZk9sHKZCIVsNNL6FAX42E+Tvx+1Fyqxq/icyfIXEgd9OVu1dqfwjbAmuPYB7
	 cn05GNxwLlM6N1Oa/vNgLNE43ZZbIv8ivGWtFNfI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C5EBF8011B;
	Sat, 15 Feb 2020 07:30:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3B015F80147; Sat, 15 Feb 2020 07:30:01 +0100 (CET)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com
 [64.147.123.21])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 59E2FF8011B
 for <alsa-devel@alsa-project.org>; Sat, 15 Feb 2020 07:29:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 59E2FF8011B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="gl9lDyvV"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.west.internal (Postfix) with ESMTP id 2FDFF4C7
 for <alsa-devel@alsa-project.org>; Sat, 15 Feb 2020 01:29:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Sat, 15 Feb 2020 01:29:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=content-transfer-encoding:content-type
 :date:from:message-id:mime-version:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=T68dSl
 IBmU+47jpinNs5CNknsXin3AAfL+7FmRlrS+0=; b=gl9lDyvVL4hLb6V9h16kVC
 uAqjYtsNswVby6NcsAhVfnbk9SahLMOBgshbsRhIJQK0nsCO2yu09z4xQQRlUIXt
 dlE7w6oKvmqFZw6v5yLfejwSpPJN1UMXxXvvCyUxMRcabj1+MOTP92nZbFODraGk
 0DIs4cDRANiNOxsUxJb5iKPxzCUjkpvS3IVuIR0wWrHtcYHH/qKmSSZvxIaaxxaX
 DatmCVp5ZrWwyBUN5QrFrDN7EVHLdTtsXsJZm9bfH+xPC7U1+z3q8cl5Ao00ld+P
 CRQ5h+as1BtCI3Le6ijAMFoRMXlcUYlvuX9YoBOh3ZG4cytU1MIHa7lojxiDTYTg
 ==
X-ME-Sender: <xms:4I9HXkGuzuBxxnOKvXUjdeP0zRyK-kb6hQ9SbStrnhl4_emzgPyy8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjedugdeliecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecuogfvvgigthfqnhhlhidqqdetfeejfedqtdegucdlhe
 dtmdenucfjughrpefkuffhvffftggfggfgsehtjeertddtreejnecuhfhrohhmpefvrghn
 uhcumfgrshhkihhnvghnuceothgrnhhukhesihhkihdrfhhiqeenucffohhmrghinhepph
 grthhrvghonhdrtghomhdplhhisggvrhgrphgrhidrtghomhenucfkphepudeliedrvdeg
 gedrudeluddruddtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehtrghnuhhksehikhhirdhfih
X-ME-Proxy: <xmx:4I9HXhmNnwszWUpHJXkO7JceKnYUxXqTeXxsby5zBV-qvumtnuO3dw>
 <xmx:4I9HXpJ2as6IYgwqCF63KDQfjqsFXZQQ9PvBYy7UlgrzF59bWCEytg>
 <xmx:4I9HXqaxcoNDdY4xt98IyjptBrZMCBjSWfUm--Zh9uktnGvBio2K-g>
 <xmx:4I9HXnwsGHznOQDXjt5mAHq9ykbkdNZr_d5Wv3HMVcKIBSZH_vAJEg>
Received: from laptop (unknown [196.244.191.106])
 by mail.messagingengine.com (Postfix) with ESMTPA id A7F8E3280059
 for <alsa-devel@alsa-project.org>; Sat, 15 Feb 2020 01:29:51 -0500 (EST)
Message-ID: <50ae39498982ba2fc3fc8df1b9f0eac15a2b98c8.camel@iki.fi>
From: Tanu Kaskinen <tanuk@iki.fi>
To: alsa-devel <alsa-devel@alsa-project.org>
Date: Sat, 15 Feb 2020 08:29:47 +0200
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Subject: [alsa-devel] Question about the various mixer options in UCM
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

What's the difference between PlaybackVolume, PlaybackMixerElem and
PlaybackMasterElem? Other than the obvious difference that
PlaybackVolume is used only to configure the volume control, whereas
PlaybackMixerElem and PlaybackMasterElem are used also to configure the
mute control.

-- 
Tanu

https://www.patreon.com/tanuk
https://liberapay.com/tanuk

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
