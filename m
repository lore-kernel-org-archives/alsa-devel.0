Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85F3C5AD44
	for <alsa-devel@archiver.kernel.org>; Sat,  8 Aug 2026 23:39:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B95DB60209;
	Sun,  9 Aug 2026 01:39:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B95DB60209
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786232376;
	bh=OJ5d9j6DEQdw6HdiH7WUC04u8kfXqlaWiSxWgRDLjZ4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=OLMwfb36OuQh0vUa13tFcGfTAtVJppvDDgOY7SnrrgjLkEVmsXPo+Z+uk1GY458LB
	 uniIzCXN713L6v1FMAn9j7kIKjT1QnVK/U39fkC+WlyqUmPyBwYjxdmuOuM+P8/vec
	 0CCxvdJJFm1Qwph569kvgAYNe6OdjHOVxUmuEmjQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9D0E2F80601; Sun,  9 Aug 2026 01:39:02 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A04DF80600;
	Sun,  9 Aug 2026 01:39:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BFF40F8026A; Sun,  9 Aug 2026 01:38:55 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786232335;
	b=Ga/jPL26LwzljOluJxcq6BRaFpQpQbc83wOYc3xzCJ5zO/IQRs1iwX26B0VQvQ9rlmlu
	 dbea33NPkgtTCGhEknMALTjMF7o1yBq/1qQ91WZ4Sw5geHGiV+L+j08Mgb9vT47/lTBu+
	 ZNkGQwknR9S/RLFdm/0/HdJcdEdn9PlSltUorb55NrvTrUaXDIf8w7fU0VgunqhLCIav8
	 519GoI/x66mGrdrwrQuNT0q2WF3t/QOyk7qrsnnTV1qdsJd3tk9H+nw0IPBmk7idqvmJd
	 Qtl0qDjetNvIAVNtHQ8hA2mkKWp4STiCOY/POMPQnaz7wYhyzFQQaX4nOtcTSKOyJvQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786232335;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=OJ5d9j6DEQdw6HdiH7WUC04u8kfXqlaWiSxWgRDLjZ4=;
	b=h/YQB2n+40tXBayt5fZ1uOONO2YOhW4ZQ5X8xStOsAuWvBEn/6/7QgdXSNZGh4scpUQJ
	 ytopQ5D7MTDAAs8U1zsx6TRapBPNNngKk17cdRtt7pxcEVeV0aDJyIQyxIrGQuTnyjgL2
	 X2uHG+rIremIO/D669IaIIV49N0MRD52Kpv+HEXuuzaxBf/jy7/twcc32yInvUeCyEt4V
	 H8cWxInJB0ufpSj6FUF/TPf7BzlRvihlwxxW4ej885zR7n4jIxdyV41C+0lRU+12RNVzJ
	 xnhOztnalcjTRl/24HyGP9Q38eGlpmrVkt9/mR9OGzBkc6eljqg7N0QHIfa/vYqWvoA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 1F35BF80153
	for <alsa-devel@alsa-project.org>; Sun,  9 Aug 2026 01:38:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1F35BF80153
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c9f8d7e8a01600-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/827@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/827@alsa-project.org>
Subject: Add Arturia Audiofuse Studio to USB-Audio
Date: Sun,  9 Aug 2026 01:38:55 +0200 (CEST)
Message-ID-Hash: Z5HBR72VWWWTSIGUXGT64JYANWUNKSVF
X-Message-ID-Hash: Z5HBR72VWWWTSIGUXGT64JYANWUNKSVF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Z5HBR72VWWWTSIGUXGT64JYANWUNKSVF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #827 was opened from lexfeathers:

Hi there! This PR adds the Arturia Audiofuse Studio interface to USB-Audio.

I implemented the patch written in this issue:
https://github.com/alsa-project/alsa-ucm-conf/issues/568

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/827
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/827.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
