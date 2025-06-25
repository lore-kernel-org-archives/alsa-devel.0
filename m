Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E5FC7115C
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Jun 2025 13:25:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 72018601F4;
	Wed, 25 Jun 2025 15:25:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 72018601F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1750857943;
	bh=JjyY7GidpOoduh+ro/DeyTVkckNHmOs48k7Re4NyjoI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=H37pi++eqfhOXtObfznOanz+gf/74mhqz2+VqrfW4eRLNv5OAUT/4ZYqNTtJ1T7ip
	 SBnHD+rT0ji/UAhV2ATxtT2KAt9EQyBg9Vv15uOE8NvrdYmF+eVTvuvQPznw1TQQmQ
	 zVzPdRbiHxxpCCHX+EciOIOhOi73iH+XVRXi0yKk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1B6AEF805D6; Wed, 25 Jun 2025 15:25:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B8A56F805CA;
	Wed, 25 Jun 2025 15:25:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 61A17F804FB; Wed, 25 Jun 2025 15:25:05 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id AD95EF80236
	for <alsa-devel@alsa-project.org>; Wed, 25 Jun 2025 15:25:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AD95EF80236
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <184c4bfc8e3de000-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/585@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/585@alsa-project.org>
Subject: ucm2: codecs: lpass-rx-macro: move mixers that do not belong
Date: Wed, 25 Jun 2025 15:25:05 +0200 (CEST)
Message-ID-Hash: WYQSY2XIKVEOQMFCRIRSD2UM7ZPPDWH6
X-Message-ID-Hash: WYQSY2XIKVEOQMFCRIRSD2UM7ZPPDWH6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WYQSY2XIKVEOQMFCRIRSD2UM7ZPPDWH6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #585 was opened from Srinivas-Kandagatla:

Some of the mixers ended up in rx-macro which actually are part of WCD codecs.
Move such mixers to their respective codecs.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/585
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/585.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
