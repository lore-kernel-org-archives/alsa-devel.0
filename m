Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA2FC83F17
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Jul 2025 18:25:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ABCEA601F8;
	Thu, 10 Jul 2025 20:25:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ABCEA601F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1752171924;
	bh=rJkn6UDvMpDnjeKfs+q8Opc7iHPgZAUeWNAEbk5hu4w=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=r3p9azcRNFEUQyIZS0oMLzji+Iyz9fjJRhlUv/0z168b1Po0WciKT9rGBkWnt8UMY
	 eEXOfDAFwoYjv7n6vZIPjwsOLohCXoCbzlzSuxt0HnTPdCa7NymyjBO/2+PbHKPIaq
	 kn71zmiF6Kbd9xzj76xTXQOFO86356IaRi2kGpB4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8A85EF805C8; Thu, 10 Jul 2025 20:24:49 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A37EF805C8;
	Thu, 10 Jul 2025 20:24:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7BB3FF80526; Thu, 10 Jul 2025 20:24:40 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id E828FF800B5
	for <alsa-devel@alsa-project.org>; Thu, 10 Jul 2025 20:24:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E828FF800B5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1850f709ff42f600-webhooks-bot@alsa-project.org>
In-Reply-To: <1850f709ff104700-webhooks-bot@alsa-project.org>
References: <1850f709ff104700-webhooks-bot@alsa-project.org>
Subject: Realtek ALC897 - no 5.1, 7.1 surround sound
Date: Thu, 10 Jul 2025 20:24:40 +0200 (CEST)
Message-ID-Hash: RR3QXNAFWX7HVGHTGFDQJQCEULJUGQK2
X-Message-ID-Hash: RR3QXNAFWX7HVGHTGFDQJQCEULJUGQK2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RR3QXNAFWX7HVGHTGFDQJQCEULJUGQK2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #590 was opened from tomaszdrozdz:

Hello all.  
  
In nutshell:  
- I can not set 5.1 sound on my Fedora.  
- My sound card is Realtek ALC897.  
  
First I described it here: https://discussion.fedoraproject.org/t/5-1-7-1-sound-speakers/156932/4  
Then here: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4788  
And so I got here.  

If you need more info or action to be taken from me please let me know.  

Help, assist - Please.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/590
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
