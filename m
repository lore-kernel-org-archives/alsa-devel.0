Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A926C7115C
	for <alsa-devel@archiver.kernel.org>; Sat, 21 Jun 2025 15:51:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 027EE601F4;
	Sat, 21 Jun 2025 17:51:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 027EE601F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1750521085;
	bh=l5VqUepQA/Q2IeSVnLJTqVILkmbuT4oFyVJ6agQN2mA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=DOAsHQWdlG0AjCtcyy0lO3VwJlkVapQfSFx545dvU2H044zn9sdtTLyqALjrSG65K
	 aGXjbsje9jbwL1iD5hA7kpB7G2cMcum79FBO/fz934rMdIu6cmn23gL5wUoA2UnQfc
	 1AnN8olf+kytjgjB2vHh45W2OtdrSs33R0+EoLqc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2F1ABF805C0; Sat, 21 Jun 2025 17:50:46 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 20819F805BA;
	Sat, 21 Jun 2025 17:50:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 971D9F80269; Sat, 21 Jun 2025 17:50:42 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id DDA3BF801F7
	for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2025 17:50:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DDA3BF801F7
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <184b199c940e4a00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/582@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/582@alsa-project.org>
Subject: ucm2: USB-Audio: Add Teufel CAGE PRO
Date: Sat, 21 Jun 2025 17:50:42 +0200 (CEST)
Message-ID-Hash: M4WND3J4AGXN2HEIYO7PMMVDGHYOJ6DL
X-Message-ID-Hash: M4WND3J4AGXN2HEIYO7PMMVDGHYOJ6DL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/M4WND3J4AGXN2HEIYO7PMMVDGHYOJ6DL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #582 was opened from hsitter:

two stereo outputs: one for "game" and one for "chat". one mono input

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/582
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/582.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
