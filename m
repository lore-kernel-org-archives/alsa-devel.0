Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C1BCA9ED1
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:39:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F3DE0601FA;
	Mon, 12 Oct 2026 16:39:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F3DE0601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791815996;
	bh=LNliqDiKjt6sWhot2HYaYckfvEBGwkMROnltRf1Qp2I=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=H3bnepzuZOWuWKIlrzagJ7O0FgxnnDHxm4eV8hdL9MvHWPNUnethCHkbk8IzTjb/F
	 zi/HYcJBYr9zMW8rJMDGEXk2536P4ZA0UTv1X5XBqMNJaAximQObogtWiipHjZZHPk
	 ht1r52HDE7kzsdeVQxxo2fiGhKe/11XkCAcvFmIg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EB24FF805FC; Mon, 12 Oct 2026 16:39:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F9C1F805F5;
	Mon, 12 Oct 2026 16:39:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 14B99F80526; Mon, 12 Oct 2026 16:39:18 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791815947;
	b=j0RW6BU0981M3HWyaxZPKBO4j//CIwvjJNITs8ekaoz5FLZUQU0v94tW/In1jvjpI7a4
	 4dJjuFZBSkLcDpQFNx7/3udb8XNcraHCbCXLt0OWcQl0hnN0msLXQDQgIm8I9adjTDhmF
	 iCXKRK7m2U6jhbx+PudK5fyyaxYFBYZ2lawXwhxg1S7hUzJ+Xq/Y5qTvvZnWGr7zmnhQ2
	 xkxJU9jAOBdLOTlGxdONfN001BFMDVfbvHaPEspj9w+YPntlF5IgTTJt4K60n2mfXuTef
	 v0fQSRRrivU/hxhaYJ7A8ekhUwuVQyj9/hoJsuIpMCXZ6Z6bZOrqlB7dCwhe/tkeT5g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791815947;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=LNliqDiKjt6sWhot2HYaYckfvEBGwkMROnltRf1Qp2I=;
	b=DP1/dPj60vL9at6Xi1jJZhCU+6hPLtg1VwqAwDwUXqERmQQUwlrDnptta1Ua00L/5X/j
	 HdKzvyQmMTnOxeWJkk/DswMtk1pqSBfT/60qngHdFX7m0MfEZqbuRVNEHX9GUDsZtzKX9
	 04UBqnJgMh7hxPM6k+FICOSNkCm9pB9XDnxNz2ZoeDOlWG/CW21Uhg5muolu/xWxXUifq
	 wyUDi1eGfqjeIMYWd2KDXRiSC3eJHyg7jS++w1ykusWC49weGuDG6uw/Fb3AWRdZYOkoN
	 DUGJv+IBUxEO5n7qow52rjTulqBtluzcmxheL3SLaKa41a+3suLZIA4BQ+1/xbjpbUw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F905F80495
	for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2026 16:39:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3F905F80495
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18ddcf1bebadae00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/531@alsa-project.org>
References: <alsa-project/alsa-lib/pr/531@alsa-project.org>
Subject: configure: update to modern LT_INIT options
Date: Mon, 12 Oct 2026 16:39:18 +0200 (CEST)
Message-ID-Hash: WQFTN4UQCBI2CTCB7IJ62WGLR56VOWFH
X-Message-ID-Hash: WQFTN4UQCBI2CTCB7IJ62WGLR56VOWFH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WQFTN4UQCBI2CTCB7IJ62WGLR56VOWFH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #531 was opened from Hello71:

the migration of f7779c2a62 ("configure: update to autoconf v2.72") was incomplete, _LT_SET_OPTION is legacy method and doesn't work on slibtool (alternative libtool implementation). the supported libtool versions are same, _LT_SET_OPTION is due to autoupdate limitations

Request URL   : https://github.com/alsa-project/alsa-lib/pull/531
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/531.patch
Repository URL: https://github.com/alsa-project/alsa-lib
