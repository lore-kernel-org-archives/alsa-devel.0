Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D5DCA9ED0
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 00:39:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF25460207;
	Tue, 13 Oct 2026 02:39:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF25460207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791851970;
	bh=zVMvECCfVxBgQifIZVIv4s7X81U9+RQyxpNNXUdcUZg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=oGJVv2Uu54AXGElW8J9NYP2p3Dpd3iua9QPZyhoCDHp6E7598WC1fsZSN5bCMIbLS
	 CE+4FfNQ1zZZ5mqKOpHpxMJqKM8jZzXHtlzdonAfiPmkfixl5A87zf4o7PZfOpxR6o
	 X1VOcaHKKB9ZwrvcllzjKFauxnT8L333A3M08NSw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D05F7F805A0; Tue, 13 Oct 2026 02:38:56 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 45677F80601;
	Tue, 13 Oct 2026 02:38:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 45F2FF80548; Tue, 13 Oct 2026 02:38:48 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791851927;
	b=RVc5wqnJLQUsW7EtkEj1bmqmRYiXj6SZFaTa2tegD9RbSYEgHewLhFBge6sCcNOzi4v/
	 6awUv078tRVq0AoKg74y2VBnaNJVFDFV6Bn79R1UpwHMBBl7qix1p9uQNTBtPmXO0ZuE7
	 Grwb0u5L/oLVfoiejuiCBrJQwWA3JljXVef3YDUA6MfKWq0Xp9o64lkI7FSRQZvyh//m6
	 hXXU0MRsfWmxyWJCrcouvwzz98kw7+CEat4Kn0D0fsQNELemyHXvI7lGrUCNEXhgpHaKN
	 bWexAHy9GqyGQzA06sFXyZIEKkGBBwAYYKSh9mwqjPvEYOb8kXwwNidLQHM9taFFWGA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791851927;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=zVMvECCfVxBgQifIZVIv4s7X81U9+RQyxpNNXUdcUZg=;
	b=FT74NYMdJRUNIVnxfTuIOruLfYeWFb5ouJQQFB1TLj+Niy4kTn9CMG4WP1Qan5hdq7hc
	 c0ntlgCjYENOTsr/9xDb+gMpCaqC73wwpfxx1lxB1QXJ4W6a1EO2TNBjW7vcpSYAlvh/e
	 THlVsIBHQK5flFAAtJdGNeYRis8zbZLaaAILdcyF93VleRkJn5Jvov8IcSDY946h2VRW3
	 CrYZYTenxSU0cUp6LNmYAO2ZlOdtWTfbgsdeTNvJO4kN84FRuC6kODCsO37VdOnZi/u97
	 QaA+t0Ndv7mhow8h/0VLOUVbjUEWFC6QH9PG5bsvW5JV6osBogqI5HhPR2xAn3M8yZA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 1401EF800EE
	for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2026 02:38:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1401EF800EE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18ddefd4ee6a1600-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/879@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/879@alsa-project.org>
Subject: ucm2: Qualcomm: Add Lenovo IdeaPad Slim 3 (15Q8X10)
Date: Tue, 13 Oct 2026 02:38:48 +0200 (CEST)
Message-ID-Hash: EQM5SYNLTQK65BO4FV5LHHZEBA6A4WSC
X-Message-ID-Hash: EQM5SYNLTQK65BO4FV5LHHZEBA6A4WSC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EQM5SYNLTQK65BO4FV5LHHZEBA6A4WSC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #879 was opened from polkorny:

The Lenovo IdeaPad Slim 3 (15Q8X10) is a Qualcomm laptop:

- 2 Speakers
- 2 DMICs
- 2 HDMI/DP ports
- Headphone jack

Add support for speakers and DMICs for now, as work is still pending for the others.

- Slim 5 DMI regex narrowed to avoid matching the Slim 3

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/879
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/879.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
