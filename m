Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4689ACA6011
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Oct 2026 17:18:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1E549601E6;
	Thu,  8 Oct 2026 19:17:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1E549601E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791479884;
	bh=FE/Dw96fnjwsP+WenqVLHk0Misr7L1HT1QR7o67IcNs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=YTf/CKzlWCxCHn34fUbPqYQ4l3zV5YmABGqey7To5fM2+AQ662MxnX8XTqNy9LP7v
	 GhQANDunTX9ii6SG9ph2KH22LocBn2X6Ra/XUlKEl2WMpHJL+073IL3TFc+8LSN5QR
	 4IbTad7ov04E1Iiu3itsblqlAjDjmyTmwa0EqVTM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D32BCF805FB; Thu,  8 Oct 2026 19:17:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 845D1F805EF;
	Thu,  8 Oct 2026 19:17:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AB0FDF80571; Thu,  8 Oct 2026 19:17:24 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791479844;
	b=mTgTsERttzrPRzsMaZAztR+vIwC/RJDD3Q8U2pnKHz7OTIMynFobNwDXWjSv6J0pu7fc
	 7qfmeIoWCr5AdE8i1K83lCp3qVRusxdzrereA8grGN2jHexVRYl9xSw5Cl3nBUGjpZvGy
	 O8wUc+xYNLYHXdoNN2l2oUvglAcd63hwALD6N94mhrDS1zJ5rp8tBtKH7XkP4Z+dzMjz9
	 +yPSHYEYVHKeWc5b2kl3EZzm3esn/bp7eHxgZXUgLYvA6NQnj6b5vcM4lMj/7Oz9jX1bx
	 O62wKzX1jES7INzutXObzmYTGaEYHFWLmcGBohv+ayTkmLnhLq9xbQ5Oz0gLnIZ+A7A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791479844;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=FE/Dw96fnjwsP+WenqVLHk0Misr7L1HT1QR7o67IcNs=;
	b=DBMu8d+aqh5qa1R6PNPentvezzJvUJJJzmCySF/EHYDXCUPFrk4dGEq/RcuW/xWncrMh
	 I0GlfXY3SF0d5wpGZ6AdW3PYAK3OLNJiI12tRxaWcqteClYDF32ztOtt75h/2DNkBITi1
	 56B4RFKlnkopc/0GewfIH7GHLTpSutwywCdad8kTEGOCfAxPBLYecoMfyczrpz0CpgyZm
	 XdDnaWRrwX/z2cYOmAG9p+sAN9bImoGFLz9vCCmM15OurJID8+N+aUgUYx0dXr5qNycPE
	 sWv2Bvxbvl2FaOfwDHDyXL3nICfPI7MSLsu6QhMJ5zmFidEPFxcUIckWTJw0S3MD/Ig==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id F1C7CF8007E
	for <alsa-devel@alsa-project.org>; Thu,  8 Oct 2026 19:17:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1C7CF8007E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18dc9d6cd2966c00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/868@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/868@alsa-project.org>
Subject: Add UCM2 configs for uboot variant of the Qualcomm variant Kodiak /
 Talos/ Lemans & Monaco.
Date: Thu,  8 Oct 2026 19:17:24 +0200 (CEST)
Message-ID-Hash: YXMQ3IPLEESYL773RMAHJE22CWFUQSRE
X-Message-ID-Hash: YXMQ3IPLEESYL773RMAHJE22CWFUQSRE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YXMQ3IPLEESYL773RMAHJE22CWFUQSRE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #868 was opened from kumarsingh-art:

Add UCM2 configs for uboot variant of the Qualcomm variant Kodiak / Talos/ Lemans & Monaco.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/868
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/868.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
