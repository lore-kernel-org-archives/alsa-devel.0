Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C4BCD98E2
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2026 13:03:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6B7CC601FC;
	Wed, 17 Jun 2026 15:03:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6B7CC601FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781701423;
	bh=+ylFSe3s6CkHKDcCk69Wv0wYeEwQn1AFIcGe99aeAro=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=dMw0xUjSykos5V40q2ff7ZNvseNzFfi4VdcNcdNSHzpjiel4JF5C7QONiy5n5ffc/
	 X/AD3FOtxfBNQnZqQYoo6oCH1nB8dZWZ5TQl6FOXyfTbq0eMZH/XAVHgF3Kr88lqNf
	 ujNNYM5LXiIy1YWYUcTGlgHSojYBgiiHZRzDiuQQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 620DAF805FA; Wed, 17 Jun 2026 15:03:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 25A36F805FB;
	Wed, 17 Jun 2026 15:03:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7BB01F8055A; Wed, 17 Jun 2026 15:03:00 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781701379;
	b=Jk/+nN46hFqK9T1tYE96MdGcal0jtDoB989njB6HoTP8q5Z3SqdcZk6YQWFDGnfljcSM
	 hBmEVDhYbWpWaK+9XUJWG/BND5KYfJHWyDItaON0eLOTtsso2vcy25KquQJpfPx90xWLX
	 vFKNqf5WnXE4XakecIUOiPHdNDHK2n2T8skh7DGraFIGJtcCO9o8BQv3uSEzRuyYiOZbP
	 UfO9v7gVow3TSylWxaSsEPzAq760Jqx8aPnZ+jEEDoUe0FLwDOoWcLmRDtvwY8oTO/zVK
	 4evvNffsQ+Qty3BQJreDJk+Ie/nKW3Z2ItlJIpHYnppT/+PzAxSEJRAa478aoFZfKUQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781701379;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=+ylFSe3s6CkHKDcCk69Wv0wYeEwQn1AFIcGe99aeAro=;
	b=kcVOnFJZnad6tBE/Wg6ZWRbHwbqvYiobpSso5S3VxI+SKm9PX2bsCZQbeeEPG3IUbPWc
	 Q+/RQg9xjzgDG7kNmfqJGVcKEnzSqps9iYw35B4WdCu8XGUjcv+WEqTW5t2SU9SrXAkxj
	 0DaDzhYSCF4WvV5xpBRFcGVwJUuyMUBjmkMe/cDuQE/uSkjlxkx79LtYtnZUgcE+5DVRp
	 1WjTpojOKdVuJCeEQmgaYbbc8XwMBIT1AfvKvPX4IOx5SszqmDt/XBNJqgcCkwtphaH22
	 MtPWH+OoGz2gyuuXGByXj40XtEOC1fVDRBs9X/rq2oCxAnITvOc7eeW16lpcBFVbe1w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 8ABBCF800BD
	for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2026 15:02:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8ABBCF800BD
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b9dff6a3495b00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/793@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/793@alsa-project.org>
Subject: ucm2: Arduino Monza: add display port audio
Date: Wed, 17 Jun 2026 15:03:00 +0200 (CEST)
Message-ID-Hash: ORROKJ3Z7EQMBN3DG7VVG7Q7YHR3DM6S
X-Message-ID-Hash: ORROKJ3Z7EQMBN3DG7VVG7Q7YHR3DM6S
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ORROKJ3Z7EQMBN3DG7VVG7Q7YHR3DM6S/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #793 was opened from Srinivas-Kandagatla:

Enable Display port audio on Arduino VENTUNO-Q board.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/793
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/793.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
