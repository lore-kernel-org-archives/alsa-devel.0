Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDEFCD6E74
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Jun 2026 09:50:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E82DA60275;
	Fri,  5 Jun 2026 11:49:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E82DA60275
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780653004;
	bh=l6Fen++5mzzZEQ8QeQf3fylwv9uoEiDZzpPM5lRjve4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=B3VP0wUrTYp0oyXvt45W79T3hG0toCMMK44v0szGzUjOaUhKyaIIn7qrjgKr2NXhK
	 UOO6aubSv8EtQO385A9fcljbRX5iKmFXFJYluha0e6yp/mZ29Hemi+oITW3CC9vhQf
	 k8fy2cTPSnqMon3f3HuQvrlBMkdFZmL1Wkpy/mrs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6C3F6F80607; Fri,  5 Jun 2026 11:49:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B56F4F805F8;
	Fri,  5 Jun 2026 11:49:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1571DF80557; Fri,  5 Jun 2026 11:49:34 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780652973;
	b=Q3HcFLEPY4VWlUOCthe2uJnbdyAxtoGQJuwmNSCrBNNvDYF9coYZHutdu8lBzMXqQxRH
	 we16Ktug4N8dneQP309IfEiUbGR0eqCxCFlwIvvcoogmiYvdXQLQaNk7cZMBgZVmP5Jl1
	 DPQDDSvE/+MltQ37sU+MBVNJpnsRrn3O4IHsCDp+FnHWzrwSx9pRrHvRrUtVcKi4e2PN7
	 vMAgdnV1yoWigl5n/ajXU39kUHwoetxVCUyyWTBn066b/bCF5vz4Op1CBVCSzEAegbVuv
	 pe9UoXRnjDkDdrB9L79cbUG+pooEtysSdpFNRrvhSIHj6niQw/AS7ojjLb7WhjPVb6g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780652973;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=l6Fen++5mzzZEQ8QeQf3fylwv9uoEiDZzpPM5lRjve4=;
	b=eqj6fXHrWyMvcHiCrJ6gfUwXmjAmJxS0+saW+Y8H0SHYUFWw7rG+jUcgcr/pA6EmhY1x
	 7P1ZzD989beb8BgMHqracTc+ZLkB435JYTBJJUZwaQFruRVZ6oHTTVLFgSXHuasaVaFKJ
	 ICLbYPUvBC5D6krP4eE6OGKrJrZ4sSUellr163Zwyb1wASx1wwkEP60bMgOse86intTJo
	 p+w3948DLvG66WtjW3dXBqvtZ6YUFdQBB36gGHxBbsZqH3xTpK1pDfhY+VIxEvvr1SRZn
	 dTXKQc9o5WcbnUnFmymrHky8kuiUipopyh3fH1S50Kz4qYMnca+9FmIDh5rdYNIlyBg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 55CC0F80217
	for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2026 11:49:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 55CC0F80217
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b62671a7e81e00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/775@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/775@alsa-project.org>
Subject: sof-soundwire: cleanups for codecs with multiple functions
Date: Fri,  5 Jun 2026 11:49:34 +0200 (CEST)
Message-ID-Hash: X7OS3CJXH2BO5LAIU5DKPEHXV4XDIZTB
X-Message-ID-Hash: X7OS3CJXH2BO5LAIU5DKPEHXV4XDIZTB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/X7OS3CJXH2BO5LAIU5DKPEHXV4XDIZTB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #775 was edited from perexg:

The load mechanism assumed only one multi-codec in the system, but  we saw in #774 multiple instances of those codecs (rt1320 and rt713).
    
Make the load mechanism straight:
    
- introduce file variables
- remove shadow variables
- probe multi-codecs separately and modify the file variables
- test for duplicate file inclusion (in both sof-soundwire / HiFi configs)
- merge dmic configs for rt712,rt713 to one file
    
This change also removes filters for speaker/headset/mic init includes. The file variables + multi-codec probe replaces this functionality and if the driver reports an "unknown" codec, UCM config should be updated anyway.

Link: https://github.com/alsa-project/alsa-ucm-conf/issues/774

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/775
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/775.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
