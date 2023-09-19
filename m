Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA06CD54B3
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Sep 2023 11:15:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 34D3DDEF;
	Tue, 19 Sep 2023 13:15:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 34D3DDEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695122155;
	bh=Gm4r3/LagDtrBc0Pi3hc438lu8qlQyEh0YJDVE3ZG+0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=NcJLmjF9zY9sCRPq9cgvXo2ektqE56e4SUIdT3akW9sV1t1NAG5tNI0j3Iwqu7TuI
	 aB3tjM4lcr0f03VQkFIIqL8DBEt4zJoMaLCRHqUKGIpgO+5PV03ghEIVnfze5+8vRo
	 dgpl8DvjbChMbemjuREn5ykT5l2lf/mUvE6QEbvg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8E750F8055B; Tue, 19 Sep 2023 13:15:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A2F9F80551;
	Tue, 19 Sep 2023 13:15:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1DE3BF8025A; Tue, 19 Sep 2023 13:14:58 +0200 (CEST)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::223])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C6604F80125
	for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2023 13:14:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C6604F80125
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=Nwf5X5/y
Received: by mail.gandi.net (Postfix) with ESMTPSA id E81C16000B;
	Tue, 19 Sep 2023 11:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1695122092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wvi+vg8mpIZUTS1xeOe1ah/JL0hNaPgNAGULoID+yRY=;
	b=Nwf5X5/y80upgFklSy6B45U2b5g/2LeFc+LvJDoslQMsuLZimMNm/dN6CYrGx4uCr4bqcL
	vJhVF2u6acCqDo7bCmAjlN7HkEqkOCDcjvAnVKkzDxikapFVPio08h2k/QcB6FWjmP+5EP
	PMmhu9RY71SeMstQLUtpOXVQKs0xhMbWxeyMRjaXlzsJ9I3MtJgcRsaxA3dD4/11RgyRYT
	6mQ7KNPMuTinh/uW7VDkfe0u/GYDbD+A1UlV1aCwvl+ex/vr0Zk65wUrDDdjcFfmbRjk5l
	Wq7YGnKTeE545o8FUr+z3ULNTEUQbIISRrJJQptw9h8Owcv8lo7rLSipM7CI+A==
From: michael.opdenacker@bootlin.com
To: alsa-devel@alsa-project.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH 0/2] fixes for the musl C library
Date: Tue, 19 Sep 2023 13:14:28 +0200
Message-Id: <20230919111430.2912326-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
Message-ID-Hash: UXWLOJSJLKCZSJQXXPLC5CG4TGIQJSTG
X-Message-ID-Hash: UXWLOJSJLKCZSJQXXPLC5CG4TGIQJSTG
X-MailFrom: michael.opdenacker@bootlin.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UXWLOJSJLKCZSJQXXPLC5CG4TGIQJSTG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

This is a series of patches to fix compiling alsa-utils
with the Musl C library.

Tests were made use the "master" branch of the Yocto Project
Poky distribution.

Compiling with the GNU C library (glibc) was tested too.

Michael Opdenacker (2):
  topology.c: include locale.h
  nhlt-dmic-info.c: include sys/types.h

 nhlt/nhlt-dmic-info.c | 1 +
 topology/topology.c   | 1 +
 2 files changed, 2 insertions(+)

-- 
2.34.1

