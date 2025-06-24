Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD372C77B7F
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Jun 2025 16:55:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DAF4C601F5;
	Tue, 24 Jun 2025 18:55:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DAF4C601F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1750784111;
	bh=HWR0877jkQ9z5kEpORXQ6XQtW7TvQJ+mr+SkBRLcslE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=akiMt4MXar+jogoMq/MFBQ5UrpSi4mz3OKTHoPNgkbAoK9m15QGCUxz+mwQNkzdU1
	 e82mYTOWifiLMrM8Irt2QRMkUBWb0kLftb9bcSLO/Z5FTgYHA0vg7bDCgfSHymkaTs
	 7lc/Xit60aFFHevLHh7J1ZdF2WLd+dDLp4Wfch3c=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 97D10F805C1; Tue, 24 Jun 2025 18:54:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A5ECF805C9;
	Tue, 24 Jun 2025 18:54:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 86626F804CF; Tue, 24 Jun 2025 18:54:34 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id C75B8F800F8
	for <alsa-devel@alsa-project.org>; Tue, 24 Jun 2025 18:54:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C75B8F800F8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <184c08d676e93e00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/584@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/584@alsa-project.org>
Subject: Improvements to Steinberg UR-44 device support
Date: Tue, 24 Jun 2025 18:54:34 +0200 (CEST)
Message-ID-Hash: TNQR5W55FLI5TX6KIOSA7N32TVYPKHAG
X-Message-ID-Hash: TNQR5W55FLI5TX6KIOSA7N32TVYPKHAG
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TNQR5W55FLI5TX6KIOSA7N32TVYPKHAG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #584 was opened from peterix:

- Relabeled the inputs and outputs to make sense considering the device's physical layout and internals
- Added one more USB device ID for the UR44 (0x1704 is a non-C variant)
- Added stereo inputs in sensible combinations for the various inputs on the device
    - 1 for inputs 5 & 6 in the back
    - 3 'adjacent ones' for the 4 inputs in the front
      - 1 & 2
      - 2 & 3
      - 3 & 4

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/584
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/584.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
