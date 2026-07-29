Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 833A5C53200
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jul 2026 10:19:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F171601FD;
	Wed, 29 Jul 2026 12:19:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F171601FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785320383;
	bh=h0yQ6jdAnvRfzQmr9HAxlzx98GWYwi1ghe0kZTco42A=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=XWdWC76TLKg1mpKDWcHa5jC2fp4RrVcpOVl9TTXFgtjNgQd1KQyBsDxPyJtu86RaY
	 LGRZlQPIMfasilad94SEr+myUDeag1XuDMHC7yuYo7r22VP0GxSRbsxp+IZGHCUa8/
	 vqq9ERHtdtnmbUYFvA7wU3JizyYks150Mii+3Ph8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 55ED7F805F8; Wed, 29 Jul 2026 12:19:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BF04EF805F7;
	Wed, 29 Jul 2026 12:19:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EB452F80571; Wed, 29 Jul 2026 12:18:58 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785320338;
	b=T8OVtFPHisByAWDQhT+6FTyq7d9RSGdI3yQY9VtaKxd8c/NerKHTlLEOG3GGDBbe2CL+
	 21+cZ+6UZEYNprqczcL5nK3FT7qH5FjevTmxculQr7ssAr6PsoorDtTyYU2X/zkqf2ZOE
	 H8RhMEkB8KIr9/unwvw7Xe5BvGOWZ+pY7RRrOZHs7TAwRqwW1CfUTJlDMzTxiWkSWEzL2
	 Rr/Pj0jwYAcqGh4D0bL14TD2tpYe7PZFUcvxpWQYcqMmWlBIQpkGH106WAyIzuI/0wOdz
	 +QkH5GqgaYeGAEo8SrhIe/XK8GNVg6xcj4lWZTVIDomLuFRYbONKHWXpC21zCH66wOA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785320338;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=h0yQ6jdAnvRfzQmr9HAxlzx98GWYwi1ghe0kZTco42A=;
	b=Dr26Z6fJ3T137EnymOoRFzvPbree0KXEyMSHbkbDVqaCWuCDdnD/Ol0M400/P2VeTh8c
	 dlAKj6LG+DfWBZTai7nGrekw5k0Z8ptE9MwzflwPNefleuqMtj1y2PL4a6yxz5YI1jIIB
	 +QFx/Yx3fvl++97hJMXIKkBreYt1MNoOG3y55mnSJR5TYxYwWDbtDnFKLSdhUOhEGfFFW
	 xKjvhvBtedZ1xpe2qDaBhqYX88qhLC1EsUHcFUAperIZCW08Z8LgjPiOYmXm8RAjcz6m3
	 HI+GRR5Tkrj1VN7ZlVshXkF2rdA0ADjspNL9aAo8AoSy3DwsyBbGBLiTR+s61Uajxkg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 1516FF8025A
	for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2026 12:18:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1516FF8025A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c6bb6311673f00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/821@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/821@alsa-project.org>
Subject: USB-Audio: ALC4080: Update NVIDIA DGX front mic jack name
Date: Wed, 29 Jul 2026 12:18:58 +0200 (CEST)
Message-ID-Hash: OGP4ZXC3QBPX3RYLNDJNBNHC4A3LUQT3
X-Message-ID-Hash: OGP4ZXC3QBPX3RYLNDJNBNHC4A3LUQT3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OGP4ZXC3QBPX3RYLNDJNBNHC4A3LUQT3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #821 was opened from oortcomet:

The ALC4080 codec in NVIDIA DGX exposes the front microphone as the dedicated "Front Mic - Input Jack" terminal. Use this terminal instead of the indexed "Mic - Input Jack",index=1 control, which PipeWire rejects and therefore cannot use to track front-mic availability.

This patch redefines Mic1 according to the codec firmware with the front mic's terminal name.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/821
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/821.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
