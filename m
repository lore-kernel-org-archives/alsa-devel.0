Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2F9C77B75
	for <alsa-devel@archiver.kernel.org>; Sat,  6 May 2023 00:00:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 78C5D2AB1;
	Sat,  6 May 2023 01:59:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 78C5D2AB1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683331203;
	bh=T6FBzB2Pnj63/Vj01t5sCSobdXzCwWPCZNo3hbUrKl0=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=h6Z8vW6+zIti1EQfW9t5gVvieg28OGvrthM1GpvSyHSf0zLoN9fWUVWnF9VeZZa4w
	 HMoV0XDeI5/IwQ97Zvo/bvna7muK1uqnxNYanQyIa1VVSWgVlFg7pW3czUPh+wWP3h
	 EypSgQIGPEDBkxXRlJJqikXmGnxkmTd2Fk3qqH0E=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7840EF8052D;
	Sat,  6 May 2023 01:58:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 89024F80087; Sat,  6 May 2023 01:58:43 +0200 (CEST)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4FA1CF80087
	for <alsa-devel@alsa-project.org>; Sat,  6 May 2023 01:58:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4FA1CF80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=ljones.dev header.i=@ljones.dev header.a=rsa-sha256
 header.s=fm2 header.b=ew9iek3D;
	dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm3 header.b=YKhRQwiB
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id C4E853200124;
	Fri,  5 May 2023 19:58:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 05 May 2023 19:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm2; t=1683331114; x=1683417514; bh=SZidY0yAnO
	LfMRTCrpi+LMj3JN/8GMYrcCtqR+SI0v0=; b=ew9iek3DYP0QR82PVXdp1c50H9
	odhFrcVyhHRJ+L2N304E29WoMdwbMxvzxTiqiXQ/z2FVZUu2aMOmppGTrc5XAq2M
	b3ha1IThVZJk3j/WZzcVrwFFGEPxT2s9ByHVtJ94qAT/8g6oPsmI1SucEP/7MhSh
	AL5sOsgwlSbCB7OJqoQH0VTmIMUzVwqoPUOOsZcxWnuxaHexTr/P1QbAjXxfAKZ1
	ma4pZR588/p12qBYrJYVumExhvyI49dnYJQCxmsO7t5CREIXHvEzpVPCP2lCubzv
	npK4IJe65WiGMM2YNOZZ8TSJyyPffE78Uq4d+hkpgWlEkJJnWpv+T+TOrNdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1683331114; x=1683417514; bh=SZidY0yAnOLfM
	RTCrpi+LMj3JN/8GMYrcCtqR+SI0v0=; b=YKhRQwiBeGW8nlYxLtK/GWCLKMNjY
	uO38mZ+jiT96TQYMj0ZdKhwvm+hYGy+/LgyOespFOWE/P/yu14bRKSAnczJESSp+
	dzWMDX5mP78LRmpfbGpRyBODhEySy/JnLuM6GP4In16+Xl3DJ7HntL8gQQWS7BsQ
	F5TvKPckFDueMvpGhbz/aFA4zznKGB7nIEbXn6y+dvNKcRFKYS6+GZlSqaPleOxQ
	K+mQy9abo+NWOS01c4BDPKNDsy64LKDKzPW+ZIzlcVxpt1FFFCJ0l5IGG5MLlDXZ
	jcE6+irdWLN0zoJwoqpN+jPylR6DB0M7iqWP+6ebK4BYkQh+PNqJV1gJw==
X-ME-Sender: <xms:KZhVZB_YGVssXNWLvf5SXf_CetUMpPJEbxfpuUYDEGBU8FyssRXQaQ>
    <xme:KZhVZFv7tmj0L6vZ52HiOe8kf3nJViZmeWZBsK6ZUjTnpJEji6m2JgcqMyYZfupQm
    I2f_yeddscIGacZ2JE>
X-ME-Received: 
 <xmr:KZhVZPAfAZXooY6m1zdkgUku6k1Wdykq6Z1WV1Ge6no3c4DCC0ZSac3FiOVt>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvhedrfeeffedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:KZhVZFelT0oz8ieZVfzrfzqk4gO4uOw0-gD6VvNJL3XsrI-pvo-cgQ>
    <xmx:KZhVZGNU7UycFX_NZntL6OFPJH2CTTF5AQHogecod78zXkbsL_lzrg>
    <xmx:KZhVZHl8CCFLVafkLVeXDem6BH0lWZCwV9Aff32Neprhyu7fwbKo6Q>
    <xmx:KphVZPZqG74ZyibNtDo7Slbaai9BOhMikqBbNgU0PEXNYyuJSnkxPQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 May 2023 19:58:30 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] ALSA: hda/realtek: Add quirk for 2nd ASUS GU603
Date: Sat,  6 May 2023 11:58:23 +1200
Message-Id: <20230505235824.49607-1-luke@ljones.dev>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: UN5C3DK5OLO4X4F5CIWCZSGXVM4CW27V
X-Message-ID-Hash: UN5C3DK5OLO4X4F5CIWCZSGXVM4CW27V
X-MailFrom: luke@ljones.dev
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, tiwai@suse.com,
 "Luke D. Jones" <luke@ljones.dev>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UN5C3DK5OLO4X4F5CIWCZSGXVM4CW27V/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add quirk for GU603 with alt codec ID.

Changelog:
- V2
  - Move line to correct place in order

Luke D. Jones (1):
  ALSA: hda/realtek: Add quirk for 2nd ASUS GU603

 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.40.0

