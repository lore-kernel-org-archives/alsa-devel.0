Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54498C5DF81
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:57:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7EFF06029A;
	Mon, 24 Aug 2026 18:57:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7EFF06029A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787590638;
	bh=XVjwUb1PkNdKGvPZeJjRm0HNIBhYhIOomDuKg+hi8/w=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=UkyHkEO3AZ8lsVFQn9GfDlLkH7eRIRoHaaxI3qyXq675xfqTCUG1/JcvGYXWC8PMF
	 L8DXieWntHBxn2idgXdEo2oGrSOdN6pv1FYBwrmcuCdSoDiGa4YpW8zHpTH3nVAUP6
	 aWYQ1fMF0JFXnTm0uhmCduaBQtX/a/wR5xKkQN14=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D0E7BF805FB; Mon, 24 Aug 2026 18:56:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 448D9F80600;
	Mon, 24 Aug 2026 18:56:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 936EAF805A8; Mon, 24 Aug 2026 18:56:36 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787590592;
	b=OC/6xbDDTSGB5yjfmbYB2OM3HayUr11FvrGX7rc2s3lbf0UoUXy2h69Z2g6L66bxMgq9
	 gbTmq93inkqfJf3zSWkhMhvJOU8Ulp5sLp9VmCUZ2TjuKn8Oe9iu8FFavRM8Llq9TmxNP
	 zJBsegROVAfuRAhTl7XCamoizZHscXmk+BnzZrk+QfUUypsZ+2q28xQ8cJvTA6C9NwnoZ
	 t82b2XOom8l8kBDWyMRFIztf5gX/qbruPSOzDjWuA1X8Sn6SlhCj1OEIPpuAcRGR47K5D
	 7XItYMwUsFgKxkwb0AEHm9W9jCCc7I/+wRGRj7RoIbfpfbpgk7S+lXRJEntKVTt5BTg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787590592;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=XVjwUb1PkNdKGvPZeJjRm0HNIBhYhIOomDuKg+hi8/w=;
	b=SLhUpMOEVX4yGFSW3yNS3Was2fW7zwNP+3i58Ex6idPyXbRnQlsa2toKqCTy1JD5E02l
	 qXS6enG5zqIshRaMEkhoEelxcQ43oYWIfYKKevQ4yF2Hn3NL6lQR89lzPkr6cMgb2s21f
	 ylfMUvEwUEHNjbSJg74DnTKRsizBqRgdcKGTl+sIdCEmiN3o++joPJuqaAkgybL3osJsz
	 j8yC2zC5iCW+t9bMoZ2A06ZOfJ0kI85RmVL+zqVjDIW76nSHC4j4NVIq09U3i7ZA5KnEV
	 nM6y1MeFYoxkpUeIlVzD9BUCyZo/5UVGpWZOeDXQ34L78k4COwVE37otuTkTJxhsU5Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 4834BF80075
	for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2026 18:56:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4834BF80075
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18cecc2bc30c1b00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/837@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/837@alsa-project.org>
Subject: ucm2: USB-Audio: fix channel counts for SSL 2+ MK II
Date: Mon, 24 Aug 2026 18:56:36 +0200 (CEST)
Message-ID-Hash: FNP4L5CJNKO6ZY2SW7TBBCDEVKXXKHNF
X-Message-ID-Hash: FNP4L5CJNKO6ZY2SW7TBBCDEVKXXKHNF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FNP4L5CJNKO6ZY2SW7TBBCDEVKXXKHNF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #837 was edited from lofiwatercat:

Got an SSL 2+ MK II and hit the UCM errors described in #795.

#681 added MK II support, but the author had no SSL 2+ MK II and could
not verify it. The merged regex (`USB31e9:000[29]`) therefore gives the SSL 2+ MK I the SSL 2+ MK II channel counts of 4 playback / 4 capture.

The SSL 2+ MK II actually has 6 playback and 8 capture channels, so the
config describes the device incorrectly and the card shows as
`[ALSA UCM error]`.

[alsa_info.txt](https://alsa-project.org/db/?f=a322db1c1bb51cf1ab611bbba3a5900fffc846b8)

First time contributor, guidance would be greatly appreciated.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/837
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/837.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
