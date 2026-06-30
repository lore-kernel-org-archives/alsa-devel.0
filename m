Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6A3C43327
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Jun 2026 16:58:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B524060219;
	Tue, 30 Jun 2026 18:58:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B524060219
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782838711;
	bh=/uKtP1/Y5P+HQyVZFs4qojRei6GnaQg/z46FIwyb+pE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=GwdlkSnq4f1V577bn9veBB41iYfXZJQbYOuNW+WzNMz12KfKYRIeRfRCHRbZO50kD
	 I3AdpTzFhGo/BSH5Xa2n+5JjfoUW73dSKu9ybHmTPaHXTgdajxTywcJRBdew1dniXA
	 6Q5bPNHrf/u3Dmokr94O6HtZeulHyXywlQ8tvGyk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D2C4FF805F8; Tue, 30 Jun 2026 18:57:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 77150F80601;
	Tue, 30 Jun 2026 18:57:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1F30FF80587; Tue, 30 Jun 2026 18:57:49 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782838668;
	b=YB7cahuluaw/Kh0tw+N4oZBSlAqc+zKMLX46DAGG/u1C+2JesKJKFIrS3NXrza4BpDC9
	 eP/7tJaFqFtYRYhqxnsNc9hflRDRI1C+teaTRzDKq58tgEL5XLlxGqxLl2tgoESzIzONY
	 TyW/JCeToSa8ElDud8b8xnPHe8E9u0hiYzrdlJ+fb3NCWcy1Y7aPGJohsH4FV8xYSz3G2
	 4sKmFW52j5tGqz5ZiH1be7R/xHEpWL/esWqKNgSi1NoaWoessktNZRIHusN64nr3tVJnj
	 byXr08thp4cVxcZP9qwotw8w83WKoe4EM4Pa9IvqmixHdQFuL9qWLOIWiMB4Y5nRIWQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782838668;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=/uKtP1/Y5P+HQyVZFs4qojRei6GnaQg/z46FIwyb+pE=;
	b=Qg0nikcOavl3mQfqm71cM27EcfJBAuxC61X+tJzvsHgKLpN0VSjWMeWNN7hAFuJi88Y8
	 7F1JwQL45SaIJip0fHFRz3hXat22Up2pnj4Irtsvi6sQPKW9yB5KsfVRbR5qeFszfPD+v
	 oY26YwQn72d104C1rIgGcfkLd6X5887NGeQBCLUsZnEoAhws+W0AuGSBhSlQPOlr7wwri
	 YQCJL+AFnxcVftpvzhSJM6gGDIkEdDKwg7dmqnydK5S+4KavpdE8IS1p10jcwUFhZNreE
	 2CzCjIxNNX6PMjMI5RWcwvOKthLAWvoJoF5xhYKHrrmIw3C6vK/FRLKEFGX9arSlDnA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 66258F80423
	for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2026 18:57:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 66258F80423
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18bdea5258902700-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/802@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/802@alsa-project.org>
Subject: Add useful displaynames for the ThinkPad T14s gen2
Date: Tue, 30 Jun 2026 18:57:49 +0200 (CEST)
Message-ID-Hash: SADGMRZ4JMVGWEKLPZWDT4NR6WTCOKWP
X-Message-ID-Hash: SADGMRZ4JMVGWEKLPZWDT4NR6WTCOKWP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SADGMRZ4JMVGWEKLPZWDT4NR6WTCOKWP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #802 was opened from WhyNotHugo:

The Lenovo ThinkPad T14s gen2 has three outputs, with generic names that come from the underlying audio device:

- HDMI / DisplayPort 1 Output
- HDMI / DisplayPort 2 Output
- HDMI / DisplayPort 3 Output

Add card-specific overrides for this particular Laptop model, renaming the first two to:

- USB-C DisplayPort Output
- HDMI Output

The last output retains its original name, since I haven't found any way to actually use it. Perhaps the dock (which I do not own) uses it in some way?

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/802
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/802.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
