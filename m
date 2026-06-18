Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F4BCD98F2
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2026 06:35:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6553D601EF;
	Thu, 18 Jun 2026 08:35:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6553D601EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781764543;
	bh=E0yWNhWDz81bdZYNzUZq93sTj/+QbZByQrrpr+8/MfY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=t3D50ybWIw8TQiSTZoA4Go0gPVCywMZaMchk6nNjtxW5YqQvW2jjt1dGURZ3jmiiV
	 p3Si4ctWCBQlS9nxDZfUZI5BC79kYucqvoWzwaSqE/FajxLF7hyKKSuNNXLGx+yAsq
	 urO+Ig4UaywuBG8xSbLn4sYlcR0aZ/520K/k+SYY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 27155F80600; Thu, 18 Jun 2026 08:35:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C48BCF80600;
	Thu, 18 Jun 2026 08:35:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3C1DDF80301; Thu, 18 Jun 2026 08:35:01 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781764500;
	b=VZd6NGMgQIvCOFTm89283cPCNoeJaIkoRS5LMAqdlngyJgjJijXe7qbS5uhC0Vv3Fuvj
	 euqIJH02jgNSdv59URaZrtVWvUna7DSkp+0x8PpdM/0Ww3rDgE4TAzObmwFWs85D3QC9O
	 f49RvqdDOF0aT1yk0c0NFfZTR2Pe1MIEYK3NpBOjJOkWxTOqEelmojUklEUjWr/qFMQPe
	 R+fTAOwb14T4fCwFqeUzSh8wzkL/4xAdVmQ0vnRWiHh2zwga0cqN0a1UX+6LHi4ENssi2
	 GsbUAbwKq21JlZwz4T2k1ZFlwmixIi6m+4Yb+utfJp5zz3oAybRAYOYXdMiHl8uccsw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781764500;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=E0yWNhWDz81bdZYNzUZq93sTj/+QbZByQrrpr+8/MfY=;
	b=Ru5+R1s3eWmTY9CAbVY4tYTrQEVGflZ7C27okZOteAJ+5KxeAdA7xD5p8j4NVHYQRw4K
	 U0d0EeSe2qGOU18Rb0KO6K/lijS8RQJTnL8DXqHSqNDK4tklnmyVuvQkwKbtaWtGlaHAV
	 ov62+xOHQcCCBsPYM88TBuuq/rhI++ek8mfzetKEhdNJK/zvYMB4jK7coTnbaEVMVYD73
	 TT4o9iBFfzjYPdDWfu7LpUyewTli2kfsmVuJQpviI9sBNRbMY7K3pTSUd4ovne+cpuHXa
	 wAUHOH5cJkFslLb+zlPYCFF1G/9Em7yaaWuOgg/5xitCpCXdc/eq2U/UkC2TzaNsukg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 5692CF800BD
	for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2026 08:34:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5692CF800BD
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18ba195f19776d00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/794@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/794@alsa-project.org>
Subject: ucm2: Qualcomm: x1e80100: add HDMI/DisplayPort playback
Date: Thu, 18 Jun 2026 08:35:01 +0200 (CEST)
Message-ID-Hash: ZDOXWB2LHKJZ5YUGRY2OCQMANNR4266L
X-Message-ID-Hash: ZDOXWB2LHKJZ5YUGRY2OCQMANNR4266L
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZDOXWB2LHKJZ5YUGRY2OCQMANNR4266L/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #794 was opened from QTI-Quill:

Add two DisplayPort playback devices using different frontends MultiMedia5 and MultiMedia6.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/794
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/794.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
