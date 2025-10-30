Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DC4CCF9F8
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Oct 2025 07:31:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B078A60218;
	Thu, 30 Oct 2025 08:31:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B078A60218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1761809500;
	bh=4GrnbyQ14PPgnN7E3b/fULiBQMtbFk8+PXdmMZQW6RA=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=s77PpM7r0gvUKnWFGNqR9Yz5+2XVrO/qUy7BrbOFIT02zO+T3gq1yJ4VjMgnXhh5T
	 jBDCISW/rJh03k8k3+5R76kH0TbcIc3KmRwTfxUjeYbst55oJmDHCRi0UhnuyJaomW
	 ymc7cz6b8mmGGSUxMajgzLhsEtbWePoiySeuSDuo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 27EF4F805D4; Thu, 30 Oct 2025 08:31:05 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 03D18F805D4;
	Thu, 30 Oct 2025 08:31:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D55F8F80240; Thu, 30 Oct 2025 08:30:47 +0100 (CET)
Received: from mailman-web.alsa-project.org (mailman-web.alsa-project.org
 [10.254.200.11])
	by alsa1.perex.cz (Postfix) with ESMTP id 9E5DFF8003C
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2025 08:30:47 +0100 (CET)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH AUTOSEL 6.1 02/13] ASoC: amd: yc: Add quirk for Lenovo
 Yoga Pro 7
 14ASP9
From: braxtonangelic97@gmail.com
To: alsa-devel@alsa-project.org
Date: Thu, 30 Oct 2025 07:30:47 -0000
Message-ID: <176180944761.20.2624630085113364317@mailman-web.alsa-project.org>
In-Reply-To: <20250530124112.2576343-2-sashal@kernel.org>
References: <20250530124112.2576343-2-sashal@kernel.org>
User-Agent: HyperKitty on https://mailman.alsa-project.org/
Message-ID-Hash: JHLMM7FK3LUKDS7OOBQQQKJLOVFAELOG
X-Message-ID-Hash: JHLMM7FK3LUKDS7OOBQQQKJLOVFAELOG
X-MailFrom: braxtonangelic97@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JHLMM7FK3LUKDS7OOBQQQKJLOVFAELOG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This commit is a textbook example of a low-risk, high-impact hardware enablement fix suitable for stable backport. It benefits affected users immediately without risk to others, adheres to the stable tree’s rules, and aligns perfectly with previous backported Lenovo AMD audio quirks.
https://geometrydash-subzero.io
