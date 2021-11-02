Return-Path: <SRS0=AYCm=PV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AC2C433F5
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Nov 2021 18:07:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C16960EBC
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Nov 2021 18:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5C16960EBC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=system76.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DADEC166E;
	Tue,  2 Nov 2021 19:06:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DADEC166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635876451;
	bh=frcCV1k9oG9oKj3dpUqdJg1PxRT2RSN/XKdLCPjaYaY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GXYCI4LkIvwoE68i9N0FmX7WwqSQKZCBHExjv93WlPUdGA1mfij1sYpGDE/b2GX92
	 cUlww1zNUfkOugrqnYepqXAcCcPHb4t8sbpjnrmnZa1SAbe7G5Cq0wCTu5lU/ozF+j
	 JbPzwHbHg7LiLYtdKT7r7H1NjmnzUPPh3NeCoLfE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4C418F80224;
	Tue,  2 Nov 2021 19:06:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0AB87F8025D; Tue,  2 Nov 2021 19:06:39 +0100 (CET)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E1291F800BF
 for <alsa-devel@alsa-project.org>; Tue,  2 Nov 2021 19:06:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E1291F800BF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="ZLxbkv0M"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 698825C010E;
 Tue,  2 Nov 2021 14:06:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Tue, 02 Nov 2021 14:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; b=ZLxbkv0M
 U9sX9ANGmFrLc0r2PU1Sd8qFm+gVLzvyLaU8iBX/PulHLJfT587ixlc0WlUxjNFn
 4ncbwn/iZb1bYfmOlHuVjdTdvG5XLzfjGOTIwZdODY1mnVOF+WlPXlBosXZnvs6I
 Qm2J0cHotqsbjI8xIR6I1Wta6sji/llGGqLmOKq0Shc9aFOixgWIRFCys3GGiXED
 1YJcNFo1Ss/edGJ8bcUHQc02u/OrWlC1iUx49YizzBz2Felkz0G2qoXRwpKvpaK1
 Swg498moHqMyFBvU0qtOFScdkcNLjZlkZQkvvjlzuXr4sTRnY6CbukxKLncitWRQ
 ib/DQSsNDO+T9w==
X-ME-Sender: <xms:Jn6BYSCYstmNQ7isZYTx4nCMKqeUNWiqRDMESyyv3S648mRLs6N0kQ>
 <xme:Jn6BYcihLWvnj7Ua9DWRgotA0J-6ADSSTyi3y1P5uVmgzCe6VrhSCFI4RENZ2H9pn
 agf5FtwRhb4KPsphA>
X-ME-Received: <xmr:Jn6BYVnqhy3ZhIKDsBwTzoPcKWNqM-ZjNjiRSHuoBRZikI5JDlExj4H1AcK4htNTwGUe-_18nLHr0Jda7zL9SwO1SWNc-p2IqGOjoRY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrtddtgdekvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecugfhmphhthicusghougihucdlhedtmdenucfjughrpe
 fhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhimhcuvehrrgiffhho
 rhguuceothgtrhgrfihfohhrugesshihshhtvghmjeeirdgtohhmqeenucggtffrrghtth
 gvrhhnpeeifeelvdfgueeiteefheeghfeiudelleffgeetkeejudeugfekueehkefhheff
 tdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehttg
 hrrgiffhhorhgusehshihsthgvmhejiedrtghomh
X-ME-Proxy: <xmx:Jn6BYQwqWvzYs49xKLcpTOq_KIkomQrv_xda19OeLxYjLBRlpoLR6w>
 <xmx:Jn6BYXRzfttUioPhavKHFknAG8hvITJ-pgDDbgjjZCB1WMF01KSLKg>
 <xmx:Jn6BYbb8Z5juHKA2cZIhzwgpuer7VfUwj-ZbnquQRXz4U8S4j_qFMQ>
 <xmx:Jn6BYeLqzyrDI8z2YdwIyW6WiRw4YTtpVrdeDJK72jXP90DgBFqi2A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Nov 2021 14:06:29 -0400 (EDT)
From: Tim Crawford <tcrawford@system76.com>
To: alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: hda/realtek: Headset fixup for Clevo NH77HJQ
Date: Tue,  2 Nov 2021 12:06:18 -0600
Message-Id: <20211102180618.12069-2-tcrawford@system76.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211102172104.10610-1-tcrawford@system76.com>
References: <20211102172104.10610-1-tcrawford@system76.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: productdev@system76.com, tiwai@suse.com
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

