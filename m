Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9CFCA5FED
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Oct 2026 04:53:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C3B5B601E9;
	Fri,  9 Oct 2026 06:52:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C3B5B601E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791521584;
	bh=yQKVqfMknWlVUfiGpr6FHtE7pQtpNFcgbX04BIQvv1M=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Hu9+aRx1lgmjBFQ49GEg5HEL1skugwf+tytPQIl2IBdH7I58SQbRWTWlrAR9aCJmK
	 tqbZZPeUpsMdWb6WiNVtEjK83DKrEktVxiV7yLmXKnN7HVpNWwlB7aKqLzY22ovJbN
	 ChGVbalFQsPG/x6D8DPelK1x3x0s0uwyyUy8gvEk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 58132F80601; Fri,  9 Oct 2026 06:52:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 246FCF805EF;
	Fri,  9 Oct 2026 06:52:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 821BAF80557; Fri,  9 Oct 2026 06:52:23 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791521542;
	b=fM99M/8SXqgpfA1p+/q2c95ZOpSO0Ux9oquBZhVi4l3JSiSzOPEEaZIJkJCGmDXKYXOt
	 JRDQjlCqsup43QjiPXsmPI2tal9ydjl58/Vj2r310eRpt1rcSq/rdIFsoccy6jiaUQbmU
	 o+Qb3XFtyEHksHQE8Kcuc0Z34bSN06QQcecyaYETQ3W3r8X1ojZbEVC5tvcnQCNEpusQj
	 58SQFDjBY+ILCgn8rRyZ990hsGu8+oRo2S/eQlTeTNPBVChGNz00fwX6R8/O/8o3dmoct
	 NMurkcd6++gOSa+RfTEUfUuwqE+TyRH4xTD4LLjLJzFNyYb6J/j5wdJAADCVGgEPLJg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791521542;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=yQKVqfMknWlVUfiGpr6FHtE7pQtpNFcgbX04BIQvv1M=;
	b=dv1P4/UuEo2nM86ckPH2pk266ZxfH+8LCLKS307qfLNTBv5Uadg7X9X/UqDecBr6Zdst
	 4n7+85RLrvmMCiuiffSUW46x7rDnQX13Fr6NWDgIf8Y+jJLgPDNqQVYtOJzyXoViTSYCQ
	 cHjF9q31tNj0qiXpr3lWWHMLaTZZIRqgQRcF9HvIl6IbOR8VTV5OY5CXjmgjo4vdGnSeK
	 hM3WU8iXY443UiZTQGx5GwG6UZ5fZjDfJ9JBliF3DrDSrLPxDzV/yTzejBeRIDtOtZz63
	 fOsm7+ejfQRU7p7g2sCwEm/PbdbdKontl4WonUmbvQ6Lb6QusD+pFlZ6rCo/FvnhXWA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 5BDA2F8025A
	for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2026 06:52:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5BDA2F8025A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18dcc35975a17100-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/870@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/870@alsa-project.org>
Subject: ucm2: Qualcomm: x1e80100: add DisplayPort 2 playback
Date: Fri,  9 Oct 2026 06:52:23 +0200 (CEST)
Message-ID-Hash: C2W5RCRE4YXN7NMNPBRGM5WCCUBVC3D2
X-Message-ID-Hash: C2W5RCRE4YXN7NMNPBRGM5WCCUBVC3D2
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/C2W5RCRE4YXN7NMNPBRGM5WCCUBVC3D2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #870 was opened from QTI-Quill:

Add an HDMI2 device for DISPLAY_PORT_RX_2 using MultiMedia7 with the "DP2 Jack" control.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/870
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/870.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
