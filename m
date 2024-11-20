Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B01D6393C
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2024 13:32:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C3B7162D;
	Wed, 20 Nov 2024 14:31:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C3B7162D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1732109519;
	bh=B2SU5Hdd0AcR+ofdgNmA3FkKyF7TAndl+/WqRudhkvM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=JCZyRFscQ6tLhbBP1aRKgXp9xqQXocLXHHlYGUkbp5jnWfSnjUt6sZmZWB3Pq45hd
	 k6dmpQ7ZRyfZTveYKK0YRAr2uRBOv0nQjBz9FgXvPjVB/QAsKlOMGctVTIGWsHMWpx
	 BjIaT8DxoPVyQ+VT1kOnUC3vgkEJlPpMi0DBJMas=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 42E69F805BE; Wed, 20 Nov 2024 14:31:26 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7BA3FF805B2;
	Wed, 20 Nov 2024 14:31:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 38D32F8026D; Wed, 20 Nov 2024 14:31:20 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 7E0A8F80124
	for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2024 14:31:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7E0A8F80124
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1732109477818476439-webhooks-bot@alsa-project.org>
References: <1732109477818476439-webhooks-bot@alsa-project.org>
Subject: sof-soundwire: cs42l43: Correct CapturePCM and routing
Message-Id: <20241120133120.38D32F8026D@alsa1.perex.cz>
Date: Wed, 20 Nov 2024 14:31:20 +0100 (CET)
Message-ID-Hash: VO3OFQ763VAZP25V3TFHJM4M4TP6BOHH
X-Message-ID-Hash: VO3OFQ763VAZP25V3TFHJM4M4TP6BOHH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VO3OFQ763VAZP25V3TFHJM4M4TP6BOHH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #466 was opened from charleskeepax:

For headset microphone capture the correct PCM device to use is "hw:${CardId},1", "hw:${CardId},4" is for built in microphone capture.

Adjust the routing as well since :0,1 is connected to data port 2 on the codec.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/466
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/466.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
