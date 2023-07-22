Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2ABEB64DC
	for <alsa-devel@archiver.kernel.org>; Sat, 22 Jul 2023 15:44:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D579F1F7;
	Sat, 22 Jul 2023 17:43:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D579F1F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690040671;
	bh=1tEmdQkJ9dWaa4q9Y4MesVMfXIA6sKjkNtHdcvMqWDk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=to4zvdifBE/3UtODO5OITLgT5P5p5BPn/ObgFDEkdW1qz9hT8tGs9JwSUXuJFbQPK
	 mqMSYETvwX29ZbiQB7Vyx8b5DYgsf7zorP5hv/Xcua1GF3kt6eOmDh+jdMIOQLns/C
	 XX9ruv8vFA/2G0BIuoaRqwTVGKafVMbO/2WEPHTE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 929F9F8027B; Sat, 22 Jul 2023 17:43:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3CB38F8027B;
	Sat, 22 Jul 2023 17:43:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D2677F8047D; Sat, 22 Jul 2023 17:42:05 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id AB496F8007E
	for <alsa-devel@alsa-project.org>; Sat, 22 Jul 2023 17:41:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB496F8007E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1690040518427653074-webhooks-bot@alsa-project.org>
References: <1690040518427653074-webhooks-bot@alsa-project.org>
Subject: alsactl: add define to compile with glibc 2.38
Message-Id: <20230722154205.D2677F8047D@alsa1.perex.cz>
Date: Sat, 22 Jul 2023 17:42:05 +0200 (CEST)
Message-ID-Hash: O2IJJ77M5CYHDX24VJK3PFME3KEPXL3S
X-Message-ID-Hash: O2IJJ77M5CYHDX24VJK3PFME3KEPXL3S
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/O2IJJ77M5CYHDX24VJK3PFME3KEPXL3S/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils pull request #225 was opened from heitbaum:

strlcat and strlcpy have been added to glibc 2.38. update the defines to use the glibc versions, and not conflict with string.h.

ref:
- https://sourceware.org/git/?p=glibc.git;a=commit;h=454a20c8756c9c1d55419153255fc7692b3d2199

Request URL   : https://github.com/alsa-project/alsa-utils/pull/225
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/225.patch
Repository URL: https://github.com/alsa-project/alsa-utils
