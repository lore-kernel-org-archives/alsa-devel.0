Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2708EC001DE
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Jul 2023 21:26:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2F290820;
	Mon, 31 Jul 2023 23:26:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2F290820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690838817;
	bh=6dJZWSBRR/dnfFbrqRijyELVF67Un5ZaIINbq8Vur3U=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=SXac2UikGR+ojw3Cs4mORY+wSR2RXR7+6bk+2YdtH4RYI/RQI81qW1ON5aDSZ+jcm
	 Snr0wvG4IrDJ7w+cG6B3reovelFGw7C2fSCNPjGdptrVV7UWVcbs7u4J4fo8uQgFEE
	 8oCTv1pC8xsuPwbrN9yajCh6R+f/GnOR1GeUrnUU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1499DF80551; Mon, 31 Jul 2023 23:25:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E2AFF8016D;
	Mon, 31 Jul 2023 23:25:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 979A3F8016D; Mon, 31 Jul 2023 23:25:35 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id DBBB5F80153
	for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2023 23:25:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DBBB5F80153
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1690838731879931688-webhooks-bot@alsa-project.org>
References: <1690838731879931688-webhooks-bot@alsa-project.org>
Subject: params_free functions don't work
Message-Id: <20230731212535.979A3F8016D@alsa1.perex.cz>
Date: Mon, 31 Jul 2023 23:25:35 +0200 (CEST)
Message-ID-Hash: VYYZAHTB2HG2E3X5ESPYL476WQV6VW7H
X-Message-ID-Hash: VYYZAHTB2HG2E3X5ESPYL476WQV6VW7H
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VYYZAHTB2HG2E3X5ESPYL476WQV6VW7H/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #341 was opened from imyxh:

The following code segfaults on the call to `snd_pcm_hw_params_free` on my machine:

```c
#include <alsa/asoundlib.h>
void main() {
	snd_pcm_hw_params_t *params;
	snd_pcm_hw_params_alloca(&params);
	snd_pcm_hw_params_free(params);
}
```

The same goes for `s/hw/sw/g`. Am I doing something wrong? In more complex examples it seems to fail with munmap_chunk complaining about an invalid pointer, or free complaining about an invalid size.

How are the `*_params_free` functions meant to be used?

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/341
Repository URL: https://github.com/alsa-project/alsa-lib
