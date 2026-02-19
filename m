Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E79DE9A04C
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Feb 2026 09:09:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB4676021D;
	Thu, 19 Feb 2026 10:09:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB4676021D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1771492193;
	bh=XG6n9mTfk8RKfrgytEtLNMxoSg2GWWxWpkO6fbIr2P0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=WwYkgN5BO+klzJUcSP1hmAX/SEhMnLqWiTsuIBHpNswrcl1yWoifAxh/gahkuSQmH
	 sITIYXVBblYrqVrxItmBf29UpB1S9BLQxYq1rBYmpVkVGIjtO+fbBi6yJhLvk7sLrt
	 iCDfzGF0vFQf2788tZMmiguu5DD8I5xAoEQqIpco=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D6664F805F2; Thu, 19 Feb 2026 10:09:25 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 28135F805F2;
	Thu, 19 Feb 2026 10:09:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 11ECFF804F2; Thu, 19 Feb 2026 10:07:02 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 8EB64F80153
	for <alsa-devel@alsa-project.org>; Thu, 19 Feb 2026 10:06:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8EB64F80153
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18959a9aeecdc900-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/707@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/707@alsa-project.org>
Subject: ucm2: tegra: wm8903: fix headphones conflicting device
Date: Thu, 19 Feb 2026 10:07:02 +0100 (CET)
Message-ID-Hash: IEGWUFNYK4W35HJA275XP7CTYJ3L42BU
X-Message-ID-Hash: IEGWUFNYK4W35HJA275XP7CTYJ3L42BU
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IEGWUFNYK4W35HJA275XP7CTYJ3L42BU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #707 was opened from clamor-s:

Fixes: ea7a065 ("ucm: fix SectionDevice identifiers")

Please refer to this pull request for more info https://github.com/alsa-project/alsa-ucm-conf/pull/563

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/707
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/707.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
