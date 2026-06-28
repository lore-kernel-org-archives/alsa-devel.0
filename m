Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE0FC43458
	for <alsa-devel@archiver.kernel.org>; Sun, 28 Jun 2026 17:21:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F714601E8;
	Sun, 28 Jun 2026 19:21:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F714601E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782667285;
	bh=DPs6iFzfuqoKeIcky32/eGAqMZ6u0Is9QmmdkqeNhdY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=E0GVRx6drfim204Kw22Zknt7y8Sl4So2SON5FDmoMB8AEWaBbeEabzNWt5nOI7vd2
	 niG/BPtHG3bmXtPZZvyGQP7G3tmxc6v8gZAc4BT3K68tbsbxSWwRfA7SL6zJXCsf/z
	 qGepDr/Q4KVwATzcauysO1U+Gpa9CR0g480nNwhg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DA84CF805F8; Sun, 28 Jun 2026 19:20:49 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A1E20F805FA;
	Sun, 28 Jun 2026 19:20:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CAFCCF80548; Sun, 28 Jun 2026 19:20:42 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782667242;
	b=BnLgQWZhe7e1a0sP5Wa/MCC28/tbq64YA9NF7d4lQLSWKJ7f6wxJlM0LjwLknpwrDkGS
	 CMkA9uhFA6HdfougGriMMPpeEvcqTmu+lgtRozS9379pIZNi3KJ+VKmtIypcfOxbGQd7Q
	 EccaxU11Y7OGph6oS1s/2MGoVO+MFsnPKkEGTi7CoDIwQFIBezrVVNIbnEXaKqPCw0SN0
	 NbSzkAP8L9wH24TqpRtsygi5SlMDAO476Y0FJV5wEDD1XNg86SERJtWJocSD+4bxMbO4c
	 wo7oH4Gd0RnomM1YYqC/ShlIORR+O/PorluXmnXyXTmsTSgE1FtxEkgF46j9aTG3pPw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782667242;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=DPs6iFzfuqoKeIcky32/eGAqMZ6u0Is9QmmdkqeNhdY=;
	b=q7St0GsDZ4b0HIRG0mNy7nEaeBJeqsrHQIiIs28dDgUYReptWNCQhpJ6GCpLgoPhvDgM
	 /u/LE0YBwWNhsGQJDqtwxvSJ1oBKuA6g3EpAu4agzgeTdEoxrLBp3OwW03AVk+i8+Z6hB
	 xvnjNx0A/Fr7m/92uDXPn0A3IGsarIC0oGwq7B0EfXKsricEet8nLRCwLEec9lorlV7Dz
	 Cl/vZspwmxrtw9ChZPS0bPD5HfjUxfbxAlOYt7Z/dhJYKn+sxyh+ZqVMVOz/3MnlFcSuy
	 2c31vEYwZ20qpd1CTM/Hx/CG0HVW/ztldRETWEVFOnzYTrCCaIJZbT2Skds+vH11C2A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id F1534F80495
	for <alsa-devel@alsa-project.org>; Sun, 28 Jun 2026 19:20:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1534F80495
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18bd4e6909fbb600-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/798@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/798@alsa-project.org>
Subject: USB-Audio/Focusrite: fix 18i20 gen1/gen2 digital capture input
 mapping
Date: Sun, 28 Jun 2026 19:20:42 +0200 (CEST)
Message-ID-Hash: XEYDEGGJWYE5EAP3TCG72VBSN4SPV6TU
X-Message-ID-Hash: XEYDEGGJWYE5EAP3TCG72VBSN4SPV6TU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XEYDEGGJWYE5EAP3TCG72VBSN4SPV6TU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #798 was opened from amplogik:

The 1st/2nd-gen Scarlett 18i20 expose 18 USB capture channels, laid out
as Analog 1-8 (ch 0-7), S/PDIF 1-2 (ch 8-9), ADAT 1-8 (ch 10-17). The
3rd/4th gen insert two extra channels at 8-9, shifting S/PDIF to 10-11
and ADAT to 12-19. The HiFi.conf only ever encoded the 20-channel layout
for the digital inputs.

A recent fix worked around the resulting out-of-range error on gen1/gen2
by shrinking the ADAT input to 6 channels (12-17), but that is incorrect:
gen1/gen2 still have all 8 ADAT inputs (they sit at 10-17), and their
S/PDIF inputs are at 8-9, not 10-11. The previous version therefore
dropped ADAT 7-8 and mislabelled ADAT 1-2 as S/PDIF.

Make the digital-input channel indices generation-aware via new
SpdifInCh*/AdatInCh* variables (default = 20-ch layout, overridden in the
gen1/gen2 blocks). Both layouts have 8 ADAT channels, so the conditional
channel-count split collapses back into a single Direct 2 device.

Verified on 1st-gen hardware (USB 1235:800c): the capture routing
(Input Source NN Capture Route) reports Analog 1-8 / S/PDIF 1-2 / ADAT
1-8 on channels 0-17, and the profile now parses without UCM errors.

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/798
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/798.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
